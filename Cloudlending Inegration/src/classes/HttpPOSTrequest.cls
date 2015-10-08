/************************************************
    HttpPOSTrequest class handles post request.
*************************************************/
public with sharing class HttpPOSTrequest implements CLHttpRequest{

    public HttpResponse sendRequest(requestObject request)
    {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        // can be hardcoded setMethod('POST');
        req.setMethod(request.method);
        if(request.timeout !=0) req.setTimeout(request.timeout);
        req.setBody(request.body);
        req.setEndpoint(request.endpoint);
        
        if(!request.headerMap.isEmpty())
        {
            for(String key : request.headerMap.keyset())
            {
                req.setHeader(key,request.headerMap.get(key));              
            }                       
        }
        
        HttpResponse res = http.send(req);
        
        return res; 
    }

    public HttpResponse sendRawRequest(requestObject request)
    {       
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        // can hardcode setMethod('POST');
        req.setMethod(request.method);
        if(request.timeout !=0) req.setTimeout(request.timeout);
        req.setBody(request.body);
        req.setEndpoint(request.endpoint);
        
        if(!request.headerMap.isEmpty())
        {
            for(String key : request.headerMap.keyset())
            {
                req.setHeader(key,request.headerMap.get(key));              
            }                       
        }
        
        HttpResponse res = http.send(req);
        
        return res;         
    }
    
}