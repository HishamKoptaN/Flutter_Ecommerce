import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Firebase/database_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentUser.email ?? "Not Signed",
          style: TextStyle(color: Colors.teal),
        ),
      ),
      body: getImage(),
    );
  }

  FutureBuilder<dynamic> getImage() {
    return FutureBuilder(
      future: FireStoreDataBase().getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text(
            "Something went wrong",
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          var poto;
          return Center(
            child: Image.network(
              snapshot.data.toString(poto),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
