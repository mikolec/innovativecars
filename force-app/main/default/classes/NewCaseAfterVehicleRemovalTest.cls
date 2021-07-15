/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 07.07.2021 
 * @description Test class checking NewCaseAfterVehicleRemoval trigger
**/
@isTest
private with sharing class NewCaseAfterVehicleRemovalTest {
  /**
  * @description test method checking if a case was created after vehicle removal
  **/
	@isTest
  static void removeVehicleTest() {
    Vehicle__c vehicle = TestHelpers.createTestVehicle();
    delete vehicle;

    System.assertEquals(1, [
      SELECT count() 
      FROM Case 
      WHERE Subject = :Constants.VEHICLE_REMOVAL_MSG_SUBJECT
    ]);    
  }

  /**
  * @description test method checking if a case was created after vehicle with telemetry removal
  **/
  @isTest
  static void removeVehicleWithTelemetryTest() {
    Vehicle__c vehicle = TestHelpers.createTestVehicleWithTelemetries(10);
    delete vehicle;

    System.assertEquals(1, [
      SELECT count() 
      FROM Case 
      WHERE Subject = :Constants.VEHICLE_REMOVAL_MSG_SUBJECT
    ]);    
  }
}
