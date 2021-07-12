/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 08.07.2021 
 * @description Test class for testing RenovationCaseRequest queable method with Http callout
 * @input Cases with "New" status
 * @output: Cases with "Completed" status
 **/

@isTest
public with sharing class RenovationCaseRequestTest {
  //Test constants
  static final String T_SHOWROOM_NAME = 'Test Showroom';

  @TestSetup
  static void setup(){
    Showroom__c showroom = TestHelpers.createTestShowroom();

    List<Case> cases = new List<Case>();

    for(Integer i = 0; i < 100; i++) {
      Case renCase = new Case(Status = 'New', 
        Origin = 'Inner', 
        Subject = 'Renovation Case: ' + T_SHOWROOM_NAME, 
        Description = 'Renowacja w salonie: ' + T_SHOWROOM_NAME + ' (' + 'TS' + i + ').', 
        Showroom__c = showroom.Id);
      cases.add(renCase);
    }
    insert cases;
  }

  static testmethod void renovationCaseRequestTestQueueable() {
    List<Case> cases = [SELECT Id FROM Case WHERE Status = 'New' AND Subject LIKE 'Renovation Case%'];

    RenovationCaseRequest req = new RenovationCaseRequest(cases);
    Test.startTest();
    System.enqueueJob(req);
    Test.stopTest();

    System.assertEquals(100, [SELECT Count() FROM Case WHERE Status = 'Completed' AND Subject LIKE 'Renovation Case%']);
  }
}
