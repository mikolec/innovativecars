/**
 * @description       : Global method removing telemetry data. This method can be used from UI
 * @author            : Mikołaj Lechtański
 * @last modified on  : 15.07.2021
**/

public with sharing class CleanTelemetryData implements Database.Batchable<sObject>, Database.Stateful {

  public Integer recordsProcessed = 0;
  /**
  * @description instance member to retain state across transactions
  * @param Database.BatchableContext bc 
  * @return Database.QueryLocator 
  **/
  public Database.QueryLocator start(Database.BatchableContext bc) {
    Date fromDate = Date.today().addDays(-1);
    return Database.getQueryLocator(
        'SELECT Id ' +
        'FROM Telemetry__c ' +
        'WHERE CreatedDate <= ' + fromDate
    );
  }

  /**
  * @description instance member to execute batch data removal
  * @param Database.BatchableContext bc 
  * @param List<Telemetry__c> scope 
  **/
  public void execute(Database.BatchableContext bc, List<Telemetry__c> scope){
      // process each batch of records
      List<Telemetry__c> oldTelys = new List<Telemetry__c>();
      for (Telemetry__c oldTely : scope) {
          // add telemtry to list to be deleted
          oldTelys.add(oldTely);
          // increment the instance member counter
          recordsProcessed = recordsProcessed + 1;
      }
      delete oldTelys;
  }


  /**
  * @description instance member to execute actions on batch process job completion
  * @param Database.BatchableContext bc 
  **/
  public void finish(Database.BatchableContext bc){
      System.debug(recordsProcessed + ' records processed.');
      AsyncApexJob job = [
        SELECT Id, Status, NumberOfErrors,
        JobItemsProcessed,
        TotalJobItems
        FROM AsyncApexJob
        WHERE Id = :bc.getJobId()
      ];
      
      // call some utility to send email
      String emailBody = job + ' : ' + recordsProcessed;
      EmailManager.sendMailAsync(Constants.T_EMAIL, Constants.TELEMETRY_DATA_REMOVAL_MSG_SUBJECT, emailBody);
  }
}
