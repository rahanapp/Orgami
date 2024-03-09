import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:orgami/viewmodel/firebase_auths.dart';
import 'package:orgami/viewmodel/firestore.dart';

FirestoreDb firestoreDb = FirestoreDb();
final currentUid = FirebaseAuth.instance.currentUser!.uid;
FirebaseAuths auth = FirebaseAuths();
String time = DateFormat('h:mm a').format(DateTime.now());
// String day = DateFormat('EEEE').format(DateTime.now());
String date = DateFormat("dd-m-yyyy").format(DateTime.now());
