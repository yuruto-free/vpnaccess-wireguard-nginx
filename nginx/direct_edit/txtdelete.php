#!/usr/bin/php
<?php
// ------------------------------------------------------------
//
// txtregist.php
//
// Ver.01.00
//
// ------------------------------------------------------------
?>
<?php
// ----------------------------------------------------------------------
// MyDNS.JP Parameter
// ----------------------------------------------------------------------
include(__DIR__.'/txtedit.conf');
?>
<?php
// ----------------------------------------------------------------------
// Init Routine
// ----------------------------------------------------------------------
?>
<?php
date_default_timezone_set(@date_default_timezone_get());

mb_internal_encoding('UTF-8');

mb_http_output('UTF-8');

$CERTBOT_ENV_LIST = array('CERTBOT_DOMAIN','CERTBOT_VALIDATION','CERTBOT_TOKEN','CERTBOT_CERT_PATH','CERTBOT_KEY_PATH','CERTBOT_SNI_DOMAIN','CERTBOT_AUTH_OUTPUT');

$MYDNSJP_CMD = 'DELETE';
?>
<?php
// ----------------------------------------------------------------------
// Sub Routine
// ----------------------------------------------------------------------
?>
<?php
// ----------------------------------------------------------------------
// Main Routine
// ----------------------------------------------------------------------
?>
<?php
foreach ($CERTBOT_ENV_LIST as $CERTBOT_ENV_NAME)
{
    $CERTBOT_ENV[$CERTBOT_ENV_NAME] = getenv($CERTBOT_ENV_NAME);
}
$CERTBOT_ENV['EDIT_CMD'] = $MYDNSJP_CMD;

$MYDNSJP_HEADERS = array('Content-Type: application/x-www-form-urlencoded',
                         'Authorization: Basic '. base64_encode($MYDNSJP_MASTERID.':'.$MYDNSJP_MASTERPWD),
                         );

$MYDNSJP_QUERY = http_build_query($CERTBOT_ENV);

$POST_OPTIONS = array( 'http' =>
                    array('method' => 'POST',
                          'header' => implode("\r\n", $MYDNSJP_HEADERS),
                          'content' => $MYDNSJP_QUERY)
                );

$MYDNSJP_CONTENTS = file_get_contents($MYDNSJP_URL, false, stream_context_create($POST_OPTIONS));

$DEBUG = "";
/*
foreach ($CERTBOT_ENV as $CERTBOT_ENV_NAME => $CERTBOT_ENV_VALUE)
{
    if ($CERTBOT_ENV_VALUE === FALSE)
    {
        $DEBUG .= $CERTBOT_ENV_NAME.'=FALSE'."\n";
    }
    else
    {
        $DEBUG .= $CERTBOT_ENV_NAME.'='.$CERTBOT_ENV_VALUE."\n";
    }
}
*/
$DEBUG .= 'MYDNSJP_CONTENTS='.$MYDNSJP_CONTENTS."\n";

$DEBUG_LOG = fopen(__DIR__.'/debug.log', 'a+');
fwrite($DEBUG_LOG, $DEBUG);
fclose($DEBUG_LOG);

?>
