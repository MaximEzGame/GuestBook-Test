<?php
define('APP_INDEX', __FILE__);
require_once 'includes/functions.php';

$action = $_POST['action'] ?? '';
switch ($action) {
    case 'submit':
        handleSubmit($conn);
        break;
    case 'get_messages':
        $page = isset($_POST['page']) ? (int)$_POST['page'] : 1;
        getMessages($conn, $page);
        break;
    case 'edit':
        $message_id = (int)($_POST['message_id'] ?? 0);
        handleEdit($conn, $message_id);
        break;
    default:
        sendResponse(['success' => false, 'error' => 'Invalid action.']);
}
