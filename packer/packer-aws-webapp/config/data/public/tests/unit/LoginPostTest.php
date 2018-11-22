<?php

require_once __DIR__ . '/../BaseTestCase.php';

class LoginPostTest extends BaseTestCase {
        
    public $basePath = '/login_post.php';
    public $disabledMethods = ['HEAD', 'PUT', 'PATCH', 'DELETE'];
    public $postViewable = true;
    public $getViewable = true;
    
    public function __construct() {

        // open json file, parse, save
        $jsonFile = file_get_contents(__DIR__ . '/LoginRequest.json') or
            die("Unable to open file!");
        $this->entity = json_decode($jsonFile);
    }
}
?>