import 'package:tuple/tuple.dart';
import 'package:twitchirc/extensions/string.dart';

import 'message.dart';
import 'private_message.dart';
import 'join.dart';
import 'pingpong.dart';

class IncomingMessage {
  final Message message;

  const IncomingMessage(this.message);

  static IncomingMessage? parseMessage(String message) {
    final contentLhsAndMessageRhs = message.splitOne("tmi.twitch.tv");
    if (contentLhsAndMessageRhs == null) {
      return null;
    }

    String messageIdentifier;
    String contentRhs;
    final rhsWithoutPossibleLeadingSpace =
        contentLhsAndMessageRhs.item2.dropFirst();

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
          final message =
              PrivateMessage(contentLhsAndMessageRhs.item1, contentRhs);
          return IncomingMessage(message);
        } catch (e) {
          return null;
        }
      case "JOIN":
        try {
          final message = Join(contentLhsAndMessageRhs.item1, contentRhs);
          return IncomingMessage(message);
        } catch (e) {
          return null;
        }
      case "":
        if (contentLhsAndMessageRhs.item1 == "PING :") {
          return IncomingMessage(Ping());
        } else if (contentLhsAndMessageRhs.item1 == "PONG :") {
          return IncomingMessage(Pong());
        } else {
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
