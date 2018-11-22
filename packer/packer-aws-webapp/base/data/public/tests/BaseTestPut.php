<?php

trait BaseTestPut {
    function testPut() {
        $response = $this->http->request('PUT', $this->basePath);
            
        // assert if the method should be checked
        if ( in_array('PUT', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(200, $response->getStatusCode());
    }
}
?>