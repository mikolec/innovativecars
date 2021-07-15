/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 12.07.2021 
 * @description The trigger fires on Showroom Status being set to Closed
 * After trigger is fired new Case is created and HTTP Request is being sent
 **/

 trigger RenovationCaseOnClosed on Showroom__c (after update) {
  List<Showroom__c> showrooms = new List<Showroom__c>();
  for(Showroom__c showroom : Trigger.new) {
    if(showroom.Status__c != Trigger.oldMap.get(showroom.Id).Status__c 
      && showroom.Status__c == 'Zamknięty') {
        showrooms.add(showroom);
    }   
  }

  CreateShowroomsRenovationCase newRenCaseJob = new CreateShowroomsRenovationCase(showrooms);
  ID jobId = System.enqueueJob(newRenCaseJob);

  // RenovationCaseRequest requestJob = new RenovationCaseRequest(cases);
  // ID jobId = System.enqueueJob(requestJob);

}