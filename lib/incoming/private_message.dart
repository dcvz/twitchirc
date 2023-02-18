import 'message.dart';
import '../extensions/string.dart';
import 'parameters_parser.dart';

class PrivateMessage implements Message {
  /// Channel's name with no uppercased/Han characters.
  late String channel;

  /// The message sent.
  late String message = '';

  /// Badge info.
  late List<String> badgeInfo = [];

  /// User's badges.
  late List<String> badges = [];

  /// The bits that were donated, if any.
  late String bits = '';

  /// User's display name with uppercased/Han characters.
  late String displayName = '';

  /// User's name with no uppercased/Han characters.
  late String userLogin = '';

  /// Flags of this message.
  late List<String> flags = [];

  /// Whether it's the first time the user is sending a message.
  late bool firstMessage = false;

  /// Flag for new viewers who have chatted at least twice in the last 30 days.
  late bool returningChatter = false;

  /// Not sure exactly what is this? usually empty.
  late String messageId = '';

  /// The id of the custom reward, if any.
  late String customRewardId = '';

  /// Broadcaster's Twitch identifier.
  late String roomId = '';

  /// The timestamp of the message.
  late int tmiSentTs = 0;

  /// User's Twitch identifier.
  late String userId = '';

  PrivateMessage(String contentLhs, String contentRhs) {
    if (contentRhs.length <= 3 || contentRhs[0] != "#") {
      throw Exception("contentRhs has wrong format");
    }

    final channelAndMessage = contentRhs.dropFirst().splitOne(" ");
    if (channelAndMessage == null) {
      throw Exception("contentRhs has wrong format");
    }

    channel = channelAndMessage.item1;
    message = channelAndMessage.item2.dropFirst();

    // separates "senderName!senderName@senderName." from what is behind it.
    final infoPartAndUserLoginPart = contentLhs.splitOne(" :");
    if (infoPartAndUserLoginPart == null) {
      throw Exception("contentLhs has wrong format");
    }

    final userLogin1AndTheRest =
        infoPartAndUserLoginPart.item2.dropLast().splitOne("!");
    if (userLogin1AndTheRest == null) {
      throw Exception("error parsing on '!'");
    }

    final userLogin2AndUserLogin3 = userLogin1AndTheRest.item2.splitOne("@");
    if (userLogin2AndUserLogin3 == null) {
      throw Exception("error parsing on '@'");
    }

    if (userLogin1AndTheRest.item1 != userLogin2AndUserLogin3.item1 ||
        userLogin2AndUserLogin3.item1 != userLogin2AndUserLogin3.item2) {
      throw Exception("error parsing");
    }

    userLogin = userLogin1AndTheRest.item1;

    final parser = ParametersParser(infoPartAndUserLoginPart.item1.dropFirst());

    badgeInfo = parser.array("badge-info");
    badges = parser.array("badges");
    bits = parser.string("bits");
    displayName = parser.string("display-name");
    flags = parser.array("flags");
    firstMessage = parser.boolean("first-msg");
    returningChatter = parser.boolean("returning-chatter");
    messageId = parser.string("msg-id");
    customRewardId = parser.string("custom-reward-id");
    roomId = parser.string("room-id");
    tmiSentTs = parser.integer("tmi-sent-ts");
    userId = parser.string("user-id");
  }
}
