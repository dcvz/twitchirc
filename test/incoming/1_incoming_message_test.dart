import 'package:flutter_test/flutter_test.dart';

import 'package:twitchirc/twitchirc.dart';

void main() {
  const terminator = "\r\n";
  
  test('parses single message', () {
    const output = ":dcvz!dcvz@dcvz.tmi.twitch.tv JOIN #dcvz";
    final message = IncomingMessage.parseIRC(output);

    expect(message.length, 1);

    final first = message.first;
    expect(first.item2, output);

    switch (first.item1?.message.runtimeType) {
      case Join:
        break;
      default:
        fail("Unexpected message type");
    }
  });

  test('parses single message with terminator', () {
    const output = ":dcvz!dcvz@dcvz.tmi.twitch.tv JOIN #dcvz";
    final message = IncomingMessage.parseIRC(output + terminator);

    expect(message.length, 1);

    final first = message.first;
    expect(first.item2, output);

    switch (first.item1?.message.runtimeType) {
      case Join:
        break;
      default:
        fail("Unexpected message type");
    }
  });

  test('parses single message with terminator on both sides', () {
    const output = ":dcvz!dcvz@dcvz.tmi.twitch.tv JOIN #dcvz";
    final message = IncomingMessage.parseIRC(terminator + output + terminator);

    expect(message.length, 1);

    final first = message.first;
    expect(first.item2, output);

    switch (first.item1?.message.runtimeType) {
      case Join:
        break;
      default:
        fail("Unexpected message type");
    }
  });

  // TODO: Test multiple messages
}
