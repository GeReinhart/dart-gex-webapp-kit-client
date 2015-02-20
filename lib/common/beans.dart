// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_common;

abstract class Bean {
  Map toJSON();

  void fromJSON(Map json);
}

class User implements Bean {
  String _openId;
  String _email;
  String _displayName;
  String _familyName;
  String _givenName;
  String _avatarUrl;
  String _bio;

  User({String openId, String email, String displayName, String givenName, String familyName, String avatarUrl,
      String bio}) {
    _openId = openId;
    _email = email;
    _displayName = displayName;
    _familyName = familyName;
    _givenName = givenName;
    _avatarUrl = avatarUrl;
    _bio = bio;
  }

  User.loadJSON(Map json) {
    fromJSON(json);
  }

  String get openId => _openId;
  String get email => _email;
  String get displayName => _displayName != null ? _displayName : "${_givenName} ${_familyName}";
  String get familyName => _familyName;
  String get givenName => _givenName;
  String get avatarUrl => _avatarUrl;
  String get bio => _bio;

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
        avatarUrl: _avatarUrl,
        bio: _bio);
  }

  @override
  Map toJSON() {
    return {
      "openId": _openId,
      "email": _email,
      "displayName": _displayName,
      "givenName": _givenName,
      "familyName": _familyName,
      "avatarUrl": _avatarUrl,
      "bio": _bio
    };
  }

  @override
  void fromJSON(Map json) {
    _openId = json["openId"];
    _email = json["email"];
    _displayName = json["displayName"];
    _givenName = json["givenName"];
    _familyName = json["familyName"];
    _avatarUrl = json["avatarUrl"];
    _bio = json["bio"];
  }
}
