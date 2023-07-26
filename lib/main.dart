import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Home' ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shadowColor: Colors.black,
        elevation: 2.5,
        
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              ),
         builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
           final user = FirebaseAuth.instance.currentUser;
           if(user?.emailVerified ?? false){
            print ('You are verified');
           }
           else{
            print('You need to verify your email first');
           }
           return Text('Done');
            default:  
            return const Text('Loading...');
          }
         }
      ),
    );
  }
}

