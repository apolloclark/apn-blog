<?php

require 'BaseTestOptions.php';
require 'BaseTestHead.php';
require 'BaseTestGet.php';
require 'BaseTestPostForm.php';
require 'BaseTestPut.php';
require 'BaseTestPatch.php';
require 'BaseTestDelete.php';

// https://blog.cloudflare.com/using-guzzle-and-phpunit-for-rest-api-testing/
// http://stackoverflow.com/questions/8313283/phpunit-best-practices-to-organize-tests
class BaseTestCase extends PHPUnit_Framework_TestCase {
    
    use BaseTestOptions, BaseTestHead, BaseTestGet, BaseTestPostForm, BaseTestPut,
        BaseTestPatch, BaseTestDelete;
    
    public $baseUrl = 'http://127.0.0.1';
    public $basePath = '/';
    public $http;
    
    public $entityId = null;
    public $entityIdKey = "id";
    public $entity = array();
    
    public $disabledMethods = [];
    public $getViewable = false;
    public $postViewable = false;

    public function setUp() {
        $this->http = new GuzzleHttp\Client([
            'base_uri' => $this->baseUrl,
            'http_errors' => false
        ]);
    }
    public function tearDown() {
        $this->http = null;
    }
    
    
    
    // overload these helper methods in the parent tests
    function getValidId(){
        return 1;
    }
    function getMissingId(){
        return null;
    }
    function getLowestId(){
        return 0;
    }
    function getHighestId(){
        // https://dev.mysql.com/doc/refman/5.7/en/integer-types.html
        return 4294967295;
    }
    function getUnderflowId(){
        return ($this->getLowestId() - 1);
    }
    function getOverflowId(){
        return ($this->getHighestId() + 1);
    }
    function getEntityTransformed($newVal = null){
        $formEntity = array();
        if (!empty($this->entity) && 
                ( is_object($this->entity) ||
                is_array($this->entity) )
        ) {
            foreach ($this->entity as $key => $val) {
                $formEntity[$key] = $newVal;
            }
        }
        return $formEntity;
    }
}
?>