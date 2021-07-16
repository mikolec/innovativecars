/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 12.07.2021 
 * @description Test class for testing RenovationCaseOnClosed trigger
 * @input Showroom with sith Status different than "Zamknięty" 
 * @output: Cases with "Completed" status being tested
 **/
@isTest
public with sharing class RenovationCaseOnCloseTTest {
  /**
  * @description main test method for checkng async sending of request for sigle case
  **/
  @isTest
  static void updateShowroomStatusTest(){
    Showroom__c showroom = TestHelpers.createTestShowroom();
    showroom.Status__c = Constants.SHOWROOM_STATUS_CLOSED;

    Test.startTest();
      update showroom;
    Test.stopTest();

    List<Case> cases = [SELECT Id, Status FROM Case WHERE Showroom__c = :showroom.Id];
    System.assertEquals(1, cases.size());
    System.assertEquals(Constants.SHOWROOM_STATUS_CLOSED, cases[0].Status);
  }

}
