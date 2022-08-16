import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

class TelegramMixin {
  TeleDart? teledartFE;

  void initTeleBot() async {
    const BOT_TOKEN = '5491562606:AAFwuDG2eH1-143x4SZqOoL2_k3k2RY_SvA';
    final username = (await Telegram(BOT_TOKEN).getMe()).username;
    teledartFE = TeleDart(BOT_TOKEN, Event(username!));
    teledartFE!.start();
  }

  void sendMessage({required String message}) {
    teledartFE?.sendMessage(
      '-712888617',
      message,
    );
  }
}
