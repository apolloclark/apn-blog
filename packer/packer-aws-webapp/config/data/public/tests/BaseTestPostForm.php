<?php

trait BaseTestPostForm {
    function testPostFormValid() {
        
        // run request
        // http://docs.guzzlephp.org/en/latest/quickstart.html#post-form-requests
        $response = $this->http->request('POST', $this->basePath, [
            'form_params' => $this->entity
        ]);
            
        // assert if the method should be checked
        if ( in_array('POST', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
        
        // assert HTTP response code
        $this->assertEquals(200, $response->getStatusCode());
    }
    function testPostFormEmpty() {
        
        // run request, without any data
        $response = $this->http->request('POST', $this->basePath);
            
        // assert if the method should be checked
        if ( in_array('POST', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
        
        if($this->postViewable){
            $this->assertEquals(200, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(400, $response->getStatusCode());
    }
    function testPostFormNullValues() {
        
        // cast every key to (null)
        $formEntity = $this->getEntityTransformed();
        
        // run request
        $response = $this->http->request('POST', $this->basePath, [
            'form_params' => $formEntity
        ]);
        // assert if the method should be checked
        if ( in_array('POST', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
            
        // assert if this end-point supports querying entities
        if ($this->postViewable){
            $this->assertEquals(200, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(400, $response->getStatusCode());
    }
    function testPostFormLowerBounds() {
        
        // cast every key to (null)
        $formEntity = $this->getEntityTransformed($this->getLowestId());
        
        // run request
        $response = $this->http->request('POST', $this->basePath, [
            'form_params' => $formEntity
        ]);
        // assert if the method should be checked
        if ( in_array('POST', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(200, $response->getStatusCode());
    }
    function testPostFormUpperBounds() {
        
        // cast every key to (null)
        $formEntity = $this->getEntityTransformed($this->getHighestId());
        
        // run request
        $response = $this->http->request('POST', $this->basePath, [
            'form_params' => $formEntity
        ]);
        // assert if the method should be checked
        if ( in_array('POST', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(200, $response->getStatusCode());
    }
    function testPostFormUnderflow() {
        
        // cast every key to (null)
        $formEntity = $this->getEntityTransformed($this->getUnderflowId());
        
        // run request
        $response = $this->http->request('POST', $this->basePath, [
            'form_params' => $formEntity
        ]);
        
        // assert if the method should be checked
        if ( in_array('POST', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(200, $response->getStatusCode());
    }
    function testPostFormOverflow() {
        
        // cast every key to (null)
        $formEntity = $this->getEntityTransformed($this->getOverflowId());
        
        // run request
        $response = $this->http->request('POST', $this->basePath, [
            'form_params' => $formEntity
        ]);
        // assert if the method should be checked
        if ( in_array('POST', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(200, $response->getStatusCode());
    }
    function testPostFormEmoji() {
        
        // cast every key to (null)
        $formEntity = $this->getEntityTransformed('☺');
        
        // run request
        $response = $this->http->request('POST', $this->basePath, [
            'form_params' => $formEntity
        ]);
        // assert if the method should be checked
        if ( in_array('POST', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(200, $response->getStatusCode());
    }
    function testPostFormFuzz() {
        
        // cast every key to (null)
        $formEntity = $this->getEntityTransformed('a!@#$%^&*()-=');
        
        // run request
        $response = $this->http->request('POST', $this->basePath, [
            'form_params' => $formEntity
        ]);
        // assert if the method should be checked
        if ( in_array('POST', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(200, $response->getStatusCode());
    }
}
?>