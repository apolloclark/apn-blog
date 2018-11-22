<?php

// respond to OPTIONS request
if ('OPTIONS' == $_SERVER['REQUEST_METHOD']){
    
    http_response_code(200);
    header('Access-Control-Allow-Origin "*"');
    header('Access-Control-Allow-Methods "POST, GET, OPTIONS"');
    die();
}

// ensure we only handle GET requests
if ('GET' != $_SERVER['REQUEST_METHOD']){
    
    http_response_code(405);
    die("Method Not Allowed");
}



// stored output
$output = "";

// id variable to inject
$id = -1;

// check for the $_GET variable
if (!empty($_GET['id'])) {
    
    // retrieve variable
    $id = $_GET['id'];


    // echo out the id value... XSS :)
    $output .= "GET['id'] is set to: \"" . $id . "\"\n\n";
    
    // database connection configuration
    $servername = 'localhost';
    $username = 'test-user';
    $password = 'H7SCw60iKG2jjW%G';
    $dbname = 'testdb';
    
    // create connection
    $db = mysqli_connect($servername, $username, $password, $dbname)
        or die('Error connecting to MySQL server.');
    
    // query database
    $query = "SELECT * FROM accounts WHERE account_id=" . $id;
    $results = mysqli_query($db, $query);
    
    // ensure we have a valid query
    if (!$results){
        http_response_code(500);
        die("ERROR!!! query: " . $query . "; errno: " . mysqli_errno($db) .
            ": " . mysqli_error($db));
    } else {
        
        // ensure we have results
        // http://ca3.php.net/manual/en/mysqli-result.num-rows.php
        $row_cnt = mysqli_num_rows($results);
        if($row_cnt < 1) {
            $output .= "No results found.";
        } else {
            // fetch the results, output them
            while ($row = mysqli_fetch_array($results)) {
               $output .= print_r($row, true) . '<br />';
            }
        }
    }
    // close the db connection
    mysqli_close($db);
}





?>
<html>
<head>
<title>SQL Injection Demo</title>
<style type="text/css">
body{
    font-family: Arial;
    max-width: 640px;
    margin: 2em;
}

pre{
}
</style>
</head>
<body>
    
<h1>HTTP GET SQL Injection Demo</h1>

<a href="/">Index</a>
<br/><br/>
<a href="https://gist.github.com/apolloclark/1ef9e0b53525cb14fdcffd5188d751d3">MySQL Cheatsheet</a>
<br/><br/>
<a href="https://github.com/sqlmapproject/sqlmap/wiki/Usage">sqlmap usage manual</a>

<p>This page will take whatever variable is set in the HTTP GET['id'] and use
it to run build an unsanitized command which will query the local mysql database.</p>

<a href="/sqli_get.php?id=1%20OR%201=1;--">SQL Injection Demo link</a>

<pre>
    <b>Output:</b><br/>
<?=$output;?>
</pre>
</body>
</html>