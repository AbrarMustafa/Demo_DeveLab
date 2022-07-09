
class GetCovidItems{
  late int Active;
  late int Recovered;
  late int Deaths;
  late int Confirmed;
  late String Date;
  late String Lat;
  late String Lon;
  GetCovidItems(this.Active, this.Recovered, this.Deaths, this.Confirmed, this.Date );

  GetCovidItems.fromJson(Map<String, dynamic> json):
        Active = json['Active'],
        Recovered = json['Recovered'],
        Deaths = json['Deaths'],
        Confirmed = json['Confirmed'],
        Lat = json['Lat'],
        Lon = json['Lon'],
        Date = json['Date']{}

  Map<String, dynamic> toJson() =>
      {
        'Active': Active,
        'Recovered': Recovered,
        'Deaths': Deaths,
        'Confirmed': Confirmed,
        'Lat': Lat,
        'Lon': Lon,
        'Date': Date,
      };
}
