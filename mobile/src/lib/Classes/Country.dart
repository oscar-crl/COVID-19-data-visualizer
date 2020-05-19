import 'dart:convert';

class Country {
  String country;
  int confirmed;
  int recovered;
  int critical;
  int deaths;
  double longitude;
  double latitude;


  Country({this.country, this.confirmed, this.recovered, this.critical, this.deaths, this.latitude, this.longitude});

  String getCountry() {
    return(this.country);
  }

  int getRecovered() {
    return(this.recovered);
  }

  int getCritical() {
    return(this.critical);
  }

  int getDeaths() {
    return(this.deaths);
  }

  double getLongitude() {
    return(this.longitude);
  }

  double getLatitude() {
    return(this.latitude);
  }

  Country.fromJson(Map<String, dynamic> json) {
    this.country = json["country"];
    this.confirmed = json["confirmed"];
    this.recovered = json["recovered"];
    this.critical = json["critical"];
    this.deaths = json["deaths"];
    this.latitude = json["latitude"];
    this.longitude = json["longitude"];
  }

  Map<String, dynamic> toJson() =>
      {
        'country': this.country,
        'confirmed': this.confirmed,
        'recovered': this.recovered,
        'critical': this.critical,
        'deaths': this.deaths,
        'latitude': this.latitude,
        'longitude': this.longitude,
      };
}