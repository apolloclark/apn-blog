<?php

require_once __DIR__ . '/../BaseTestCase.php';

class SQLiGetTest extends BaseTestCase {

    public $basePath = '/sqli_get.php';
    public $disabledMethods = ['HEAD', 'POST', 'PUT', 'PATCH', 'DELETE'];
    public $getViewable = true;



    public function testGetByEmojiId() {
        $response = $this->http->request('GET',
            $this->basePath . '?' . $this->entityIdKey . '=☺');
        
        // assert Response HTTP Code
        $this->assertEquals(500, $response->getStatusCode());
    }
    public function testGetByFuzzedId() {        
        $response = $this->http->request('GET',
            $this->basePath . '?' . $this->entityIdKey . '=a!@#$%^&*()-');
        
        // assert Response HTTP Code
        $this->assertEquals(500, $response->getStatusCode());
    }



    // Helper functions
    public function getMissingId(){
        return 999;
    }
}
?>