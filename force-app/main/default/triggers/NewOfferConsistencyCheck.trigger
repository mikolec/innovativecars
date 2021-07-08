trigger NewOfferConsistencyCheck on Offer__c (before insert, before update) {
  Offer__c[] offersWithVehiclesPresent = [SELECT Vehicle__c, Showroom__c
                                            FROM Offer__c 
                                           WHERE present__c = True];

  Map<String, String> vehiclesIdsOffer = new Map<String, String>();
  for(Offer__c oldOff : offersWithVehiclesPresent) {
    vehiclesIdsOffer.put(oldOff.Vehicle__c, oldOff.Showroom__c);
  }

  for (Offer__c off : Trigger.new) {
    if( off.present__c && vehiclesIdsOffer.containsKey(off.Vehicle__c)) {
      List<Showroom__c> showRooms = [SELECT Name 
                                      FROM Showroom__c 
                                     WHERE Id=:vehiclesIdsOffer.get(off.Vehicle__c)];
      off.addError('Pojazd jez juz dostępny w salonie ' + showRooms[0].Name);  
    }
  }
}