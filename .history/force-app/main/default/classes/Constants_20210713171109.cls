/**
 * @description       : class containing global variables
 * @author            : Mikołaj Lechtański
 * @last modified on  : 13.07.2021
**/
public with sharing class Constants {
  public static final String VEHICLE_REMOVAL_MSG_SUBJECT = 'Sprawdzenie utylizacji pojazdu';
  public static final String VEHICLE_AVAILABLE_ERROR_MSG = 'Pojazd jest już dostępny w salonie';
  public static final String VEHICLE_DUPLICATE_ERROR_MSG = 'Pojazd nie może być dodany fizycznie do dwóch salonów jednocześnie';
}
