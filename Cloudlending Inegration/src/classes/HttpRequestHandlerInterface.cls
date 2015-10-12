Global interface HttpRequestHandlerInterface {

    HttpResponse sendRequest(HttpRequestObject request,String endpoint,Integer timeout,Integer retryCount);

    HttpResponse sendRawRequest(HttpRequestObject request,String endpoint,Integer timeout,Integer retryCount);
}