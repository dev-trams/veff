import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vestfriend_123_a3/controllers/authentication_controller.dart';
import 'package:vestfriend_123_a3/widgets/custom_text_field_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //Personal info
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
  TextEditingController phoneNoTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController countryTextEditingController = TextEditingController();
  TextEditingController profileHeadingTextEditingController =
      TextEditingController();
  TextEditingController lookingForInaPartnerTextEditingController =
      TextEditingController();

  //Appearance
  TextEditingController heightTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();
  TextEditingController bodyTypeTextEditingController = TextEditingController();

  //Life Style
  TextEditingController drinkTextEditingController = TextEditingController();
  TextEditingController smokeTextEditingController = TextEditingController();
  TextEditingController martialStatusTextEditingController =
      TextEditingController();
  TextEditingController haveChildrenTextEditingController =
      TextEditingController();
  TextEditingController noOfChildrenTextEditingController =
      TextEditingController();
  TextEditingController professionTextEditingController =
      TextEditingController();
  TextEditingController employmentStatusTextEditingController =
      TextEditingController();
  TextEditingController incomeTextEditingController = TextEditingController();
  TextEditingController livingSituationTextEditingController =
      TextEditingController();
  TextEditingController willingToRelocateTextEditingController =
      TextEditingController();
  TextEditingController relationshipYouAreLookingForTextEditingController =
      TextEditingController();

  //Background - Cultural Values
  TextEditingController nationalityTextEditingController =
      TextEditingController();
  TextEditingController educationTextEditingController =
      TextEditingController();
  TextEditingController languageSpokenTextEditingController =
      TextEditingController();
  TextEditingController religionTextEditingController =
  TextEditingController();
  TextEditingController ethnicityTextEditingController =
      TextEditingController();

  bool showProgressBar = false;

  var authenticationController = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),

              const Text(
                "Creat Account",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "to get Started Now.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              //choose image circle
              authenticationController.imageFile == null
                  ? const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage("images/logo1.PNG"),
                      backgroundColor: Colors.black,
                    )
                  : Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: FileImage(
                              File(
                                authenticationController.imageFile!.path,
                              ),
                            ),
                          )),
                    ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await authenticationController.pickImageFileFromGallery();
                      setState(() {
                        authenticationController.imageFile;
                      });
                    },
                    icon: const Icon(
                      Icons.image_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () async {
                      await authenticationController
                          .captureImageFromPhoneCamera();

                      setState(() {
                        authenticationController.imageFile;
                      });
                    },
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 30,
              ),

              //personal info
              const Text(
                "Personal Info:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              //name
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: nameTextEditingController,
                  lableText: "Name",
                  iconData: Icons.person_outline,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //email
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: emailTextEditingController,
                  lableText: "Email",
                  iconData: Icons.email_outlined,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //password
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: passwordTextEditingController,
                  lableText: "Password",
                  iconData: Icons.lock_outlined,
                  isObscure: true,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //age
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: ageTextEditingController,
                  lableText: "Age",
                  iconData: Icons.numbers,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //gender
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: genderTextEditingController,
                  lableText: "Gender",
                  iconData: Icons.person_pin,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //phoneNo

              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: phoneNoTextEditingController,
                  lableText: "Phone",
                  iconData: Icons.phone,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //city

              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: cityTextEditingController,
                  lableText: "City",
                  iconData: Icons.location_city,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //country

              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: countryTextEditingController,
                  lableText: "Country",
                  iconData: Icons.location_city,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //profileHeading

              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: profileHeadingTextEditingController,
                  lableText: "Profile Heading",
                  iconData: Icons.text_fields,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //lookingForInaPartner

              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: lookingForInaPartnerTextEditingController,
                  lableText: "What you are looking for in a partner",
                  iconData: Icons.face,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //Appearance

              const Text(
                "Appearance:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              //height
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: heightTextEditingController,
                  lableText: "Height",
                  iconData: Icons.insert_chart,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //weight
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: weightTextEditingController,
                  lableText: "Weight",
                  iconData: Icons.table_chart,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //bodyType
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: bodyTypeTextEditingController,
                  lableText: "Body Type",
                  iconData: Icons.type_specimen,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //Life Style

              const Text(
                "Life style:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              //drink
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: drinkTextEditingController,
                  lableText: "Drink",
                  iconData: Icons.local_drink_outlined,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //smoke
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: smokeTextEditingController,
                  lableText: "Smoke",
                  iconData: Icons.smoking_rooms,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //martialStatus
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: martialStatusTextEditingController,
                  lableText: "Martial Status",
                  iconData: CupertinoIcons.person_2,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //haveChildren
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: haveChildrenTextEditingController,
                  lableText: "Do you have Children?",
                  iconData: CupertinoIcons.person_3_fill,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //noOfChildren
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: noOfChildrenTextEditingController,
                  lableText: "Number of Children",
                  iconData: CupertinoIcons.person_3_fill,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //profession
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: professionTextEditingController,
                  lableText: "Profession",
                  iconData: Icons.business_center,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //employmentStatus
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: employmentStatusTextEditingController,
                  lableText: "Employment Status",
                  iconData: CupertinoIcons.rectangle_stack_person_crop_fill,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //income
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: incomeTextEditingController,
                  lableText: "Income",
                  iconData: CupertinoIcons.money_dollar_circle,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //livingSituation
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: livingSituationTextEditingController,
                  lableText: "Living Situation",
                  iconData: CupertinoIcons.person_2_square_stack,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //willingToRelocate
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: willingToRelocateTextEditingController,
                  lableText: "Are you willing to Relocate?",
                  iconData: CupertinoIcons.person_2,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //relationshipYouAreLookingFor
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController:
                      relationshipYouAreLookingForTextEditingController,
                  lableText: "What relationship you are looking for?",
                  iconData: CupertinoIcons.person_2,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //Background - Cultural Values

              const Text(
                "Background - Cultural Values:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              //nationality
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: nationalityTextEditingController,
                  lableText: "Nationality",
                  iconData: Icons.flag_circle_outlined,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //education
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: educationTextEditingController,
                  lableText: "Education",
                  iconData: Icons.history_edu,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //languageSpoken
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: languageSpokenTextEditingController,
                  lableText: "Language Spoken",
                  iconData: CupertinoIcons.person_badge_plus_fill,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //religion
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: religionTextEditingController,
                  lableText: "Religion",
                  iconData: CupertinoIcons.checkmark_seal_fill,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //ethnicity
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: ethnicityTextEditingController,
                  lableText: "Ethnicity",
                  iconData: CupertinoIcons.eye,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              //create account button
              Container(
                width: MediaQuery.of(context).size.width - 36,
                height: 50,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    )),
                child: InkWell(
                  onTap: () async {
                    if (authenticationController.imageFile != null) {
                      if (
                          //personal info
                          nameTextEditingController.text.trim().isNotEmpty &&
                              emailTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              passwordTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              ageTextEditingController.text.trim().isNotEmpty &&
                              genderTextEditingController.text.trim().isNotEmpty &&
                              phoneNoTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              cityTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              countryTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              profileHeadingTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              lookingForInaPartnerTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&

                              //Appearance
                              heightTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              weightTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              bodyTypeTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&

                              //Life Style
                              drinkTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              smokeTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              martialStatusTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              haveChildrenTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              noOfChildrenTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              professionTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              employmentStatusTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              incomeTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              livingSituationTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              willingToRelocateTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              relationshipYouAreLookingForTextEditingController
                                  .text
                                  .trim()
                                  .isNotEmpty &&

                              //Background - Cultural Values
                              nationalityTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              educationTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              languageSpokenTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              religionTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              ethnicityTextEditingController.text
                                  .trim()
                                  .isNotEmpty) {
                        setState(() {
                          showProgressBar = true;
                        });

                        await authenticationController.createNewUserAccount(
                          //personal info
                          authenticationController.profileImage!,
                          emailTextEditingController.text.trim(),
                          passwordTextEditingController.text.trim(),
                          nameTextEditingController.text.trim(),
                          ageTextEditingController.text.trim(),
                          genderTextEditingController.text.trim(),
                          phoneNoTextEditingController.text.trim(),
                          cityTextEditingController.text.trim(),
                          countryTextEditingController.text.trim(),
                          profileHeadingTextEditingController.text.trim(),
                          lookingForInaPartnerTextEditingController.text.trim(),

                          //Appearance
                          heightTextEditingController.text.trim(),
                          weightTextEditingController.text.trim(),
                          bodyTypeTextEditingController.text.trim(),

                          //Life Style
                          drinkTextEditingController.text.trim(),
                          smokeTextEditingController.text.trim(),
                          martialStatusTextEditingController.text.trim(),
                          haveChildrenTextEditingController.text.trim(),
                          noOfChildrenTextEditingController.text.trim(),
                          professionTextEditingController.text.trim(),
                          employmentStatusTextEditingController.text.trim(),
                          incomeTextEditingController.text.trim(),
                          livingSituationTextEditingController.text.trim(),
                          willingToRelocateTextEditingController.text.trim(),
                          relationshipYouAreLookingForTextEditingController.text
                              .trim(),

                          //Background - Cultural Values
                          nationalityTextEditingController.text.trim(),
                          educationTextEditingController.text.trim(),
                          languageSpokenTextEditingController.text.trim(),
                          religionTextEditingController.text.trim(),
                          ethnicityTextEditingController.text.trim(),
                        );
                        setState(() {
                          showProgressBar = false;
                          authenticationController.imageFile == null;
                        });
                      } else {
                        Get.snackbar("A Field is Empty",
                            "Please fill out all field in text fields.");
                      }
                    } else {
                      Get.snackbar("Image File Missing",
                          "Please pick image from Gallery or capture with Camera");
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),
              // already have an account login here button

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Text(
                      "Login Here",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 16,
              ),

              showProgressBar == true
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                    )
                  : Container(),

              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
