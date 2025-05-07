<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guest Book</title>
    <link rel="icon" type="image/png" href="assets/img/book.png">
    <link rel="stylesheet" href="assets/bootstrap-3.4.1-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
    <div class="container">
        <h1>Guest Book!</h1>
        <form id="guestForm" method="post">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" class="form-control" required>
                <span id="nameError" class="text-danger"></span>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" class="form-control" required>
                <span id="emailError" class="text-danger"></span>
            </div>
            <div class="form-group">
                <label for="message">Message:</label>
                <textarea id="message" name="message" rows="4" class="form-control" required></textarea>
                <span id="messageError" class="text-danger"></span>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
            <button type="reset" class="btn btn-default" value="Reset">Reset</button>
        </form>
        <h2>Messages:</h2>
        <div id="messages"></div>
        <div id="pagination" class="pagination" style="margin-top: 20px;"></div>
    </div>

    <div class="modal fade" id="editModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Message</h5>
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>
                <div class="modal-body">
                    <form id="editForm">
                        <input type="hidden" id="edit_message_id">
                        <div class="form-group">
                            <label for="edit_name">Name:</label>
                            <input type="text" id="edit_name" class="form-control" required>
                            <span id="edit_nameError" class="text-danger"></span>
                        </div>
                        <div class="form-group">
                            <label for="edit_email">Email:</label>
                            <input type="email" id="edit_email" class="form-control" required>
                            <span id="edit_emailError" class="text-danger"></span>
                        </div>
                        <div class="form-group">
                            <label for="edit_message">Message:</label>
                            <textarea id="edit_message" rows="4" class="form-control" required></textarea>
                            <span id="edit_messageError" class="text-danger"></span>
                        </div>
                        <button type="submit" class="btn btn-primary" id="editSubmit" disabled>Submit</button>
                        <button type="button" class="btn btn-default" id="editCancel" data-dismiss="modal">Cancel</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="assets/jquery/jquery-3.7.1.min.js"></script>
    <script src="assets/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
    <script src="js/app.js"></script>
</body>

</html>