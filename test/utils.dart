import 'package:flutter_test/flutter_test.dart';
import 'package:twitchirc/twitchirc.dart';

class TestUtils {
  static T parseAndCast<T>(String string) {
    final messages = IncomingMessage.parseIRC(string);
    expect(messages.length, 1);

    final first = messages.first.item1;
    expect(first, isNotNull);

    final castedMessage = first?.message as T;
    expect(castedMessage, isNotNull);

    return castedMessage;
  }
}