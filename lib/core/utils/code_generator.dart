import 'dart:math';

String generateJoinCode() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();

  return List.generate(6, (_) => chars[random.nextInt(chars.length)]).join();
}
