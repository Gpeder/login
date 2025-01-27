import 'package:firebase_auth/firebase_auth.dart';


class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future <String?> entraUsuario({required String email, required String senha}) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
    }on FirebaseAuthException catch(e){
      switch(e.code){
        case 'user-not-found':
          return 'Usuário não encontrado';
        case 'wrong-password':
          return 'Senha incorreta';
      }
      return e.code;
    }
    return null;
  }

  Future <String?> cadastrarUsuario({required String email, required String senha, required String nome}) async {
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: senha);
    await userCredential.user!.updateDisplayName(nome);
    }on FirebaseAuthException catch(e){
      switch(e.code){
        case 'email-already-in-use':
          return 'Usuário já cadastrado';
      }
      return e.code;
    }
    return null;
  }

  Future <String?> redefinicaoSenha({required String email}) async {
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch(e){
      switch (e.code){
        case 'user-not-found':
          return 'Usuário não encontrado';
      }
    }
    return null;
  }

  Future <String?> deslogarUsuario() async {
    try{
      await _firebaseAuth.signOut();
    }on FirebaseAuthException catch(e){
      return e.code;
    }
    return null;
  }

  Future <String?> excluirConta({required String senha}) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: _firebaseAuth.currentUser!.email!, password: senha);
      await _firebaseAuth.currentUser!.delete();
    }on FirebaseAuthException catch(e){
      return e.code;
    }
    return null;
  }
}