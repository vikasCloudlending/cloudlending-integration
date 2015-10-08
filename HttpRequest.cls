public interface HttpRequest {

	HttpResponse sendRequest(requestObject request);

	HttpResponse sendRawRequest(requestObject request);
}