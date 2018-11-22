<?php

trait BaseTestHead {
    function testHead() {
        $response = $this->http->request('HEAD', $this->basePath);
            
        // assert if the method should be checked
        if ( in_array('HEAD', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(200, $response->getStatusCode());
        
        // assert Response Body size
        $this->assertEquals(0, strlen($response->getBody()));
    }
}
?>