import 'package:bts_technologie/mainpage/domaine/Entities/entreprise_entity.dart';

class EntrepriseModel extends Entreprise {
  const EntrepriseModel({
     String? name,
     String? adresse,
     num? numberRC,
     int? numberIF,
     int? numberART,
     int? numberRIB,
     int? phoneNumber,
  }) : super(
            name: name,
            numberRC: numberRC,
            numberIF: numberIF,
            numberART: numberART,
            numberRIB: numberRIB,
            adresse: adresse,
            phoneNumber: phoneNumber);

  factory EntrepriseModel.fromJson(Map<String, dynamic> json) {
    return EntrepriseModel(
      name: json["name"],
      numberRC: json["numberRC"],
      numberIF: json["numberIF"],
      numberART: json["numberART"],
      numberRIB: json["numberRIB"],
      adresse: json["addresse"],
      phoneNumber: json["phoneNumber"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "numberRC": numberRC,
      "numberIF": numberIF,
      "numberART": numberART,
      "numberRIB": numberRIB,
      "addresse": adresse,
      "phoneNumber": phoneNumber
    };
  }
}
