// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'home_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isLoading = false;

//   void _login() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);
//       try {
        
//         await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text.trim(),
//         );
        
//         if (mounted) {
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (_) => const HomeScreen()),
//           );
//         }
//       } on FirebaseAuthException catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.message ?? "Erreur d'authentification")),
//         );
//       } finally {
//         if (mounted) setState(() => _isLoading = false);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Bienvenue", 
//                 style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 40),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
//                 validator: (value) {
//                   if (value == null || value.isEmpty || !value.contains('@')) {
//                     return 'Veuillez entrer un email valide'; 
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: const InputDecoration(labelText: 'Mot de passe', border: OutlineInputBorder()),
//                 validator: (value) {
//                   if (value == null || value.isEmpty || value.length < 6) {
//                     return 'Mot de passe requis (6 caractères min)';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 24),
//               _isLoading
//                   ? const CircularProgressIndicator()
//                   : ElevatedButton(
//                       onPressed: _login,
//                       style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
//                       child: const Text('Se connecter'),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }