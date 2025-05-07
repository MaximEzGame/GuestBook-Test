<?php

if (!defined('APP_INDEX')) {
    header("Location: /");
    die();
}

define('DB_HOST', 'database');
define('DB_USER', 'guestbook');
define('DB_PASS', 'secret');
define('DB_NAME', 'guestbook');

define('MESSAGES_PER_PAGE', 10);
