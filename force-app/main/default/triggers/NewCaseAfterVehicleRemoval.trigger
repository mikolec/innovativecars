/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 07.07.2021 
 * @description Trigger being fired on Vehicle data delete 
 * @param after delete 
**/
trigger NewCaseAfterVehicleRemoval on Vehicle__c (before delete) {

  List<Telemetry__c> telemetries = [SELECT Id FROM Telemetry__c WHERE Vehicle__c IN :Trigger.old];
  delete telemetries;

  for(Vehicle__c vehicle : Trigger.old) {

    String description = String.format(
      'Dane utylizowanego pojazdu: \nMarka: {0}\nModel: {1}\nNr seryjny: {2}\n', 
      new String[]{vehicle.Brand__c, vehicle.Model__c, vehicle.Name});

    Case c = new Case(Subject = Constants.VEHICLE_REMOVAL_MSG_SUBJECT,
      Description = description,
      Status = 'New',
      Origin = 'Internal'
    );

    Database.SaveResult result = Database.insert(c);
    
  }
}