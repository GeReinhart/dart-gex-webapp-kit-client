// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_client;

typedef User BuildUser(Map json);

/**
 * From a CallUserAuthEvent the flow ends either with UserAuthFailEvent or LoginSuccessEvent or CallRegisterPageEvent.
 * From a CallRegisterEvent the flow ends either with RegisterFailEvent or RegisterSuccessEvent.
 */
class GoogleLoginFlow extends Object with ApplicationEventPassenger {
  GoogleAuthenticator _authenticator;

  String _userDetailsService;
  BuildUser _buildUser;

  GoogleLoginFlow(this._authenticator, {String userDetailsService, BuildUser buildUser}) {
    _userDetailsService = userDetailsService;
    _buildUser = buildUser;
    if (_userDetailsService != null) {
      assert(_buildUser != null);
    }
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    if (event.isCallUserAuth) {
      _authenticator.login();
      return;
    }
    if (event.isUserAuthSuccess) {
      PostJsonRequest request = new PostJsonRequest("/services/login/${event.user.openId}",
          (Map output) => callLoginSuccess(event.user, output, 200), (status) {
        if (status == 404) {
          callLoginSuccess(event.user, null, status);
        } else {
          loginFailure(status);
        }
      });
      request.send(event.user);
    }
    if (event.isCallRegister) {
      PostJsonRequest request = new PostJsonRequest("/services/register/${event.user.openId}",
          (Map output) => registerSuccess(new User.loadJSON(output)), (status) => registerFailure(status));
      request.send(event.user);
    }
    if (event.isLoginSuccess && _userDetailsService != null) {
      GetJsonRequest request = new GetJsonRequest("${_userDetailsService}/${event.user.openId}",
          (Map output) => callUserDetailsSuccess(event.user, output), (status) => callUserDetailsFailure(status));
      request.send();
    }
    if (event.isCallSaveUser) {
      PostJsonRequest request = new PostJsonRequest("/services/user/${event.user.openId}",
          (Map output) => saveUserSuccess(new User.loadJSON(output)), (status) => saveUserFailure(status));
      request.send(event.user);
    }
  }

  void callLoginSuccess(User user, Map output, num status) {
    if (status == 404) {
      fireApplicationEvent(new ApplicationEvent.callRegisterPage(this, user));
    } else {
      fireApplicationEvent(new ApplicationEvent.loginSuccess(this, new User.loadJSON(output)));
    }
  }

  void loginFailure(num status) {
    //TODO Send RegisterFailEvent
  }

  void callUserDetailsSuccess(User user, Map output) {
    fireApplicationEvent(new ApplicationEvent.userDetailsSuccess(this, _buildUser(output)));
  }

  void callUserDetailsFailure(num status) {
    //TODO Send RegisterFailEvent
  }

  void registerSuccess(User user) {
    fireApplicationEvent(new ApplicationEvent.registerSuccess(this, user));
  }

  void registerFailure(num status) {
    //TODO Send register fail event
  }

  void saveUserSuccess(User user) {
    // TODO Send save user success
  }

  void saveUserFailure(num status) {
    //TODO Send login fail event
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
      fireApplicationEvent(new ApplicationEvent.userAuthFail(this, "GoogleOAuth2 object not initialized"));
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
                  fireApplicationEvent(new ApplicationEvent.userAuthFail(this, e.toString()));
                });
              });
            } else {
              fireApplicationEvent(new ApplicationEvent.userAuthFail(this, e.toString()));
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

        if (displayName == null || displayName.isEmpty) {
          displayName = givenName + " " + familyName;
        }

        User user = new User.fromFields(
            openId: token.userId, email: token.email, displayName: displayName, avatarUrl: imageUrl);

        fireApplicationEvent(new ApplicationEvent.userAuthSuccess(this, user));
      } else {
        fireApplicationEvent(new ApplicationEvent.userAuthFail(this, request.toString()));
      }
    });
  }

  @override
  String toString() {
    return "GoogleAuthenticator: clientId:${_clientId}";
  }
}
