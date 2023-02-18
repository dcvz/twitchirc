
import 'package:tuple/tuple.dart';
import 'package:twitchirc/extensions/string.dart';

import 'message.dart';
import 'private_message.dart';
import 'join.dart';

class IncomingMessage {
  final Message message;

  const IncomingMessage(this.message);

  static IncomingMessage? parseMessage(String message) {
    final messageSplit = message.splitOne("tmi.twitch.tv");
    if (messageSplit == null) {
      return null;
    }

    String messageIdentifier;
    String contentRhs;
    final rhsWithoutPossibleLeadingSpace = messageSplit.item2.substring(1);

    final split = rhsWithoutPossibleLeadingSpace.splitOne(" ");
    if (split == null) {
      messageIdentifier = rhsWithoutPossibleLeadingSpace;
      contentRhs = "";
    } else {
      messageIdentifier = split.item1;
      contentRhs = split.item2;
    }

    switch (messageIdentifier) {
      case "PRIVMSG":
        try {
          final message = PrivateMessage(messageSplit.item1, contentRhs);
          return IncomingMessage(message);
        } catch (e) {
          return null;
        }
      case "JOIN":
        try {
          final message = Join(messageSplit.item1, contentRhs);
          return IncomingMessage(message);
        } catch (e) {
          return null;
        }
        default:
          return null;
    }
  }

  static List<Tuple2<IncomingMessage?, String>> parseIRC(String ircOutput) {
    return ircOutput
      .split('\r\n')
      .where((element) => false == element.isEmpty)
      .map((e) => Tuple2(IncomingMessage.parseMessage(e), e))
      .toList();
  }
}
