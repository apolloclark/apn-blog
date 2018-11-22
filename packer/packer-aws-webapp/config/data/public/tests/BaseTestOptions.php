<?php

trait BaseTestOptions {
    function testOptions() {
        $response = $this->http->request('OPTIONS', $this->basePath);
        
        // assert Response HTTP Code
        $this->assertEquals(200, $response->getStatusCode());
    }
}
?>