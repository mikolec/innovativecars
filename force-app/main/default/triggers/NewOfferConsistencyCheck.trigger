/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 07.07.2021 
 * @description Trigger being fired on Offer insert or update  
 * @param before insert, before update
**/
trigger NewOfferConsistencyCheck on Offer__c (before insert, before update) {
  // Map<Ids> vehiclesPresentInOffer = new Map<Ids, Ids>();
  Map<Id, Id> vehiclesPresentShowroom = new Map<Id, Id>();
  for (Offer__c offer : Trigger.new) {
    if(offer.present__c) {
      vehiclesPresentShowroom.put(offer.Vehicle__c, offer.Showroom__c);
    }
  }

  List<Offer__c> existingOffersVehiclesPresent = [
    SELECT Vehicle__c, Showroom__c, Showroom__r.Name 
    FROM Offer__c 
    WHERE present__c = True AND Vehicle__c IN :vehiclesPresentShowroom.keySet()
  ];
  
  for(Offer__c offer : existingOffersVehiclesPresent) {
    offer.addError('Pojazd jez juz dostępny w salonie ' + offer.Showroom__r.Name); 
  }

}