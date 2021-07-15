/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 08.07.2021 
 * @description Test class for testing RenovationCaseRequest queable method with Http callout
 * @input Cases with "New" status
 * @output: Cases with "Completed" status
 **/

@isTest
public with sharing class RenovationCaseRequestTest {

  /**
  * @description tests setup
  **/
  @TestSetup
  static void setup(){
    Showroom__c showroom = TestHelpers.createTestShowroom();

    Case renCase = new Case(
      Status = 'New', 
      Origin = 'Inner', 
      Subject = 'Renovation Case: ' + Constants.T_SHOWROOM_NAME, 
      Description = 'Renowacja w salonie: ' + Constants.T_SHOWROOM_NAME, 
      Showroom__c = showroom.Id
    );
    insert renCase;
  }

  /**
  * @description main test method checking RenovationCaseRequest class
  **/
  @isTest
  static void renovationCaseRequestTestQueueable() {
    Case renCase = [SELECT Id FROM Case WHERE Status = 'New' AND Subject LIKE 'Renovation Case%' LIMIT 1][0];

    RenovationCaseRequest req = new RenovationCaseRequest(renCase);
    Test.startTest();
    System.enqueueJob(req);
    Test.stopTest();

    System.assertEquals(1, [SELECT Count() FROM Case WHERE Status = 'Completed' AND Subject LIKE 'Renovation Case%' LIMIT 1]);
  }
}
