import 'dart:ui'; // <-- Important for blur
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signin_screen.dart';
import 'theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool agreePersonalData = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/farmer.jpg', // Replace with your image path
            fit: BoxFit.cover,
          ),

          // Blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.2), // Optional: dark overlay
            ),
          ),

          // Main Content
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'assets/niral_split.png',
                    height: 150,
                  ),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox()),

              Expanded(
                flex: 7,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25, 50, 25, 20),
                  decoration: const BoxDecoration(
                    color: Colors.white54, // semi-transparent white container
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: lightColorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Full Name
                          TextFormField(
                            controller: fullNameController,
                            validator: (value) =>
                                value == null || value.isEmpty ? 'Enter full name' : null,
                            decoration: _inputDecoration('Full Name', 'Enter full name'),
                          ),
                          const SizedBox(height: 20),

                          // Email
                          TextFormField(
                            controller: emailController,
                            validator: (value) =>
                                value == null || value.isEmpty ? 'Enter email' : null,
                            decoration: _inputDecoration('Email', 'Enter email'),
                          ),
                          const SizedBox(height: 20),

                          // Password
                          TextFormField(
                            controller: passwordController,
                            obscureText: _obscureText,
                            validator: (value) =>
                                value == null || value.isEmpty ? 'Enter password' : null,
                            decoration: _inputDecoration('Password', 'Enter password').copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.black45,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Personal Data Agreement
                          Row(
                            children: [
                              Checkbox(
                                value: agreePersonalData,
                                onChanged: (value) {
                                  setState(() {
                                    agreePersonalData = value!;
                                  });
                                },
                                activeColor: lightColorScheme.primary,
                              ),
                              const Expanded(
                                child: Text(
                                  'I agree to the processing of personal data',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Sign Up Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _handleSignup,
                              child: const Text('Sign Up'),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Divider
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text('or'),
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Google Icon
                          IconButton(
                            icon: Icon(Bootstrap.google, size: 30),
                            onPressed: () {
                              // TODO: Implement Google signup
                            },
                          ),
                          const SizedBox(height: 25),

                          // Navigate to Sign In
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account? '),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => const SignInScreen()),
                                  );
                                },
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: lightColorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
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

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      if (!agreePersonalData) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please agree to personal data processing')),
        );
        return;
      }

      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_fullname', fullNameController.text.trim());
        await prefs.setString('user_email', emailController.text.trim());
        await prefs.setString('user_password', passwordController.text.trim());

        print("✅ SIGN UP DATA SAVED");
        print("Full Name: ${fullNameController.text}");
        print("Email: ${emailController.text}");
        print("Password: ${passwordController.text}");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup successful')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SignInScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: $e')),
        );
      }
    }
  }
}
