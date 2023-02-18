import 'package:flutter_test/flutter_test.dart';

import 'package:twitchirc/twitchirc.dart';
import '../utils.dart';

void main() {
  test('parse PING message', () {
    const output = "PING :tmi.twitch.tv";
    final message = TestUtils.parseAndCast<Ping>(output);

    expect(message, isNotNull);
  });

  test('parse PONG message', () {
    const output = "PONG :tmi.twitch.tv";
    final message = TestUtils.parseAndCast<Pong>(output);

    expect(message, isNotNull);
  });
}
