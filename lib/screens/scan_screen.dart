import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool atWork = false;
  final db = FirebaseFirestore.instance;
  final userPath = '/Company/kGCOpHgRyiIYLr4Fwuys/User/9owrui5NveI2u9XqgMxE';
  Future<void> updateAtWork() async {
    await db.doc(userPath).update({
      'atWork': atWork,
    });
    setState(() {
      atWork = !atWork;
    });
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: StreamBuilder(
          stream: db
              .doc(
                  '/Company/kGCOpHgRyiIYLr4Fwuys/User/CAloQhHUUqQK3ZGR8vjcl6FGQuA3')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return ErrorWidget(snapshot.error.toString());
            }
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            final doc = snapshot.data!;

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  doc['name'],
                  style: const TextStyle(fontSize: 32),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    updateAtWork();
                  },
                  icon: Icon(Icons.start),
                  label: Text("Start"),
                ),
                doc['atWork'] ? Text('true') : Text('false')
              ],
            );
          },
        )),
      ),
    );
  }
}
