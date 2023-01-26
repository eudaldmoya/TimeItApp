import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:timeitapp/firebase_options.dart';
import 'package:timeitapp/screens/chat_screen.dart';
import 'package:timeitapp/screens/employer_profile_screen.dart';
import 'package:timeitapp/screens/scan_screen.dart';
import 'package:timeitapp/screens/worker_profile_screen.dart';
import 'package:timeitapp/screens/workers_list_screen.dart';
import 'package:timeitapp/widgets/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const AuthGate(
      app: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  DocumentReference userStatus = FirebaseFirestore.instance.doc(
      '/Company/kGCOpHgRyiIYLr4Fwuys/User/${FirebaseAuth.instance.currentUser!.uid}');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final List<Widget> _pagesWorker = <Widget>[
      Scan_Screen(),
      ChatScreen(),
      ProfileScreen(),
    ];
    final List<Widget> _pagesAdmin = <Widget>[
      WorkersListScreen(),
      ChatScreen(),
      EmployerProfileScreen(),
    ];

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color.fromARGB(255, 57, 67, 156),
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        body: Center(
            child: FutureBuilder<DocumentSnapshot>(
          future: userStatus.get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return ErrorWidget(snapshot.error.toString());
            }
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            final doc = snapshot.data!;
            print(doc['admin']);
            return doc['admin']
                ? _pagesAdmin.elementAt(_selectedIndex)
                : _pagesWorker.elementAt(_selectedIndex);
          },
        )),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Scan'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}




















/*bool atWork = false;
  final db = FirebaseFirestore.instance;
  final userPath = '/Company/kGCOpHgRyiIYLr4Fwuys/User/CAloQhHUUqQK3ZGR8vjcl6FGQuA3';
  Future<void> updateAtWork() async {
    await db.doc(userPath).update({
      'atWork': atWork,
    });
    setState(() {
      atWork = !atWork;
    });
  }


Scaffold ScanPage(FirebaseFirestore db) {
    return Scaffold(
      body: Center(
          child: StreamBuilder(
        stream: db
            .doc('/Company/kGCOpHgRyiIYLr4Fwuys/User/CAloQhHUUqQK3ZGR8vjcl6FGQuA3')
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
    );
  }*/
