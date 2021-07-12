/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 08.07.2021 
 * @description Global method removing telemetry data. This method can be used from UI
 **/

global with sharing class CleanTelemetryData implements Schedulable {
  global void execute(SchedulableContext ctx) {
    Date fromDate = Date.today().addDays(-1);
    List<Telemetry__c> oldTelys = [SELECT Id 
      FROM Telemetry__c 
      WHERE CreatedDate <= :fromDate];
    delete oldTelys;
  }
}
