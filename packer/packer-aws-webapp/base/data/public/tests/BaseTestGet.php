<?php

trait BaseTestGet {

    function testGetDefault() {
        
        // run the request
        $response = $this->http->request('GET', $this->basePath);
        
        // assert Response HTTP Code
        $this->assertEquals(200, $response->getStatusCode());
    }
    function testGetByValidId() {
        
        // run the request
        $response = $this->http->request('GET', $this->basePath, [
            'query' => [$this->entityIdKey => $this->getValidId()]
        ]);
            
        // assert if the method should be accessible
        if ( in_array('GET', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
        
        // assert HTTP response code
        $this->assertEquals(200, $response->getStatusCode());
    }
    function testGetByMissingId() {
        
        // run the request
        $response = $this->http->request('GET', $this->basePath, [
            'query' => [$this->entityIdKey => $this->getMissingId()]
        ]);
            
        // assert if the method should be accessible
        if ( in_array('GET', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
            
        // assert if this end-point supports querying entities
        if ( $this->getViewable ){
            $this->assertEquals(200, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(404, $response->getStatusCode());
    }
    function testGetByNullId() {
        
        // run the request
        $response = $this->http->request('GET',$this->basePath, [
            'query' => [$this->entityIdKey => null]
        ]);
            
        // assert if the method should be accessible
        if ( in_array('GET', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
            
        // assert if the end-point is viewable
        if ( $this->getViewable ){
            $this->assertEquals(200, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(404, $response->getStatusCode());
    }
    function testGetByLowestId() {
        
        // run the request
        $response = $this->http->request('GET', $this->basePath, [
            'query' => [$this->entityIdKey => $this->getLowestId()]
        ]);
            
        // assert if the method should be accessible
        if ( in_array('GET', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
        
        // if there's anything in the database, it should return
        $this->assertEquals(200, $response->getStatusCode());
    }
    function testGetByHighestId() {
        
        $response = $this->http->request('GET', $this->basePath, [
            'query' => [$this->entityIdKey => $this->getHighestId()]
        ]);
            
        // assert if the method should be checked
        if ( in_array('GET', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
            
        // assert if the end-point is viewable
        if ( $this->getViewable ){
            $this->assertEquals(200, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(404, $response->getStatusCode());
    }
    function testGetByUnderflowId() {
        
        // run the query
        $response = $this->http->request('GET', $this->basePath, [
            'query' => [$this->entityIdKey => $this->getUnderflowId()]
        ]);
            
        // assert if the method should be accessible
        if ( in_array('GET', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
            
        // assert if the end-point is viewable
        if ( $this->getViewable ){
            $this->assertEquals(200, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(404, $response->getStatusCode());
    }
    function testGetByOverflowId() {
        
        // run the query
        $response = $this->http->request('GET', $this->basePath, [
            'query' => [$this->entityIdKey => $this->getOverflowId()]
        ]);
            
        // assert if the method should be accessible
        if ( in_array('GET', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
            
        // assert if the end-point is viewable
        if ( $this->getViewable ){
            $this->assertEquals(200, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(404, $response->getStatusCode());
    }
    function testGetByEmojiId() {
        
        // run the request
        $response = $this->http->request('GET', $this->basePath, [
            'query' => [$this->entityIdKey => '☺']
        ]);
            
        // assert if the method should be accessible
        if ( in_array('GET', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
            
        // assert if this end-point is viewable
        if ( $this->getViewable ){
            $this->assertEquals(200, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(404, $response->getStatusCode());
    }
    function testGetByFuzzedId() {
        
        $response = $this->http->request('GET', $this->basePath, [
            'query' => [$this->entityIdKey => 'a!@#$%^&*()-']
        ]);
            
        // assert if the method should be accessible
        if ( in_array('GET', $this->disabledMethods) ){
            $this->assertEquals(405, $response->getStatusCode());
            return;
        }
            
        // assert if this end-point is viewable
        if ( $this->getViewable ){
            $this->assertEquals(200, $response->getStatusCode());
            return;
        }
        
        // assert Response HTTP Code
        $this->assertEquals(404, $response->getStatusCode());
    }
}
?>