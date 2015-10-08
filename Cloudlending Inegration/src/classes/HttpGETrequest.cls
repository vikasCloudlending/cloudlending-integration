/***********************************************************************
    HttpGETrequest class handles get request.
************************************************************************/
public with sharing class HttpGETrequest implements CLHttpRequest {
      
    public HttpResponse sendRequest(requestObject request)
    {  
        // boolean will become true when call timeouts
        Boolean loopOrnot = false;
        
        while(request.tryCount > 0)
        {   
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            
            if(request.timeOut !=0) req.setTimeout(request.timeOut);            
            req.setEndpoint(fullUrl(request.endpoint,request.paramMap));                      
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
                request.tryCount--;                
                loopOrnot = true;
            }
            
            if(!loopOrnot)
            {
                request.tryCount =0;                  
                return res;
            }
        }       
        return null;
    }
        
   
     public HttpResponse sendRawRequest(requestObject request)
    {        
        while(request.tryCount > 0)
        {
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            if(request.timeOut !=0) req.setTimeout(request.timeOut);
            req.setEndpoint(fullUrl(request.endpoint,request.paramMap));                      
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
                request.tryCount--;
                
            }
            
            request.tryCount =0;
            return res;
        }  
         return null;     
    }
    
    //method to create query sting for the get method 
    private String fullUrl(String baseUrl,Map<String,String> paramMap)
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