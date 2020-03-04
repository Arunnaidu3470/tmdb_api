import 'package:flutter_test/flutter_test.dart';

import '../../lib/tmdb_api.dart';
import '../../lib/keys.dart';

void main() {
  TMDB tmdb = TMDB(Keys.API);
  group('Authentication', () {
    group('Request token', () {
      test('As String', () async {
        String result = await tmdb.v3.auth.createRequestToken();
        print(result);
        expect(result == null, false);
      });
      test('As Map', () async {
        Map result = await tmdb.v3.auth.createRequestToken(asMap: true);
        expect(result is Map, true);
        print(result);
      });
    });

    group('>createSession', () {
      test('>generating session id with username and password', () async {
        String requestToken = await tmdb.v3.auth.createRequestToken();
        String sessionId = await tmdb.v3.auth.createSession(requestToken);
        print(sessionId);
      });
    });
    group('Create session with login', () {
      test('generate with creditionals', () async {
        String result = await tmdb.v3.auth
            .createSessionWithLogin(User.USERNAME, User.PASSWORD);
        print(result);
        expect(result == null, false);
      });
      test('>with wrong creditionals', () async {
        String result = await tmdb.v3.auth
            .createSessionWithLogin('foobartest', 'foobarpass');
        print(result);
        expect(result == null, true);
      });
      test('>with wrong creditionals as Map', () async {
        Map result = await tmdb.v3.auth
            .createSessionWithLogin('foobartest', 'foobarpass', asMap: true);
        print(result);
        expect(result is Map, true);
      });
    });

    // group('>delete session', () {
    //   test('>with session id', () async {
    //     Map result = await tmdb.v3.auth
    //         .deleteSession('af4e90867015c77515901e5f8f09e933fc64817a');
    //     print(result);
    //   });
    // });

    group('>guest session', () {
      test('>getting session as String', () async {
        String guestSessionId = await tmdb.v3.auth.createGuestSession();
        print(guestSessionId);
      });

      test('>getting session as Map', () async {
        Map result = await tmdb.v3.auth.createGuestSession(asMap: true);
        print(result);
      });
    });
  });
}
