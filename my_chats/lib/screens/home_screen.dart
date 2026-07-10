// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'login_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final _messageController = TextEditingController();
//   final _searchController = TextEditingController(); // Pour la recherche
//   final _firestore = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//   String _searchQuery = "";

//   void _sendMessage() async {
//     if (_messageController.text.trim().isNotEmpty) {
//       final msgText = _messageController.text.trim();
//       _messageController.clear();

//       await _firestore.collection('messages').add({
//         'text': msgText,
//         'sender': _auth.currentUser?.email ?? 'Anonyme',
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//     }
//   }

//   void _logout() async {
//     await _auth.signOut();
//     if (mounted) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => const LoginScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mon Chat Réel', style: TextStyle(fontWeight: FontWeight.bold)),
//         elevation: 1,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout, color: Colors.redAccent),
//             onPressed: _logout,
//           )
//         ],
//       ),
//       body: Column(
//         children: [
          
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: TextField(
//               controller: _searchController,
//               onChanged: (value) {
//                 setState(() {
//                   _searchQuery = value.trim().toLowerCase();
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: 'Rechercher un message...',
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),

         
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _firestore
//                   .collection('messages')
//                   .orderBy('createdAt', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(child: Text('Aucun message. Lancez la discussion !'));
//                 }

                
//                 final docs = snapshot.data!.docs.where((doc) {
//                   final data = doc.data() as Map<String, dynamic>;
//                   final text = (data['text'] ?? '').toString().toLowerCase();
//                   return text.contains(_searchQuery);
//                 }).toList();

//                 return ListView.builder(
//                   reverse: true,
//                   itemCount: docs.length,
//                   itemBuilder: (context, index) {
//                     final data = docs[index].data() as Map<String, dynamic>;
//                     final isMe = data['sender'] == _auth.currentUser?.email;

                    
//                     return Align(
//                       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Row(
//                         mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           if (!isMe) ...[
//                             const SizedBox(width: 8),
//                             CircleAvatar(
//                               radius: 16,
//                               backgroundColor: Colors.blueAccent,
//                               child: Text(
//                                 (data['sender'] ?? 'A').toString().substring(0, 1).toUpperCase(),
//                                 style: const TextStyle(color: Colors.white, fontSize: 12),
//                               ),
//                             ),
//                           ],
//                           Flexible(
//                             child: Container(
//                               margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
//                               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                               decoration: BoxDecoration(
//                                 color: isMe ? const Color(0xFF2196F3) : Colors.white,
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: const Radius.circular(16),
//                                   topRight: const Radius.circular(16),
//                                   bottomLeft: Radius.circular(isMe ? 16 : 0),
//                                   bottomRight: Radius.circular(isMe ? 0 : 16),
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.05),
//                                     blurRadius: 4,
//                                     offset: const Offset(0, 2),
//                                   )
//                                 ],
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   if (!isMe)
//                                     Text(
//                                       data['sender'] ?? '',
//                                       style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54),
//                                     ),
//                                   if (!isMe) const SizedBox(height: 2),
//                                   Text(
//                                     data['text'] ?? '',
//                                     style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 15),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           if (isMe) const SizedBox(width: 8),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),

          
//           Container(
//             padding: const EdgeInsets.all(8.0),
//             color: Colors.white,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Écrire un message...',
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(24),
//                         borderSide: BorderSide(color: Colors.grey.shade300),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 IconButton(
//                   icon: const Icon(Icons.send, color: Color(0xFF2196F3)),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }