<?php
if (!defined('APP_INDEX')) {
    header("Location: /");
    die();
}

require_once 'includes/config.php';

// CONNECT TO DATABASE ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function connect()
{
    try {
        $conn = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);
        if ($conn) {
            $conn->query("SET time_zone = '+00:00'");
            return $conn;
        }
        throw new Exception('Cannot connect to the database.');
    } catch (Exception $e) {
        echo 'Connection failed: ' . $e->getMessage();
    }
    return null;
}

$conn = connect();


session_start();
if (!isset($_SESSION['posted_messages'])) {
    $_SESSION['posted_messages'] = [];
}

// SUBMIT BUTTON FUNCTION ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function submitGuestInfo($conn)
{
    date_default_timezone_set('UTC');
    $name = $_POST['name'] ?? '';
    $email = $_POST['email'] ?? '';
    $message = $_POST['message'] ?? '';

    if (empty($name) || empty($email) || empty($message)) {
        return ['success' => false, 'error' => 'All fields are required.'];
    }
    if (strlen($name) < 5 || strlen($name) > 128) {
        return ['success' => false, 'error' => 'Name must be between 5 and 128 characters.'];
    }
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        return ['success' => false, 'error' => 'Invalid email address.'];
    }
    if (strlen($message) < 5 || strlen($message) > 1024) {
        return ['success' => false, 'error' => 'Message must be between 5 and 1024 characters.'];
    }

    $pstate = $conn->prepare("INSERT INTO guests (name, email, message) VALUES (?, ?, ?)");
    if (!$pstate) return ['success' => false, 'error' => 'Prepare failed: ' . $conn->error];
    $pstate->bind_param("sss", $name, $email, $message);
    if ($pstate->execute()) {
        $id = $conn->insert_id;
        $_SESSION['posted_messages'][] = $id;
        $pstate = $conn->prepare("SELECT time FROM guests WHERE id = ?");
        $pstate->bind_param("i", $id);
        $pstate->execute();
        $result = $pstate->get_result();
        $row = $result->fetch_assoc();
        $time = $row['time'];
        $pstate->close();
        return ['success' => true, 'data' => ['id' => $id, 'name' => $name, 'email' => $email, 'message' => $message, 'time' => $time]];
    } else {
        $error = $pstate->error;
        $pstate->close();
        return ['success' => false, 'error' => 'Execute failed: ' . $error];
    }
}

function sendResponse($data)
{
    header('Content-Type: application/json');
    echo json_encode($data);
    exit;
}

function handleSubmit($conn)
{
    $result = submitGuestInfo($conn);
    sendResponse($result);
}

function handleGetMessages($conn, $page)
{
    $limit = MESSAGES_PER_PAGE;
    $offset = ($page - 1) * $limit;

    $pstate = $conn->prepare("SELECT id, name, email, message, time FROM guests ORDER BY time DESC LIMIT ? OFFSET ?");
    $pstate->bind_param("ii", $limit, $offset);
    $pstate->execute();
    $result = $pstate->get_result();

    $messages = [];
    $current_time = time();

    while ($row = $result->fetch_assoc()) {
        $is_editable = false;
        $remaining_time = 0;

        if (in_array($row['id'], $_SESSION['posted_messages'])) {
            $creation_time = strtotime($row['time'] . ' UTC');
            $diff = $current_time - $creation_time;
            if ($diff < 60 && $diff >= 0) {
                $is_editable = true;
                $remaining_time = 60 - $diff;
            }
        }

        $messages[] = [
            'id' => $row['id'],
            'name' => htmlspecialchars($row['name']),
            'email' => htmlspecialchars($row['email']),
            'message' => htmlspecialchars($row['message']),
            'time' => $row['time'],
            'editable' => $is_editable,
            'remaining_time' => $remaining_time
        ];
    }
    $pstate->close();

    $total_pstate = $conn->prepare("SELECT COUNT(*) as total FROM guests");
    $total_pstate->execute();
    $total_result = $total_pstate->get_result();
    $total_row = $total_result->fetch_assoc();
    $total_messages = $total_row['total'];
    $total_pstate->close();

    sendResponse([
        'success' => true,
        'messages' => $messages,
        'total' => $total_messages,
        'page' => $page,
        'limit' => $limit
    ]);
}


function handleEdit($conn, $message_id)
{
    if (!in_array($message_id, $_SESSION['posted_messages'])) {
        sendResponse(['success' => false, 'error' => 'Unauthorized edit attempt.']);
    }

    $name = $_POST['name'] ?? '';
    $email = $_POST['email'] ?? '';
    $message = $_POST['message'] ?? '';

    if (empty($name) || empty($email) || empty($message)) {
        sendResponse(['success' => false, 'error' => 'All fields are required.']);
    }
    if (strlen($name) < 5 || strlen($name) > 128) {
        sendResponse(['success' => false, 'error' => 'Name must be between 5 and 128 characters.']);
    }
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        sendResponse(['success' => false, 'error' => 'Invalid email address.']);
    }
    if (strlen($message) < 5 || strlen($message) > 1024) {
        sendResponse(['success' => false, 'error' => 'Message must be between 5 and 1024 characters.']);
    }

    $pstate = $conn->prepare("UPDATE guests SET name = ?, email = ?, message = ? WHERE id = ?");
    $pstate->bind_param("sssi", $name, $email, $message, $message_id);
    if ($pstate->execute()) {
        $pstate->close();
        sendResponse(['success' => true]);
    }

    $error = $pstate->error;
    $pstate->close();
    sendResponse(['success' => false, 'error' => 'Update failed: ' . $error]);
}
