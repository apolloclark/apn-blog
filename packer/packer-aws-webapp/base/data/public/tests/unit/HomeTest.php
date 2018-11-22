<?php

require_once __DIR__ . '/../BaseTestCase.php';

class HomeTest extends BaseTestCase {
        
    public $basePath = '/';
    public $disabledMethods = ['PUT', 'PATCH', 'DELETE'];
    public $postViewable = true;
    public $getViewable = true;
}
?>