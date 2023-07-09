import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentuser = auth.currentUser;

//collections
const vendorsCollection = "vendors";
const productsCollection = "products";
const chatscollection = "Chats";
const messagescollection = "Messages";
const orderscollection = "Orders";
