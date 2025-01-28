import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:teste/services/roteador.dart';
import 'firebase_options.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)  async{
    await Firebase.initializeApp();

    print('#### Hadling a backgrond message, ${message.messageId}');
}

@override



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RoteadorTelas(),
    );
  }
}
