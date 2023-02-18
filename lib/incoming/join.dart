import 'message.dart';

import 'package:twitchirc/extensions/string.dart';

class Join implements Message {
  /// Channel's name with no uppercased/Han characters.
  late String channel;

  /// User's name with no uppercased/Han characters.
  late String userLogin;

  Join(String contentLhs, String contentRhs) {
    if (!contentRhs.startsWith("#")) {
      throw Exception("contentRhs has wrong format");
    }
    channel = contentRhs.dropFirst();

    if (!contentLhs.startsWith(":") || !contentLhs.endsWith(".")) {
      throw Exception("contentLhs has wrong format");
    }

    // this will be in form `<user>!<user>@<user>`
    final nameContainer = contentLhs.dropFirst().dropLast();

    final nameSplit = nameContainer.splitOne("!");
    if (nameSplit == null) {
      throw Exception("nameContainer has wrong format");
    }

    final nameSplit2 = nameSplit.item2.splitOne("@");
    if (nameSplit2 == null) {
      throw Exception("error parsing on '@'");
    }

    if (nameSplit.item1 != nameSplit2.item1 ||
        nameSplit2.item1 != nameSplit2.item2) {
      throw Exception("error parsing");
    }

    userLogin = nameSplit.item1;
  }
}
