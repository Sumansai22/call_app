import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future sendMessage(String receiverEmail, String message) async {
    final currentUser = _auth.currentUser!.email;
    final time = Timestamp.now();

    await _firestore.collection("messages").add({
      "sender": currentUser,
      "receiver": receiverEmail,
      "message": message,
      "time": time,
    });
  }

  Stream<QuerySnapshot> getMessages(String userEmail) {
    final currentUser = _auth.currentUser!.email;

    return _firestore
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }
}