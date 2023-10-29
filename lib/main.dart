import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosurge_finance/helpers/firebase_options.dart';
import 'package:neosurge_finance/src/presentation/bloc/transaction_bloc/transation_bloc.dart';
import 'package:neosurge_finance/src/presentation/views/Transation_screen.dart';
import 'package:neosurge_finance/src/presentation/views/home_page.dart';
import 'package:neosurge_finance/src/presentation/views/login_screen.dart';
import 'package:neosurge_finance/src/presentation/views/profile_screen.dart';
import 'package:neosurge_finance/src/presentation/views/signup_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    BlocProvider(
        create: (context) => TransationBloc(),
      child: MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
    debugShowCheckedModeBanner: false,
    initialRoute:   LoginScreen.id,
    routes: {
      LoginScreen.id: (context) => LoginScreen(),
      SignUpScreen.id: (context) => SignUpScreen(),
      HomePage.id: (context) => HomePage(),
      ProfilePage.id: (context) => ProfilePage(),
      TransationScreen.id: (context) => TransationScreen(),
    },
    home: Container(),
    );
  }
}

