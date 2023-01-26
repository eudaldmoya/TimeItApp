import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../widgets/create_worker_account.dart';

class EmployerProfileScreen extends StatelessWidget {
  const EmployerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employer Profile')),
      body: Stack(
        children: [
          LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Image.asset('assets/back2.png',
                fit: BoxFit.cover, width: constraints.maxWidth);
          }),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: CircleAvatar(radius: 80),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .doc('/Company/kGCOpHgRyiIYLr4Fwuys')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasError) {
                      return ErrorWidget(snapshot.error.toString());
                    }
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    final doc = snapshot.data!;
                    final name = doc['companyName'];
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${name}',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.verified_user,
                              color: Color.fromARGB(255, 38, 45, 109)),
                        ],
                      ),
                    );
                  },
                ),
                CreateWorkerAccount(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
