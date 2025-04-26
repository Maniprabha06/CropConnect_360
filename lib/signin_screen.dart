import 'dart:ui'; // <--- Important for blur effect
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';

import 'signup_screen.dart';
import 'forget_password_screen.dart';
import 'theme.dart';
import 'package:niral_prj/index.dart'; // Your HomePage or main screen

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  final TextEditingController emailPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberPassword = true;
  bool _obscureText = true;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to sign in with Google: $error")),
      );
    }
  }

  Future<void> _validateAndSignIn() async {
    if (_formSignInKey.currentState!.validate() && rememberPassword) {
      String input = emailPhoneController.text.trim();
      String password = passwordController.text;

      bool isValid = (input == 'krish7cbe@gmail.com' || input == '9095088888') && password == 'krishna' ||
                     (input == 'prabha6603@gmail.com' || input == '8754611677') && password == 'prabha' ||
                     (input == 'jjegan663@gmail.com' || input == '9894861698') && password == 'jegan';

      if (isValid) {
        emailPhoneController.clear();
        passwordController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign-in failed. Invalid credentials.')),
        );
      }
    } else if (!rememberPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the processing of personal data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/farmer.jpg', // Replace with your correct image path
            fit: BoxFit.cover,
          ),
          
          // Blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.2), // Optional: soft dark overlay
            ),
          ),

          // Main Content
          Column(
            children: [
              const Expanded(flex: 1, child: SizedBox(height: 10)),
              Expanded(
                flex: 7,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                  decoration: const BoxDecoration(
                    color: Colors.white54, // Semi-transparent white container
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formSignInKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/niral_split.png', height: 150),
                          const SizedBox(height: 20.0),
                          Text(
                            'Welcome back',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                              color: lightColorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          // Email field
                          TextFormField(
                            controller: emailPhoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Email or Phone Number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Email or Phone'),
                              hintText: 'Enter Email or Phone',
                              hintStyle: const TextStyle(color: Colors.black26),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25.0),
                          // Password field
                          TextFormField(
                            controller: passwordController,
                            obscureText: _obscureText,
                            obscuringCharacter: '*',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a Password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Password'),
                              hintText: 'Enter Password',
                              hintStyle: const TextStyle(color: Colors.black26),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.black26,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 25.0),
                          // Remember Me and Forgot Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: rememberPassword,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        rememberPassword = value!;
                                      });
                                    },
                                    activeColor: lightColorScheme.primary,
                                  ),
                                  const Text('Remember me', style: TextStyle(color: Colors.black45)),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()),
                                  );
                                },
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: lightColorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25.0),
                          // Sign In Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _validateAndSignIn,
                              child: const Text('Sign In'),
                            ),
                          ),
                          const SizedBox(height: 25.0),
                          // Divider
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: Divider(thickness: 0.7, color: Colors.grey.withOpacity(0.5))),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text('Sign up with', style: TextStyle(color: Colors.black45)),
                              ),
                              Expanded(child: Divider(thickness: 0.7, color: Colors.grey.withOpacity(0.5))),
                            ],
                          ),
                          const SizedBox(height: 25.0),
                          // Google Button
                          IconButton(
                            icon: Icon(Bootstrap.google),
                            onPressed: _handleGoogleSignIn,
                          ),
                          const SizedBox(height: 25.0),
                          // Bottom Sign Up link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? ", style: TextStyle(color: Colors.black45)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SignUpScreen()),
                                  );
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: lightColorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
