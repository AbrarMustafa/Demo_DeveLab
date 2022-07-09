
class GetCountry{
  late GetAddress address;
  late String display_name;

  GetCountry(this.address, this.display_name);

  GetCountry.fromJson(Map<String, dynamic> json){
    address = GetAddress.fromJson(json['address']);
    display_name = json['display_name']!=null?json['display_name']:"";
  }

  Map<String, dynamic> toJson() =>
      {
        'address':  address.toJson(),
        'display_name': display_name,
      };
}

class GetAddress{
  late String city;
  late String country;
  late String country_code;

  GetAddress(this.city, this.country, this.country_code);

  GetAddress.fromJson(Map<String, dynamic> json){
    city = json['city']!=null?json['city']:"";
    country = json['country']!=null?json['country']:"";
    country_code = json['country_code']!=null?json['country_code']:"";
  }

  Map<String, dynamic> toJson() =>
      {
        'city': city,
        'country': country,
        'country_code': country_code,
      };
}
