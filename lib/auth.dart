// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_client;

class User {
  String _userId;
  String _email;
  String _displayName;
  String _familyName;
  String _givenName;
  String _imageUrl;

  User({String userId, String email, String displayName, String givenName, String familyName, String imageUrl}) {
    assert(userId != null);
    _userId = userId;
    _email = email;
    _displayName = displayName;
    _familyName = familyName;
    _givenName = givenName;
    _imageUrl = imageUrl;
  }

  String get userId => _userId;
  String get email => _email;
  String get displayName => _displayName;
  String get familyName => _familyName;
  String get givenName => _givenName;
  String get imageUrl => _imageUrl;

  @override
  String toString() =>
      "User: userId:${_userId}, email:${_email}, displayName:${_displayName}, givenName:${_givenName}, familyName:${_familyName}, imageUrl:${_imageUrl}";

  User clone() {
    return new User(
        userId: _userId,
        email: _email,
        displayName: _displayName,
        familyName: _familyName,
        givenName: _givenName,
        imageUrl: _imageUrl);
  }
}

class CallUserAuthEvent extends ApplicationEvent {
  CallUserAuthEvent(Object sender) : super(sender: sender, name: "CallUserAuthEvent") {
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

  UserAuthEvent(Object sender, User user) : super(sender: sender, name: "UserAuthEvent") {
    _user = user;
    List<Parameter> parameters = new List<Parameter>();
    parameters.add(new Parameter("userId", _user.userId));
    _params = new Parameters(parameters);
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
  UserAuthFailEvent(Object sender, String errorMessage) : super(sender: sender, name: "UserAuthFailEvent") {
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

abstract class Authenticator extends Object with ApplicationEventPassenger {
  void login();
}

class GoogleAuthenticator extends Authenticator {
  String _clientId;
  GoogleOAuth2 _auth;

  GoogleAuthenticator(this._clientId) {
    _auth = new GoogleOAuth2(_clientId, ["openid", "email"]);
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    if (event is CallUserAuthEvent) {
      login();
    }
  }

  @override
  void login() {
    _auth.login().then(_oauthReady).catchError((e) {
      fireApplicationEvent(new UserAuthFailEvent(this, e.toString()));
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
        String imageUrl = data["image"] == null ? null : data["image"]["url"];

        User user = new User(
            userId: token.userId,
            email: token.email,
            displayName: displayName,
            givenName: givenName,
            familyName: familyName,
            imageUrl: imageUrl);

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
