import 'dart:ui'; // For the blur effect
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:niral_prj/signin_screen.dart'; // Import SignIn screen after successful registration
import 'package:niral_prj/index.dart'; // Import HomePage or main screen
import 'package:niral_prj/theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool agreePersonalData = false;
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Firebase Sign-Up method
  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      if (!agreePersonalData) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please agree to personal data processing')),
        );
        return;
      }

      try {
        // Firebase SignUp using email and password
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Optional: You can save additional data to Firebase Firestore or SharedPreferences
        // Save the user's information to Firestore or SharedPreferences
        print("✅ SIGN UP SUCCESSFUL");
        print("User: ${userCredential.user?.email}");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup successful')),
        );

        // Navigate to sign-in screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SignInScreen()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: ${e.message}')),
        );
      }
    }
  }

  // Google Sign-Up method
  Future<void> _googleSignUp() async {
    try {
      // Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        // Retrieve authentication details
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Use the credentials to sign in with Firebase
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in with Firebase
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        print("✅ Google Sign Up Successful");
        print("User: ${userCredential.user?.email}");

        // Navigate to home page or wherever you need
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In failed: $e')),
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
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/niral_split.png', height: 150),
                          const SizedBox(height: 20.0),
                          Text(
                            'Create your account',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                              color: lightColorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          // Email field
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Email'),
                              hintText: 'Enter your email',
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
                          // Confirm Password field
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: _obscureConfirmText,
                            obscuringCharacter: '*',
                            validator: (value) {
                              if (value != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Confirm Password'),
                              hintText: 'Confirm Password',
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
                                  _obscureConfirmText ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.black26,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmText = !_obscureConfirmText;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 25.0),
                          // Agree to Terms
                          Row(
                            children: [
                              Checkbox(
                                value: agreePersonalData,
                                onChanged: (bool? value) {
                                  setState(() {
                                    agreePersonalData = value!;
                                  });
                                },
                                activeColor: lightColorScheme.primary,
                              ),
                              const Text('I agree to the terms of service'),
                            ],
                          ),
                          const SizedBox(height: 25.0),
                          // Sign Up Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _handleSignup,
                              child: const Text('Sign Up'),
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
                                child: Text('Or'),
                              ),
                              Expanded(child: Divider(thickness: 0.7, color: Colors.grey.withOpacity(0.5))),
                            ],
                          ),
                          const SizedBox(height: 25.0),
                          // Google Sign-Up Button
                          IconButton(
                            icon: Icon(Bootstrap.google, size: 30),
                            onPressed: _googleSignUp,
                          ),
                          const SizedBox(height: 10.0),
                          // Navigate to Sign In
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const SignInScreen()),
                              );
                            },
                            child: const Text("Already have an account? Sign In"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox(height: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
