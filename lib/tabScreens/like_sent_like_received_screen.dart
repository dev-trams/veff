import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vestfriend_123_a3/global.dart';

class LikeSentLikeReceivedScreen extends StatefulWidget {
  const LikeSentLikeReceivedScreen({super.key});

  @override
  State<LikeSentLikeReceivedScreen> createState() =>
      _LikeSentLikeReceivedScreenState();
}

class _LikeSentLikeReceivedScreenState
    extends State<LikeSentLikeReceivedScreen> {

  bool isLikeSentClicked = true;
  List<String> likeSentList = [];
  List<String> likeReceivedList = [];
  List likeList = [];


  getLikedListKeys() async {

    if(isLikeSentClicked)
    {
      var likeSentDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("likeSent")
          .get();

      for(int i=0; i<likeSentDocument.docs.length; i++)
      {

        likeSentList.add(likeSentDocument.docs[i].id);
      }
      print("likeSentList = " + likeSentList.toString());
      getKeysDataFromUsersCollection(likeSentList);
    }
    else
    {

      // 나중에 에러 나면 likeReceivedDocument로 일괄 refactor name 수정해야될 여지 있음.
      var viewReceivedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("likeReceived")
          .get();

      for(int i=0; i<viewReceivedDocument.docs.length; i++)
      {

        likeReceivedList.add(viewReceivedDocument.docs[i].id);
      }

      print("likeReceivedList = " + likeReceivedList.toString());
      getKeysDataFromUsersCollection(likeReceivedList);
    }


  }

  getKeysDataFromUsersCollection(List<String> keysList) async
  {
    var allUsersDocument = await FirebaseFirestore.instance.collection("users").get();

    for(int i=0; i<allUsersDocument.docs.length; i++)
    {
      for(int k=0; k<keysList.length; k++)
      {
        if(((allUsersDocument.docs[i].data() as dynamic)["uid"]) == keysList[k])
        {
          likeList.add(allUsersDocument.docs[i].data());
        }
      }
    }

    setState(() {
      likeList;
    });

    print("likeList = " + likeList.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    getLikedListKeys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: ()
              {
                likeSentList.clear();
                likeSentList = [];
                likeReceivedList.clear();
                likeReceivedList = [];
                likeList.clear();
                likeList = [];


                setState(() {
                  isLikeSentClicked = true;
                });

                getLikedListKeys();
              },
              child: Text(
                "My Likes",
                style: TextStyle(
                  color: isLikeSentClicked ? Colors.white : Colors.grey,
                  fontWeight: isLikeSentClicked ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),

            const Text(
              "  |  ",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            TextButton(
              onPressed: ()
              {

                likeSentList.clear();
                likeSentList = [];
                likeReceivedList.clear();
                likeReceivedList = [];
                likeList.clear();
                likeList = [];

                setState(() {
                  isLikeSentClicked = false;
                });

                getLikedListKeys();
              },
              child: Text(
                "Liked Me",
                style: TextStyle(
                  color: isLikeSentClicked ? Colors.grey : Colors.white,
                  fontWeight: isLikeSentClicked ? FontWeight.normal : FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),

          ],
        ),
        centerTitle: true,
      ),
      body: likeList.isEmpty
          ? const Center(
        child: Icon(Icons.person_off_sharp, color: Colors.white, size: 60,),
      )
          : GridView.count(

        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        children: List.generate(likeList.length, (index){
          return GridTile(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                color: Colors.blue.shade200,
                child: GestureDetector(
                  onTap: (){
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(likeList[index]["imageProfile"],),
                          fit: BoxFit.cover,
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const Spacer(),

                            //name - age
                            Text(
                              likeList[index]["name"].toString() + " ⦿ " + likeList[index]["age"].toString(),
                              maxLines: 2,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 4,
                            ),

                            //icon - city - country
                            Row(
                              children: [

                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.grey,
                                  size: 16,
                                ),

                                Expanded(
                                  child: Text(
                                    likeList[index]["city"].toString() + " , " + likeList[index]["country"].toString(),
                                    maxLines: 2,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      // 즐겨찾기 화면 상세내역 색깔 변환 코드
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
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}