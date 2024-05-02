import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  //personal info
  String? uid;
  String? imageProfile;
  String? email;
  String? password;
  String? name;
  int? age;
  String? phoneNo;
  String? city;
  String? country;
  String? profileHeading;
  String? lookingForInaPartner;
  int? publishedDateTime;

  //Life style
  String? drink;
  String? smoke;
  String? martialStatus;
  String? haveChildren;
  String? noOfChildren;
  String? profession;
  String? employmentStatus;
  String? income;
  String? livingSituation;
  String? willingToRelocate;
  String? relationshipYouAreLookingFor;

  //Appearance
  String? height;
  String? weight;
  String? bodyType;

  //Background - Cultural Values
  String? nationality;
  String? education;
  String? languageSpoken;
  String? religion;
  String? ethnicity;

  Person({
    //personal info
    this.uid,
    this.imageProfile,
    this.email,
    this.password,
    this.name,
    this.age,
    this.phoneNo,
    this.city,
    this.country,
    this.profileHeading,
    this.lookingForInaPartner,
    this.publishedDateTime,

    //appearance
    this.height,
    this.weight,
    this.bodyType,

    //Life Style
    this.drink,
    this.smoke,
    this.martialStatus,
    this.haveChildren,
    this.noOfChildren,
    this.profession,
    this.employmentStatus,
    this.income,
    this.livingSituation,
    this.willingToRelocate,
    this.relationshipYouAreLookingFor,

    //Background - Cultural Values
    this.nationality,
    this.education,
    this.languageSpoken,
    this.religion,
    this.ethnicity,
  });

  static Person fromdataSnapshot(DocumentSnapshot snapshot) {
    var dataSnaptshot = snapshot.data() as Map<String, dynamic>;

    return Person(
      //personal info
      uid: dataSnaptshot["uid"],
      name: dataSnaptshot["name"],
      imageProfile: dataSnaptshot["imageProfile"],
      email: dataSnaptshot["email"],
      password: dataSnaptshot["password"],
      age: dataSnaptshot["age"],
      phoneNo: dataSnaptshot["phoneNo"],
      city: dataSnaptshot["city"],
      country: dataSnaptshot["country"],
      profileHeading: dataSnaptshot["profileHeading"],
      lookingForInaPartner: dataSnaptshot["lookingForInaPartner"],
      publishedDateTime: dataSnaptshot["publishedDateTime"],

      //appearance
      height: dataSnaptshot["height"],
      weight: dataSnaptshot["weight"],
      bodyType: dataSnaptshot["bodyType"],

      //Life Style
      drink: dataSnaptshot["drink"],
      smoke: dataSnaptshot["smoke"],
      martialStatus: dataSnaptshot["martialStatus"],
      haveChildren: dataSnaptshot["haveChildren"],
      noOfChildren: dataSnaptshot["noOfChildren"],
      profession: dataSnaptshot["profession"],
      employmentStatus: dataSnaptshot["employmentStatus"],
      income: dataSnaptshot["income"],
      livingSituation: dataSnaptshot["livingSituation"],
      willingToRelocate: dataSnaptshot["willingToRelocate"],
      relationshipYouAreLookingFor:
          dataSnaptshot["relationshipYouAreLookingFor"],

      //Background - Cultural Values
      nationality: dataSnaptshot["nationality"],
      education: dataSnaptshot["education"],
      languageSpoken: dataSnaptshot["languageSpoken"],
      religion: dataSnaptshot["religion"],
      ethnicity: dataSnaptshot["ethnicity"],
    );
  }

  Map<String, dynamic> toJson() => {
        //personal info
        "uid": uid,
        "imageProfile": imageProfile,
        "email": email,
        "password": password,
        "name": name,
        "age": age,
        "phoneNo": phoneNo,
        "city": city,
        "country": country,
        "profileHeading": profileHeading,
        "lookingForInaPartner": lookingForInaPartner,
        "publishedDateTime": publishedDateTime,

        //Appearance
        "height": height,
        "weight": weight,
        "bodyType": bodyType,

        //Life Style
        "drink": drink,
        "smoke": smoke,
        "martialStatus": martialStatus,
        "haveChildren": haveChildren,
        "noOfChildren": noOfChildren,
        "profession": profession,
        "employmentStatus": employmentStatus,
        "income": income,
        "livingSituation": livingSituation,
        "willingToRelocate": willingToRelocate,
        "relationshipYouAreLookingFor": relationshipYouAreLookingFor,

        //Background - Cultural Values
        "nationality": nationality,
        "education": education,
        "languageSpoken": languageSpoken,
        "religion": religion,
        "ethnicity": ethnicity,
      };
}
