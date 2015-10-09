/***********************************************************************
    HttpGETrequest class handles get request.xxxxx
************************************************************************/
public with sharing class HttpGETrequest implements HttpRequestHandlerInterface {
         
    public HttpResponse sendRequest(HttpRequestObject request,String endpoint,Integer timeout,Integer retryCount)
    { 
		// boolean will become true when call timeouts
		Boolean loopOrnot = false;
		retryCount ++;
        do
		{	system.debug('retryCount-->'+retryCount);
			Http http = new Http();
            HttpRequest req = new HttpRequest();
			
			if(timeOut !=null || timeOut !=0) req.setTimeout(timeOut);
			req.setEndpoint(constructEndpoint(endpoint,request.paramMap));
			req.setMethod(request.method);
			if(request.body !=null) req.setBody(request.body);
			
			//Header Map to populate html headers
            if(request.headerMap != null){
                for(String key: request.headerMap.keySet()){
                    req.setHeader(key,request.headerMap.get(key));
                }
            }		
		  
            HttpResponse res; 
            try
            {                
                res = http.send(req);
            }catch(System.CalloutException e)
            {
                retryCount--;                
                loopOrnot = true;
            }
			
			 if(!loopOrnot)
            {
                retryCount =0;                  
                return res;
            }
		}while(retryCount > 0);
		              
        return null;
    }
        
    public HttpResponse sendRawRequest(HttpRequestObject request,String endpoint,Integer timeout,Integer retryCount)
    {        
        // boolean will become true when call timeouts
		Boolean loopOrnot = false;
		
        do
		{
			Http http = new Http();
            HttpRequest req = new HttpRequest();
			
			if(timeOut !=null || timeOut !=0) req.setTimeout(timeOut);
			req.setEndpoint(constructEndpoint(endpoint,request.paramMap));
			req.setMethod(request.method);
			if(request.body !=null) req.setBody(request.body);
			
			//Header Map to populate html headers
            if(request.headerMap != null){
                for(String key: request.headerMap.keySet()){
                    req.setHeader(key,request.headerMap.get(key));
                }
            }		
		  
            HttpResponse res; 
            try
            {                
                res = http.send(req);
            }catch(System.CalloutException e)
            {
                retryCount--;                
                loopOrnot = true;
            }
			
			 if(!loopOrnot)
            {
                retryCount =0;                  
                return res;
            }
		}while(retryCount > 0);
		              
        return null;    
    }
    
    //method to create query sting for the get method 
    private String constructEndpoint(String baseUrl,Map<String,String> paramMap)
    {
        String url= baseUrl;
        
        if(!paramMap.isEmpty())
        {    
            boolean firstElement = true;       
            for(String key : paramMap.keySet())
            {
                if(firstElement)
                {
                    url =url +'?'+key+'='+paramMap.get(key);  
                    firstElement = false;
                }                                   
                else  url =url +'&'+key+'='+paramMap.get(key);               
            } 
            return url;
        }
        
        return url;
    }
}