abstract class Constants {
  /////////////////images///////////////////////////
  static var splashImg =
      'https://images.unsplash.com/photo-1532364158125-02d75a0f7fb9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80';
  //////////////////hotels api/////////////////////

  static var allHotelsURL =
      'http://traveelagency-001-site1.ftempurl.com/travelagencyapi/Hotel';

  static var reserveHotel =
      'http://traveelagency-001-site1.ftempurl.com/travelagencyapi/Hotel/reservehotel';

  ///********************visa************************ */
  static var allvisaURL =
      "http://traveelagency-001-site1.ftempurl.com/travelagencyapi/Visa";
  static var visaTypeCountry =
      "http://traveelagency-001site1.ftempurl.com/travelagencyapi/Visa/GetVisaTypeByCountry?country=";

  static var visaConditionCountry =
      "http://traveelagency-001-site1.ftempurl.com/travelagencyapi/Visa/GetVisaConditionBasedOnCountry?country=";

  static var visaCondCountCategory =
      "http://traveelagency-001-site1.ftempurl.com/travelagencyapi/Visa/GetVisaConditionBasedOnCountryAndCategory?"; //country=Turkey&Category=requirments;
}
