<?php
# https://www.madebymagnitude.com/blog/sending-post-data-from-php/
# Form our options
$opts = array('http' =>
    array(
        'method'  => 'POST',
        'header'  => 'Content-type: application/x-www-form-urlencoded',
        'content' => $postString
    )
);
# Create the context
$context = stream_context_create($opts);
# Get the response (you can use this for GET)
$result = file_get_contents('/api/update', false, $context);
?>