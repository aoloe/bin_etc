#!/usr/bin/env php
<?php
# usage:
# composer-deploy.php
# composer-deploy.json must be defined in the directory where the script is run


function debug($label, $value) {
    echo("--> $label:\n".print_r($value, 1)."\n");
}

function label($string) {
    echo("\033[0;32m-->\033[0m ".$string."\n");
}

function error($string) {
    echo("\033[0;31-->\033[0m ".$string."\n");
}

$path_pwd = rtrim($_SERVER['PWD'], '/').'/';

$path_configuration = $path_pwd.'composer-deploy.json';

$configuration_default = array (
    // "ncfp-bookmark" => null, // mandatory for now
    "path-server-base" => "",
    "path-vendor-src" => array(), // path where the code is located; the rest of the repository is not uploaded.
    "path-repository-src" => array(),
);

if (!file_exists($path_configuration)) {
    error("error: cannot find ".$path_configuration.".\n");
    die();
}

$configuration = file_get_contents($path_configuration);
$configuration = json_decode($configuration, true);

if (empty($configuration)) {
    error("error: ".$path_configuration." is not a valid configuration file.\n");
    die();
}

$configuration = $configuration + $configuration_default;
// debug('configuration', $configuration);

label("delete the current vendor directory.\n");

$path_server_base = rtrim($configuration['path-server-base'], '/').'/';
// debug('path_server_base', $path_server_base);

$path_local_vendor = 'vendor/';
$path_server_vendor = $path_server_base.'vendor/';
// debug('path_server_vendor', $path_server_vendor);

// TODO: ask confirmation for action before running the delete
ncftp_empty_directory($configuration['ncftp-bookmark'], $path_server_vendor);

$vendor_list = get_directory_list($path_local_vendor.'*');
// debug('vendor_list', $vendor_list);

label("upload composer");
// composer does not have repositories in vendor, just upload the vendor
ncftp_upload_directory($configuration['ncftp-bookmark'], $path_server_vendor, $path_local_vendor.'composer/');
$vendor_list = array_diff($vendor_list, array('composer'));
// debug('vendor_list', $vendor_list);

foreach ($vendor_list as $vendor) {
    $vendor_path = $path_local_vendor.$vendor.'/';
    $repository_list = get_directory_list($vendor_path.'*');
    // debug('repository_list', $repository_list);
    foreach ($repository_list as $repository) {
        label("upload ".$vendor."/".$repository);
        $repository_path = $vendor_path.$repository.'/';
        // debug('repository_path', $repository_path);
        if (array_key_exists($vendor, $configuration['path-repository-src'])) {
            $repository_path.= $configuration['path-repository-src'][$vendor];
        } elseif (array_key_exists($vendor, $configuration['path-vendor-src'])) {
            $repository_path.= $configuration['path-vendor-src'][$vendor];
        }
        // debug('repository_path', $repository_path);
        ncftp_upload_directory($configuration['ncftp-bookmark'], $path_server_vendor, $repository_path);
    }
}

function get_directory_list($path) {
    return array_map('basename', array_filter(glob($path, GLOB_ONLYDIR), 'is_dir'));
}

function ncftp_empty_directory($bookmark, $path) {
    $command = "
        ncftp ".$bookmark." <<END_OF_CMD
        rm -rf $path
        mkdir $path
        quit
        END_OF_CMD
    ";
    // debug('command', $command);
    // debug('ncftp emptying directory disabled', true);
    passthru($command);
}
function ncftp_upload_directory($bookmark, $server_path, $local_path) {
    $command = "ncftpput -R -m ".$bookmark." ".$server_path." ".$local_path;
    // debug('command', $command);
    $output = array();
    // debug('ncftp upload disabled', true);
    exec($command, $output);
    // debug('output', $output);
}
