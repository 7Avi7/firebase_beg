import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_beg/sendData.dart';
import 'package:flutter/material.dart';

class FetchData extends StatefulWidget {
  const FetchData({
    super.key,
  });

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Text('You Successfully logged in'),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 300,
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Users").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text('${index + 1}'),
                              ),
                              title: Text(
                                  '${snapshot.data!.docs[index]["title"]}'),
                              subtitle: Text(
                                  '${snapshot.data!.docs[index]["description"]}'),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.hasError.toString()),
                      );
                    } else {
                      return const Center(
                        child: Text('No Data Found'),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            const SendData(),
          ],
        ),
      ),
    );
  }
}
