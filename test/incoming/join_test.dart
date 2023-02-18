import 'package:flutter_test/flutter_test.dart';

import 'package:twitchirc/twitchirc.dart';
import '../utils.dart';

void main() {  
  test('parse message', () {
    const output = ":dcvz!dcvz@dcvz.tmi.twitch.tv JOIN #bellacica";
    final message = TestUtils.parseAndCast<Join>(output);

    expect(message.channel, "bellacica");
    expect(message.userLogin, "dcvz");
  });
}
