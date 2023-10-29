import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neosurge_finance/src/presentation/views/login_screen.dart';
import 'package:neosurge_finance/src/presentation/widgets/app_bar.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static String id = 'ProfileScreen';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(name: "Profile",),

      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('User profile Details',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),),
            SizedBox(height: 50,),
            Container(
                width: 80.0,
                height: 80.0,
                margin: EdgeInsets.only(
                  left: 20,
                  top: 24.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/avatar-1.png')),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Name : ',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black54,
              )),
                SizedBox(width: 10,),
                Text(user.displayName!,style: TextStyle(
                fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.black,
                )),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Email : ',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black54,
                )),
                SizedBox(width: 10,),
                Text(user.email!,style: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15,
    color: Colors.black,
    )),
              ],
            ),
            SizedBox(height: 25,),
            ElevatedButton( onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, LoginScreen.id);
            }, child: Text('Logout')),
          ],
        )
      ),
    );
  }
}
