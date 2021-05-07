import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:lms/models/books.dart';
import 'package:lms/models/tabs.dart';
import 'package:lms/services/auth.dart';
import 'package:lms/views/home.dart';
import 'package:lms/views/login.dart';
import 'package:lms/views/profile.dart';
import 'package:lms/views/register.dart';
import 'package:lms/views/splash.dart';
import 'package:lms/widgets/imageUpload.dart';
import 'package:provider/provider.dart';
import 'package:lms/models/user.dart';
import 'services/search.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue[50],
      statusBarIconBrightness: Brightness.dark));
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Text('An Unexpected Error occured! :(')));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        return Center(
            child: Container(
                height: 100, width: 100, child: CircularProgressIndicator()));
      },
    );
  }
}

class MyApp extends StatelessWidget {
  final _firebaseAuthUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final _auth = Auth(firebaseAuth: _firebaseAuthUser);
    return MultiProvider(
      providers: [
        Provider<Auth>(
          create: (context) => _auth,
        ),
        ChangeNotifierProvider<TabViews>(
          create: (context) => TabViews(),
        ),
        ChangeNotifierProvider<Search>(create: (context) => Search()),
        ChangeNotifierProvider<LMSUser>(create: (context) => LMSUser()),
        // ChangeNotifierProvider<AllFirebaseBooks>(
        //     create: (context) => AllFirebaseBooks())
        // StreamProvider<CustomUser?>.value(
        //   value: _auth.authStateChanges,
        //   initialData: CustomUser(
        //       uid: _firebaseAuthUser.currentUser != null
        //           ? _firebaseAuthUser.currentUser!.uid
        //           : null),
        // )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashPage.id,
        routes: {
          RegisterPage.id: (context) => RegisterPage(),
          LoginPage.id: (context) => LoginPage(),
          SplashPage.id: (context) => SplashPage(),
          HomePage.id: (context) => HomePage(),
          ProfilePage.id: (context) => ProfilePage(),
          ImageUploader.id: (context) => ImageUploader()
        },
      ),
    );
  }
}
