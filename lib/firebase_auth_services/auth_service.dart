// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Rejestracja z adresem e-mail i hasłem
//   Future<User?> registerWithEmailPassword(String email, String password) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return result.user;
//     } on FirebaseAuthException catch (e) {
//       print(e.message);
//       return null;
//     }
//   }

//   // Logowanie z adresem e-mail i hasłem
//   Future<User?> signInWithEmailPassword(String email, String password) async {
//     try {
//       UserCredential result = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return result.user;
//     } on FirebaseAuthException catch (e) {
//       // Obsługa błędów
//       print(e.message);
//       return null;
//     }
//   }

//   // Wylogowanie
//   Future signOut() async {
//     await _auth.signOut();
//   }
// }
