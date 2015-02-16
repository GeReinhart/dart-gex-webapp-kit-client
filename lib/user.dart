// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_client;

class User {
  String _openId;
  String _email;
  String _displayName;
  String _familyName;
  String _givenName;
  String _avatarUrl;

  User({String openId, String email, String displayName, String givenName, String familyName, String avatarUrl}) {
    assert(openId != null);
    _openId = openId;
    _email = email;
    _displayName = displayName;
    _familyName = familyName;
    _givenName = givenName;
    _avatarUrl = avatarUrl;
  }

  String get openId => _openId;
  String get email => _email;
  String get displayName => _displayName != null ? _displayName : "${_givenName} ${_familyName}";
  String get familyName => _familyName;
  String get givenName => _givenName;
  String get avatarUrl => _avatarUrl;

  @override
  String toString() =>
      "User: openId:${_openId}, email:${_email}, displayName:${_displayName}, givenName:${_givenName}, familyName:${_familyName}, imageUrl:${_avatarUrl}";

  User clone() {
    return new User(
        openId: _openId,
        email: _email,
        displayName: _displayName,
        familyName: _familyName,
        givenName: _givenName,
        avatarUrl: _avatarUrl);
  }
}

class CallUserAuthEvent extends ApplicationEvent {
  CallUserAuthEvent(Object sender) : super(sender) {
    _type = "CallUserAuthEvent";
  }

  CallUserAuthEvent clone() {
    return new CallUserAuthEvent(this.sender);
  }

  @override
  String toString() {
    return "CallUserAuthEvent";
  }
}

class UserAuthEvent extends ApplicationEvent {
  User _user;

  UserAuthEvent(Object sender, User user) : super(sender) {
    _user = user;
    _type = "UserAuthEvent";
  }

  User get user => _user.clone();

  UserAuthEvent clone() {
    return new UserAuthEvent(this.sender, this.user);
  }

  @override
  String toString() {
    return "UserAuthEvent: ${_user}";
  }
}

class UserAuthFailEvent extends ApplicationEvent {
  String _errorMessage;
  UserAuthFailEvent(Object sender, String errorMessage) : super(sender) {
    _errorMessage = errorMessage;
    _type = "UserAuthFailEvent";
  }

  UserAuthFailEvent clone() {
    return new UserAuthFailEvent(this.sender, _errorMessage);
  }

  @override
  String toString() {
    return "UserAuthFailEvent error: ${_errorMessage}";
  }
}

class LoginUserEvent extends ApplicationEvent {
  User _user;

  LoginUserEvent(Object sender, User user) : super(sender) {
    _user = user;
    _type = "LoginUserEvent";
  }

  User get user => _user.clone();

  LoginUserEvent clone() {
    return new LoginUserEvent(this.sender, this.user);
  }

  @override
  String toString() {
    return "LoginUserEvent: ${_user}";
  }
}

class LogoutUserEvent extends ApplicationEvent {
  User _user;

  LogoutUserEvent(Object sender, User user) : super(sender) {
    _user = user;
    _type = "LogoutUserEvent";
  }

  User get user => _user.clone();

  LogoutUserEvent clone() {
    return new LogoutUserEvent(this.sender, this.user);
  }

  @override
  String toString() {
    return "LogoutUserEvent: ${_user}";
  }
}

class CallRegisterUserEvent extends ApplicationEvent {
  User _user;

  CallRegisterUserEvent(Object sender, User user) : super(sender) {
    _user = user;
    _type = "CallRegisterUserEvent";
  }

  User get user => _user.clone();

  CallRegisterUserEvent clone() {
    return new CallRegisterUserEvent(this.sender, this.user);
  }

  @override
  String toString() {
    return "LoginUserEvent: ${_user}";
  }
}

/**
 * From a CallUserAuthEvent the flow ends either with UserAuthFailEvent or LoginUserEvent or CallRegisterUserEvent.
 */
class LoginFlow extends Object with ApplicationEventPassenger {
  Authenticator _authenticator;
  UserChecker _userChecker;

  LoginFlow(this._authenticator, this._userChecker);

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    if (event is CallUserAuthEvent) {
      _authenticator.login();
      return;
    }
    if (event is UserAuthEvent) {
      if (_userChecker.knownUser(event.user)) {
        fireApplicationEvent(new LoginUserEvent(this, _userChecker.decorateUser(event.user)));
      } else {
        fireApplicationEvent(new CallRegisterUserEvent(this, event.user));
      }
    }
  }
}

class UserChecker {

  /**
   * Check if an authenticated user an actual user of the application
   */
  bool knownUser(User user) {
    return true;
  }

  /**
   * Get more information on the connected user than just authentication information
   */
  User decorateUser(User user) {
    return user;
  }
}

/**
 * Authenticate an anonymous user and send either UserAuthEvent or UserAuthFailEvent event.
 */
abstract class Authenticator extends Object with ApplicationEventPassenger {
  void login();
}

class GoogleAuthenticator extends Authenticator {
  final Logger log = new Logger('GoogleAuthenticator');

  String _clientId;
  GoogleOAuth2 _auth;

  GoogleAuthenticator() {
    var request = HttpRequest.getString("/oauth/google/clientid").then((clientid) {
      _clientId = clientid;
      _auth = new GoogleOAuth2(_clientId, ["openid", "email"]);
    });
  }

  @override
  void login() {
    if (_auth == null) {
      fireApplicationEvent(new UserAuthFailEvent(this, "GoogleOAuth2 object not initialized"));
      return;
    }
    _auth.login(immediate: true, onlyLoadToken: true).then(_oauthReady).catchError((e) {
      log.warning("login failed with immediate: true,onlyLoadToken: true");
      _auth.login(immediate: true, onlyLoadToken: false).then(_oauthReady).catchError((e) {
        log.warning("login failed with immediate: true, onlyLoadToken: false");
        _auth.login(immediate: false, onlyLoadToken: true).then(_oauthReady).catchError((e) {
          log.warning("login failed with immediate: false, onlyLoadToken: true");
          _auth.login(immediate: false, onlyLoadToken: false).then(_oauthReady).catchError((e) {
            log.warning("login failed with immediate: false, onlyLoadToken: false");
            if (e.toString().contains("User closed the window")) {
              log.warning("User closed the window... wait and retry");
              new Timer(new Duration(milliseconds: 2000), () {
                _auth.login(immediate: true).then(_oauthReady).catchError((e) {
                  fireApplicationEvent(new UserAuthFailEvent(this, e.toString()));
                });
              });
            } else {
              fireApplicationEvent(new UserAuthFailEvent(this, e.toString()));
            }
          });
        });
      });
    });
  }

  Future _oauthReady(Token token) {
    final url = "https://www.googleapis.com/plus/v1/people/${token.userId}";

    var headers = getAuthorizationHeaders(token.type, token.data);

    return HttpRequest.request(url, requestHeaders: headers).then((HttpRequest request) {
      if (request.status == 200) {
        var data = JSON.decode(request.responseText);

        String displayName = data["displayName"];
        String familyName = data["name"] == null ? null : data["name"]["familyName"];
        String givenName = data["name"] == null ? null : data["name"]["givenName"];
        String imageUrl = data["image"] == null ? null : data["image"]["url"].toString().replaceAll("sz=50", "sz=150");

        User user = new User(
            openId: token.userId,
            email: token.email,
            displayName: displayName,
            givenName: givenName,
            familyName: familyName,
            avatarUrl: imageUrl);

        fireApplicationEvent(new UserAuthEvent(this, user));
      } else {
        fireApplicationEvent(new UserAuthFailEvent(this, request.toString()));
      }
    });
  }

  @override
  String toString() {
    return "GoogleAuthenticator: clientId:${_clientId}";
  }
}
