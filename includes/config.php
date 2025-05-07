<?php

if (!defined('APP_INDEX')) {
    header("Location: /");
    die();
}

define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'guestbook');

define('MESSAGES_PER_PAGE', 10);
