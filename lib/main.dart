import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kicker_app/firebase_options.dart';
import 'package:kicker_app/models/organization.dart';
import 'package:kicker_app/services/service_organization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder<DocumentSnapshot<Organization>>(
        stream: OrganizationService.stream("123456789abcd"),
        builder: (context, snap) {
          if (snap.hasData) {
            return ListView(
              children: (snap.data?.data()?.users.values ?? [])
                  .map((value) => ListTile(
                        title: Text(value.name),
                        subtitle: Text(value.id),
                      ))
                  .toList(),
            );
          }

          if (snap.hasError) {
            debugPrint("error: ${snap.error}");
            return Center(
              child: Text(
                "Something went wrong: ${snap.error}",
                textAlign: TextAlign.center,
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
