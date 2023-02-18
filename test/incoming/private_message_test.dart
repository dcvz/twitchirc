import 'package:flutter_test/flutter_test.dart';

import 'package:twitchirc/twitchirc.dart';
import '../utils.dart';

void main() {  
  test('parse message', () {
    const output = "@badge-info=;badges=global_mod/1,turbo/1;color=#0D4200;display-name=dcvz;emotes=25:0-4,12-16/1902:6-10;id=b34ccfc7-4977-403a-8a94-33c6bac34fb8;mod=0;room-id=1337;subscriber=0;tmi-sent-ts=1507246572675;turbo=1;user-id=1337;user-type=global_mod :dcvz!dcvz@dcvz.tmi.twitch.tv PRIVMSG #dcvz :Hey Hi Ho";
    final message = TestUtils.parseAndCast<PrivateMessage>(output);

    expect(message.channel, "dcvz");
    expect(message.message, "Hey Hi Ho");
    expect(message.badgeInfo, []);
    expect(message.badges, ["global_mod/1", "turbo/1"]);
    expect(message.bits, "");
    expect(message.displayName, "dcvz");
    expect(message.userLogin, "dcvz");
    expect(message.flags, []);
    expect(message.firstMessage, false);
    expect(message.returningChatter, false);
    expect(message.messageId, "");
    expect(message.customRewardId, "");
    expect(message.roomId, "1337");
    expect(message.tmiSentTs, 1507246572675);
    expect(message.userId, "1337");
  });

  test('parse message with bits', () {
    const output = "@badge-info=;badges=staff/1,bits/1000;bits=100;color=;display-name=dcvz;emotes=;id=b34ccfc7-4977-403a-8a94-33c6bac34fb8;mod=0;room-id=1337;subscriber=0;tmi-sent-ts=1507246572675;turbo=1;user-id=1337;user-type=staff :dcvz!dcvz@dcvz.tmi.twitch.tv PRIVMSG #dcvz :cheer100";
    final message = TestUtils.parseAndCast<PrivateMessage>(output);

    expect(message.channel, "dcvz");
    expect(message.message, "cheer100");
    expect(message.badgeInfo, []);
    expect(message.badges, ["staff/1", "bits/1000"]);
    expect(message.bits, "100");
    expect(message.displayName, "dcvz");
    expect(message.userLogin, "dcvz");
    expect(message.flags, []);
    expect(message.firstMessage, false);
    expect(message.returningChatter, false);
    expect(message.messageId, "");
    expect(message.customRewardId, "");
    expect(message.roomId, "1337");
    expect(message.tmiSentTs, 1507246572675);
    expect(message.userId, "1337");
  });
}
