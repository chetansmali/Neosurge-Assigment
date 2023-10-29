import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:neosurge_finance/src/data/repositories/firebase.dart';
import 'package:neosurge_finance/src/presentation/views/login_screen.dart';
import 'package:neosurge_finance/src/presentation/widgets/custom_button.dart';
import 'package:neosurge_finance/src/presentation/widgets/custome_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'signup_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController= TextEditingController();
  final TextEditingController _ConfirmController = TextEditingController();
  final _signupFormKey = GlobalKey<FormState>();
  bool _saving = false;
  bool value = false;
  bool _isOnSignupScreen = true;


  @override
  Widget build(BuildContext context) {

    return  WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: LoadingOverlay(
            isLoading: _saving,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const TopScreenImage(screenImageName: 'welcome.png'),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _signupFormKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const ScreenTitle(title: 'Sign Up'),
                                SizedBox(height: 15,),

                                CustomTextField(controller: _nameController, hintText: "Name"),
                                SizedBox(height: 10,),
                                CustomTextField(controller: _emailController, hintText: 'Email'),
                                SizedBox(height: 10,),
                                CustomTextField(controller: _passwordController, hintText: "Passwoord"),
                                SizedBox(height: 10,),
                                CustomTextField(controller: _ConfirmController, hintText: 'Confirm password'),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                        checkColor: Colors.white,
                                        value: value,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.value = value! ;
                                          });
                                        }),
                                    Text('I agree term and condition'),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                CustomButton(buttonText: 'Signup', onPressed: () async {
                                    if (_ConfirmController.text ==
                                        _passwordController.text &&
                                        _nameController.text.isNotEmpty &&
                                        _emailController.text.isNotEmpty)
                                    {
                                      if(value) {
                                      try {

                                        var obj = FirebaseHandler(
                                            _ConfirmController.text,
                                            _nameController.text,
                                            email:_emailController.text,
                                            _passwordController.text);

                                             obj.signup();

                                        if (context.mounted) {
                                            final snackBar = SnackBar(
                                              content: Center(
                                                  child: const Text(' Register successfully')),
                                              backgroundColor: Colors.red[400],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10)),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                            Navigator.popAndPushNamed(context, LoginScreen.id);
                                        }
                                      } catch (e) {
                                          final snackBar = SnackBar(
                                            content: Center(
                                                child: Text(
                                                    'Something went worong' + e.toString())),
                                            backgroundColor: Colors.red[400],
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                      }
                                    }
                                    else  {
                                        final snackBar = SnackBar(
                                          content: Center(
                                              child: const Text(
                                                  'Agress the condition')),
                                          backgroundColor: Colors.red[400],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                  }
                                  else
                                  {
                                  final snackBar = SnackBar(
                                  content: Center(
                                  child: const Text(
                                  'Format mismatch(email/password)')),
                                  backgroundColor: Colors.red[400],
                                  shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  }
                                }),
                                TextButton(
                                    onPressed: () {
                                      Navigator.popAndPushNamed(
                                          context, LoginScreen.id);
                                    },
                                    child: Text(
                                      'Have a account? Login ',
                                      style: TextStyle(color: Colors.grey),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
  Future<bool> _onBackPressed() async {
    if (_isOnSignupScreen) {
      // Ask the user if they want to exit the app
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App?'),
          content: Text('Do you want to exit the app?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
              child: Text('Yes'),
              onPressed: () {
                // Exit the app
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ) ?? false;
    } else {
      return true;
    }
  }
}

