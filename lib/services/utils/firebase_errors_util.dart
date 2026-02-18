import 'package:firebase_auth/firebase_auth.dart';

String getFirebaseErrorMessage(FirebaseAuthException exception) {
  const errorMessages = <String, String>{
    'weak-password': 'A senha é muito fraca.',
    'email-already-in-use': 'Este email já está cadastrado.',
    'invalid-email': 'Email inválido.',
    'wrong-password': 'Senha incorreta.',
    'invalid-credential': 'Credenciais inválidas.',
    'user-disabled': 'Conta desabilitada.',
    'user-not-found': 'Usuário não encontrado.',
    'operation-not-allowed': 'Operação não permitida.',
    'too-many-requests': 'Muitas tentativas. Tente novamente mais tarde.',
    'network-request-failed': 'Erro de conexão. Verifique sua internet.',
    'requires-recent-login': 'Por segurança, faça login novamente.',
  };

  return errorMessages[exception.code] ??
      'Erro de autenticação: ${exception.message ?? 'Erro desconhecido'}';
}
