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
    
<h1>HTTP POST SQL Injection Demo</h1>

<a href="/">Index</a>
<br/><br/>
<a href="https://gist.github.com/apolloclark/1ef9e0b53525cb14fdcffd5188d751d3">MySQL Cheatsheet</a>
<br/><br/>
<a href="https://github.com/sqlmapproject/sqlmap/wiki/Usage">sqlmap usage manual</a>

<p>This page will take whatever variable is set in the POST['id'] and use it to
run build an unsanitized command which will query the local mysql database.</p>

<form action="sqli_post.php" method="post">
    <label>ID</label>
    <input type="text" name="id" value="" />
    <input type="submit" />
</form>


<pre>
    <b>Output:</b><br/>
<?php


// id variable to inject
$id = -1;

// check for the $_POST variable
if (empty($_POST['id'])) {
    die("Missing POST['id'] variable");
}
$id = $_POST['id'];

// echo out the id value... XSS :)
echo 'id value is set to: "' . $id . "\"\n\n";



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
    echo $query;
    echo mysqli_errno($db) . ": " . mysqli_error($db);
} else {
    
    // valid query, ensure we have results
    // http://ca3.php.net/manual/en/mysqli-result.num-rows.php
    $row_cnt = mysqli_num_rows($results);
    if($row_cnt < 1) {
        echo "No results found.";
    } else {
        // fetch the results, print them
        while ($row = mysqli_fetch_array($results)) {
           print_r($row) . '<br />';
        }
    }
}

// close the db connection
mysqli_close($db);
?>
</pre>
</body>
</html>