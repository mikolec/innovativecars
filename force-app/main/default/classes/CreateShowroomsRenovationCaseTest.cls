/**
 * @description       : Test class for CreateShowroomsRenovationCase
 * @author            : Mikołaj Lechtański
 * @last modified on  : 15.07.2021
**/
@isTest
private class CreateShowroomsRenovationCaseTest {
  
  /**
  * @description test setup
  **/
  @TestSetup
  static void setup(){
    List<Showroom__c> showrooms = new List<Showroom__c>();
    Showroom__c showroom = TestHelpers.createTestShowroom();
    showrooms.add(showroom);
    List<Case> cases = new List<Case>();

    for(Integer i = 0; i < 100; i++) {
      Case renCase = new Case(Status = 'New', 
        Origin = 'Inner', 
        Subject = 'Renovation Case: ' + Constants.T_SHOWROOM_NAME, 
        Description = 'Renowacja w salonie: ' + Constants.T_SHOWROOM_NAME + ' (' + 'TS' + i + ').', 
        Showroom__c = showroom.Id);
      cases.add(renCase);
    }
    insert cases;
  }

  /**
  * @description tests the enqueuable job of processing new Cases
  **/
  @isTest
  static void createShowroomTenCaseQueueableTest() {
  //   List<Case> renCases = [SELECT Id FROM Case WHERE Status = 'New' AND Subject LIKE 'Renovation Case%'];
    List<Showroom__c> showrooms = [SELECT Id FROM Showroom__c WHERE Name LIKE :Constants.T_SHOWROOM_NAME + '%'];
    CreateShowroomsRenovationCase req = new CreateShowroomsRenovationCase(showrooms);
    Test.startTest();
    System.enqueueJob(req);
    Test.stopTest();

    System.assertEquals(100, [SELECT Count() FROM Case WHERE Status = 'Completed' AND Subject LIKE 'Renovation Case%' AND Showroom__c IN :showrooms]);
  }
}
