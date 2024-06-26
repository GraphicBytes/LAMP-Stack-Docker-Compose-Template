<?php
//###########################################
//############### ENVIRONMENT ###############
//###########################################
$env = (int)getenv('ENV');


if ($env == 1) {
  //live environment
  $debug = 0;
} else {
  //dev environment
  $debug = 1;
  ini_set('display_errors', 1);
  ini_set('display_startup_errors', 1);
  error_reporting(E_ALL);
}


//##########################################
//############### ANTI VIRUS ###############
//##########################################
// the OS level antivirus doesn't catch real time uploads inside docker containers, so they need to be passed through the clamAV envrionment that comes with this container. 

// // we connect to the AV envronment using the server's main IP and assigned port
// $avUrl = "tcp://" . getenv('HOST_SERVER_IP') . ":" . getenv('AV_PORT');

// //scanning a file example usage
// $avSocket = stream_socket_client($avUrl);
// if ($avSocket === false) { die('Failed to connect to ClamAV'); }

// $uploadedFile = '/var/www/html/temp/example-file.pdf';
// if (!file_exists($uploadedFile)) { die('file does not exist'); }

// fwrite($avSocket, "nSCAN $uploadedFile\n");
// $avResponse = fread($avSocket, 1024);
// fclose($avSocket);

// if (strpos($avResponse, 'FOUND') !== false) {
//   // The file contains a virus
//   unlink($uploadedFile);
//   die();
// } else {
//   // The file is clean
// }


//##############################################
//############### DB CREDENTIALS ###############
//##############################################
$dbhost = getenv('MYSQL_HOST');
$dbuser = getenv('MYSQL_USER');
$dbpw = getenv('MYSQL_PASSWORD');
$dbname = getenv('MYSQL_DATABASE');









echo "hello world";
