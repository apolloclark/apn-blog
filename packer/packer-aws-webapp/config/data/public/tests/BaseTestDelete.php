<?php

trait BaseTestDelete {
    function testDelete() {
        $response = $this->http->request('DELETE', $this->basePath);
            
        // assert if the method should be checked
        if ( in_array('DELETE', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(200, $response->getStatusCode());
    }
}
?>