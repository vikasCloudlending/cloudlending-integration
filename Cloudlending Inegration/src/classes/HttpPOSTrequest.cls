/************************************************
    HttpPOSTrequest class handles post request.
*************************************************/
Global with sharing class HttpPOSTrequest implements HttpRequestHandlerInterface{

    Global HttpResponse sendRequest(HttpRequestObject request,String endpoint,Integer timeout,Integer retryCount)
    {
    	retryCount ++;
    	do{ system.debug('retryCount-->'+retryCount);
    		Http http = new Http();
	        HttpRequest req = new HttpRequest();       
	        req.setMethod(request.method);
	        if(timeout !=0) req.setTimeout(timeout);        
	        req.setBody(request.body);
	        req.setEndpoint(endpoint);
	        
	        if(request.headerMap != Null)
	        {
	            for(String key : request.headerMap.keyset())
	            {
	                req.setHeader(key,request.headerMap.get(key));              
	            }                       
	        }
	        
	        HttpResponse res;
	        
	        try{
	        	res = http.send(req);
	        }catch(Exception e)
	        {
	        	  retryCount--;      	
	        }
    		
    		if(res != Null)
	        {
	        	retryCount = 0;
	        	return res;        	
	        }
	        
    	}while(retryCount >0);                
        
        return Null; 
    }

    Global HttpResponse sendRawRequest(HttpRequestObject request,String endpoint,Integer timeout,Integer retryCount)
    {       
       retryCount ++;
    	do{
    		Http http = new Http();
	        HttpRequest req = new HttpRequest();       
	        req.setMethod(request.method);
	        if(timeout !=0) req.setTimeout(timeout);        
	        req.setBody(request.body);
	        req.setEndpoint(endpoint);
	        
	        if(request.headerMap != Null)
	        {
	            for(String key : request.headerMap.keyset())
	            {
	                req.setHeader(key,request.headerMap.get(key));              
	            }                       
	        }
	        
	        HttpResponse res;
	        
	        try{
	        	res = http.send(req);
	        }catch(Exception e)
	        {
	        	  retryCount--;      	
	        }
    		
    		if(res != Null)
	        {
	        	retryCount = 0;
	        	return res;        	
	        }
	        
    	}while(retryCount >0);                
        
        return Null;
    }
    
}