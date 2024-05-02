import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vestfriend_123_a3/controllers/profile-controller.dart';
import 'package:vestfriend_123_a3/global.dart';
import 'package:vestfriend_123_a3/tabScreens/user_details_screen.dart';

class SwippingScreen extends StatefulWidget
{
  const SwippingScreen({super.key});

  @override
  State<SwippingScreen> createState() => _SwippingScreenState();
}

class _SwippingScreenState extends State<SwippingScreen>
{
  ProfileController profileController = Get.put(ProfileController());
  String senderName = "";

  applyFilter()
  {
    showDialog(
      context: context,
      builder: (BuildContext context)
        {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setSetter)
                {
                  return AlertDialog(
                    title: const Text(
                      "Matching Filter",
                    ),
                    content: Column(
                    mainAxisSize: MainAxisSize.min,
                      children: [

                        const Text("I am looking for a:"),

                      ],
                    ),
                  );
                },
          );
        }
    );
  }

  readCurrentUserData() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .get()
        .then((dataSnapshot)
    {
       setState(() {
         senderName = dataSnapshot.data()!["name"].toString();
       });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    readCurrentUserData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()
      {
        return PageView.builder(
          itemCount: profileController.allUsersProfileList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index)
          {
            final eachProfileInfo = profileController.allUsersProfileList[index];

            return DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      eachProfileInfo.imageProfile.toString(),
                    ),
                    fit: BoxFit.cover,
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [

                    //Filter Icon Button
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: IconButton(
                            onPressed: ()
                            {

                            },
                            icon: const Icon(
                              Icons.filter_list,
                              size: 30,
                            ),
                          ),
                      ),
                    ),
                    const Spacer(),

                    //User Data
                    GestureDetector(
                      onTap: ()
                      {
                        profileController.viewSentAndViewRecevied(
                          eachProfileInfo.uid.toString(),
                          senderName,
                        );

                        //send user to profile person userDetailScreen

                        Get.to(UserDetailsScreen(
                            userID: eachProfileInfo.uid.toString(),
                        ));

                      },
                      child: Column(
                        children: [

                          //name
                          Text(
                            eachProfileInfo.name.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              letterSpacing: 4,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                              //age - city
                          Text(
                            eachProfileInfo.age.toString() + " ⦾ " + eachProfileInfo.city.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              letterSpacing: 4,

                            ),
                          ),

                          const SizedBox(
                            height: 4,
                          ),
                          
                          //profession and religion
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white30,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)
                                  ),

                                ),
                                child: Text(
                                  eachProfileInfo.profession.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 6,
                              ),

                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white30,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)
                                  ),

                                ),
                                child: Text(
                                  eachProfileInfo.religion.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //country and ethnicity
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white30,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)
                                  ),

                                ),
                                child: Text(
                                  eachProfileInfo.country.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 6,
                              ),

                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white30,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)
                                  ),

                                ),
                                child: Text(
                                  eachProfileInfo.ethnicity.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 14,
                    ),

                    //Image Buttons -favorite - chat - like
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        //favorite button
                        GestureDetector(
                          onTap: ()
                          {
                            profileController.favoriteSentAndFavoriteRecevied(
                              eachProfileInfo.uid.toString(),
                              senderName,

                            );

                          },
                          child: Image.asset(
                              "images/heart.png",
                            width: 60,
                          ),
                        ),

                        //chat button
                        GestureDetector(
                          onTap: ()
                          {

                          },
                          child: Image.asset(
                            "images/mobile.png",
                            width: 90,
                          ),
                        ),

                        //like button
                        GestureDetector(
                          onTap: ()
                          {
                            profileController.likeSentAndLikeRecevied(
                              eachProfileInfo.uid.toString(),
                              senderName,

                            );
                          },
                          child: Image.asset(
                            "images/super.png",
                            width: 60,
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
