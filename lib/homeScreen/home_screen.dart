import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vestfriend_123_a3/pushNotificationSystem/push_notification_system.dart';
import 'package:vestfriend_123_a3/tabScreens/favorite_sent_favorite_received_screen.dart';
import 'package:vestfriend_123_a3/tabScreens/like_sent_like_received_screen.dart';
import 'package:vestfriend_123_a3/tabScreens/swipping_screen.dart';
import 'package:vestfriend_123_a3/tabScreens/user_details_screen.dart';
import 'package:vestfriend_123_a3/tabScreens/view_sent_view_received_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;

  List tabScreensList = [
    const SwippingScreen(),
    const ViewSentViewReceivedScreen(),
    const FavoriteSentFavoriteReceivedScreen(),
    LikeSentLikeReceivedScreen(
      userID: FirebaseAuth.instance.currentUser!.uid, // 사용자 uid 전달
    ),
    UserDetailsScreen(
      userID: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PushNotificationSystem notificationSystem = PushNotificationSystem();
    notificationSystem.generateDeviceRegistrationToken();
    notificationSystem.whenNotificationReceived(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indexNumber) {
          setState(() {
            screenIndex = indexNumber;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.purple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white12,
        currentIndex: screenIndex,
        items: const [
          //SwippingScreen
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: ""),

          //ViewSentViewReceived icon button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.remove_red_eye,
                size: 30,
              ),
              label: ""),

          //favoriteSentFavoriteReceived icon button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                size: 30,
              ),
              label: ""),

          //likeSentLikeReceived icon button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 30,
              ),
              label: ""),

          //userDetailsScreen icon button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: ""),

          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                size: 30,
              ),
              label: ""),
        ],
      ),
      body: tabScreensList[screenIndex],
    );
  }
}
