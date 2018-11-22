<?php

trait BaseTestPatch {
    function testPatch() {
        $response = $this->http->request('PATCH', $this->basePath);
            
        // assert if the method should be checked
        if ( in_array('PATCH', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(200, $response->getStatusCode());
    }
}
?>