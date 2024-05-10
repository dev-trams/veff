import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 채팅 화면 [외주]
/// made by Ctrls-STUDIO
///
/// request parm..
/// String name | 수신자 이름
/// String otherName | 발신자 이름
/// String uid | 발신자 UID (현재 사용하는 부분 없음) 보안 목적으로 수신자 및 발신자 uid로
///   룸 주고를 잡으려고 했으나 룸 이름을 다른 방식으로 사용하여 없애도 괜찮습니다.
/// String age | 발신자 나이
/// String profileImage 발신자 프로필 이미지
class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.name,
    required this.otherName,
    required this.uid,
    required this.age,
    required this.profileImage,
  }) : super(key: key);

  final String name;
  final String otherName;
  final String uid;
  final int age;
  final String profileImage;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> chatDatas = [];
  late DatabaseReference roomRef;

  @override
  void initState() {
    super.initState();
    // Firebase Realtime Database의 채팅방 Reference 설정
    String roomId = generateRoomId(widget.name, widget.otherName);
    roomRef =
        FirebaseDatabase.instance.ref('rooms').child(roomId).child('messages');

    // Firebase Realtime Database의 메시지 추가 이벤트 리스너 등록
    roomRef.onChildAdded.listen((event) {
      Map<dynamic, dynamic> messageData =
          event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        chatDatas.add({
          'key': event.snapshot.key,
          'senderId': messageData["senderId"],
          'receiverId': messageData["receiverId"],
          'message': messageData["message"],
          'timestamp': messageData["timestamp"],
        });
      });
      // 새로운 메시지가 추가될 때 스크롤을 맨 아래로 이동
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  /// room key 제네레이터
  String generateRoomId(String senderId, String receiverId) {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String roomId = ids.join("_");
    return roomId;
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      String message = messageController.text.trim();
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      String senderId = widget.name;
      String receiverId = widget.otherName;

      // 메시지 전송
      roomRef.push().set({
        "senderId": senderId,
        "receiverId": receiverId,
        "message": message,
        "timestamp": timestamp,
      }).onError((error, stackTrace) => throw stackTrace);

      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.profileImage);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: SimpleAppBar(
        profileImage: widget.profileImage,
        name: widget.otherName,
        age: widget.age.toString(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: chatDatas.length,
                  itemBuilder: (context, index) {
                    final data = chatDatas.reversed.toList()[index];
                    //만약 수신자의 이름이 본인의 이름과 같다면 오른쪽 끝에 배치 아니라면 왼쪽 끝에
                    //배치하여 상대방의 채팅방과 구분
                    if (data['senderId'] == widget.name) {
                      return _buildMyMessage(
                          data['message'], data['timestamp']);
                    } else {
                      return _buildOtherMessage(
                          data['message'], data['timestamp']);
                    }
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    dragStartBehavior: DragStartBehavior.down,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 50),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: messageController,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.start,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: '메시지 입력',
                          hintStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => sendMessage(),
                  icon: Icon(
                    Icons.send,
                    color: messageController.text.isEmpty
                        ? Colors.grey
                        : Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyMessage(String message, int timestamp) {
    //발송 시간 timestamp decode 소스
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final realDate = '${date.year}-${date.month}-${date.day}';
    final realTime = '${date.hour}:${date.minute}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          textAlign: TextAlign.start,
          '$realDate $realTime',
          style: const TextStyle(color: Colors.grey),
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5, // 화면 너비의 50%로 설정
          ),
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Colors.blue, // 말풍선 색상 지정
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildOtherMessage(String message, int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final realDate = '${date.year}-${date.month}-${date.day}';
    final realTime = '${date.hour}:${date.minute}';
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.profileImage),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            padding: const EdgeInsets.all(8.0),
            constraints: BoxConstraints(
              maxWidth:
                  MediaQuery.of(context).size.width * 0.5, // 화면 너비의 50%로 설정
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300], // 말풍선 색상 지정
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          Text(
            textAlign: TextAlign.start,
            '$realDate $realTime',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

//* 커스텀 앱바
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SimpleAppBar({
    Key? key,
    required this.profileImage,
    required this.name,
    required this.age,
  }) : super(key: key);

  final String profileImage;
  final String name;
  final String age;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(profileImage),
              ),
            ),
          ),
          Text(
            '$name, $age',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                '나가기',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
