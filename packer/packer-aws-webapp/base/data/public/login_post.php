<?php

// respond to OPTIONS request
if ('OPTIONS' == $_SERVER['REQUEST_METHOD']){
    
    http_response_code(200);
    header('Access-Control-Allow-Origin "*"');
    header('Access-Control-Allow-Methods "POST, GET, OPTIONS"');
    die();
}

// ensure we only handle GET requests
if ('GET' != $_SERVER['REQUEST_METHOD'] &&
    'POST' != $_SERVER['REQUEST_METHOD']){
    
    http_response_code(405);
    die("Method Not Allowed");
}



// variables
$username = null;
$password = null;

// stored output
$output = "";

// verification when doing POST requests
if ('POST' == $_SERVER['REQUEST_METHOD']) {

    // check for the $_POST variables
     if( empty($_POST['username'])
        && empty($_POST['password']) ) {
        $output = "Missing POST['username'] and POST['password'] variables";
    } else {
        // check for the $_POST['username'] variable
        if (empty($_POST['username']) ) {
            $output = "Missing POST['username'] variable";
        }
        // check for the $_POST['password'] variable
        if (empty($_POST['password']) ) {
            $output = "Missing POST['password'] variable";
        }
    }
    $username = $_POST['username'];
    $password = $_POST['password'];



    // database connection configuration
    $servername = 'localhost';
    $sql_username = 'test-user';
    $sql_password = 'H7SCw60iKG2jjW%G';
    $dbname = 'testdb';
    
    // create connection
    $mysqli = new mysqli($servername, $sql_username, $sql_password, $dbname)
        or die('Error connecting to MySQL server.');
    
    // prepare the statement
    if (!($stmt = $mysqli->prepare(
        "SELECT account_email, account_pass FROM accounts WHERE account_email = ? AND account_pass = md5(?)"))
        ){
        http_response_code(500);
        echo "Prepare failed: (" . $mysqli->errno . ") " . $stmt->error; exit();
    }
    
    // bind the input params
    if (!$stmt->bind_param('ss',$username, $password)){
        http_response_code(500);
        echo "bind_param() failed: " . $stmt->error; exit();
    }
        
    // execute the query
    if (!$stmt->execute()){
        http_response_code(500);
        echo "execute() failed: " . $stmt->error; exit();
    }
    
    // bind the results
    $account_email = null;
    $account_pass = null;
    $stmt->bind_result($account_email, $account_pass);
    
    // fetch the results
    if (!$stmt->fetch()){
        $output .= "<br/>Incorrect login.";
    } else {
        // print the results
        $output .=  "Successful login!<br/>";
        $output .= sprintf("'%s' '%s'\n", $account_email, $account_pass);
    }
    
    // close the statement
    $stmt->close();
    
    // close the db connection
    $mysqli->close();
}
?>
<html>
<head>
<title>Login Demo</title>
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
    
<h1>Login Demo</h1>

<a href="/">Index</a>

<p>This page will take whatever variable is set in the POST['username'] and
POST['password'] and use it to attempt to login to the local mysql database.</p>

<form action="login_post.php" method="post">
    <label>email</label>
    <input type="text" name="username" value="<?=$username;?>" />
    <label>password</label>
    <input type="password" name="password" value="<?=$password;?>" />
    <input type="submit" />
</form>


<pre>
    <b>Output:</b><br/>
<?=$output;?>
</pre>
</body>
</html>