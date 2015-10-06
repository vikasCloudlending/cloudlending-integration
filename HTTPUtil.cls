public interface HTTPUtil {

	HttpResponse sendRequest(requestObject request);

	HttpResponse sendRawRequest();
}