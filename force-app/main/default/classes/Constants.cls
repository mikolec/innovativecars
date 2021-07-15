/**
 * @description       : class containing global variables
 * @author            : Mikołaj Lechtański
 * @last modified on  : 15.07.2021
**/
public with sharing class Constants {
  public static final String T_ACCOUNT_NAME = 'Konto testowe';
  public static final String T_EMAIL = 'mikolec@gmail.com';
  public static final String VEHICLE_REMOVAL_MSG_SUBJECT = 'Sprawdzenie utylizacji pojazdu';
  public static final String VEHICLE_AVAILABLE_ERROR_MSG = 'Pojazd jest już dostępny w salonie';
  public static final String VEHICLE_DUPLICATE_ERROR_MSG = 'Pojazd nie może być dodany fizycznie do dwóch salonów jednocześnie';
  public static final String T_VEHICLE_BRAND = 'Tesla';
  public static final String T_VEHICLE_MODEL = 'Model testowy';
  public static final String T_VEHICLE_NAME_PREFIX = '90000';
  public static final String T_VEHICLE_STATE_NEW = 'Nowy';
  public static final String T_SHOWROOM_NAME = 'Test Showroom';
  public static final String SHOWROOM_STATUS_CLOSED = 'Test Showroom';
  public static final String T_TELEMETRY_TYPE_TEMPERATURE = 'temperatura';
  public static final String TELEMETRY_DATA_REMOVAL_MSG_SUBJECT = 'Usunięto dane telemetryczne';
  
}
