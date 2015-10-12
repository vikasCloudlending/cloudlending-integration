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
private class HttpPOSTrequestTestClass {

	// Test callout to pass 
    static testMethod void myUnitTest1() {
        
        HttpRequestObject obj = new HttpRequestObject();
		
		obj.method = 'POST';		
		obj.headerMap = new Map<String,String>();
		obj.headerMap.put('Accept','TEXT');
		obj.body = 'tag=Animal';
		
		Test.startTest();
						
			Test.setMock(HttpCalloutMock.class, new HttpRequestCalloutMock());
			
			HttpPOSTrequest postReq = new HttpPOSTrequest();
			HttpResponse res1 = postReq.sendRequest(obj,'https://api.flickr.com/services/feeds/photos_public.gne',0,1);
			System.assertEquals(res1.getStatus(),'OK','Status is OK');
			
			HttpResponse res2 = postReq.sendRawRequest(obj,'https://api.flickr.com/services/feeds/photos_public.gne',0,1);
			System.assertEquals(res1.getStatus(),'OK','Status is OK'); 
			 
		Test.stopTest();		
    }
    
    // Test callout to fail
 	@isTest
 	static void myUnitTest2()
 	{
 		HttpRequestObject obj = new HttpRequestObject();
		
		obj.method = 'POST';		
		obj.headerMap = new Map<String,String>();
		obj.headerMap.put('Accept','TEXT');
		obj.body = 'tag=Animal';
		HttpResponse nullRes = null;
		
		Test.startTest(); 	
		
			HttpPOSTrequest postReq = new HttpPOSTrequest();
			HttpResponse res1 = postReq.sendRequest(obj,'https://api.flickr.com/services/feeds/photos_public.gne',1,5);	
			System.assertEquals(res1,nullRes,'return is null');
			
			HttpResponse res2 = postReq.sendRawRequest(obj,'https://api.flickr.com/services/feeds/photos_public.gne',1,1);
			System.assertEquals(res2,nullRes,'return is null');
		
		Test.stopTest();
 	}    
}