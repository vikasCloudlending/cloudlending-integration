public with sharing class requestObject {
    
    public String method;
    public String body;
    public Map<String,String> headerMap;
    public Map<String,String> paramMap;
    public Integer timeOut =0;
    public String endpoint;
    public integer tryCount = 1;
    
    public void requestObject()
    {
        headerMap = new Map<String,String>();
        paramMap = new Map<String,String>();
    }
}