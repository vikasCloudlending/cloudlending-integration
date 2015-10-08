public interface CLHttpRequest {

    HttpResponse sendRequest(requestObject request);

    HttpResponse sendRawRequest(requestObject request);
}