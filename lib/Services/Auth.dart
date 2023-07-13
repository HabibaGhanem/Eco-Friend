import 'package:firebase_auth/firebase_auth.dart';
import '../CurrentUserData.dart';

class Auth{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  Future SignIn(String email,String password)async{
    try{
      UserCredential res= await _auth.signInWithEmailAndPassword(email: email, password: password);
      UserData.userID=res.user!.uid;
      UserData.email=res.user!.email;
      print("current email:");
      print(UserData.email);
      print("current uid:");
      print(UserData.userID);
    //UserData.username=email;
    return true;
    }on FirebaseAuthException catch(e)
    {
    print(e.code);
    return false;
    }
  }
  Future SignUp(String email,String password)async{
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserData.userID=res.user!.uid;
      UserData.email=res.user!.email;
      return res.user!.uid;
    }
    catch(e)
    {
      print(e.toString());
      return Null;
    }
  }
}