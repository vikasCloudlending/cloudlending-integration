/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class HttpGETrequestTestClass {

	// Test to callout pass
    static testMethod void UnitTest1() {
        HttpRequestObject obj = new HttpRequestObject();
		
		obj.method = 'GET';
		obj.paramMap = new Map<String,String>();
		obj.paramMap.put('tags','dog');
		obj.paramMap.put('category','animal');
		obj.headerMap = new Map<String,String>();
		obj.headerMap.put('Accept','TEXT');
		
		Test.startTest();
		
		Test.setMock(HttpCalloutMock.class, new HttpRequestCalloutMock());
		HttpGETrequest getReq = new HttpGETrequest();
		HttpResponse res1 = getReq.sendRequest(obj,'https://api.flickr.com/services/feeds/photos_public.gne',2000,2);
				
		obj.paramMap.clear();
		HttpResponse res2 = getReq.sendRawRequest(obj,'https://api.flickr.com/services/feeds/photos_public.gne',2000,2);
		system.debug(res2);
		system.assertEquals(res1.getBody(),res2.getBody(),'both return matchs');		
		Test.stopTest();
    }
    
    // Test callout to fail
    @isTest
    static void UnitTest2()
    {
    	HttpRequestObject obj = new HttpRequestObject();
		
		obj.method = 'GET';
		HttpResponse nullRes = null;
				
		Test.startTest();
			
			HttpGETrequest getReq = new HttpGETrequest();
			HttpResponse res1 = getReq.sendRequest(obj,'https://api.flickr.com/services/feeds/photos_public.gne',1,2);
			
			System.assertEquals(res1,nullRes,'return is null');
			
			HttpResponse res2 = getReq.sendRawRequest(obj,'https://api.flickr.com/services/feeds/photos_public.gne',1,2);
			
			System.assertEquals(res2,nullRes,'return is null');
			
		Test.stopTest();
    }
}