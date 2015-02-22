// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_common;

abstract class Bean {
  Map toJSON();

  void fromJSON(Map json);
}

class User implements Bean {
  
  @Id() String id;
  @Field() String openId;
  @Field() String email;
  @Field() String displayName;
  @Field() String familyName;
  @Field() String givenName;
  @Field() String avatarUrl;
  @Field() String bio;

  User([String this.id, String this.openId, String this.email, String this.displayName, String this.givenName, String this.familyName, String this.avatarUrl,
      String this.bio]) ;
  
  User.fromFields({String this.id, String this.openId, String this.email, String this.displayName, String this.givenName, String this.familyName, String this.avatarUrl,
      String this.bio}) {
  }

  User.loadJSON(Map json) {
    fromJSON(json);
  }


  @override
  String toString() =>
      "User: openId:${openId}, email:${email}, displayName:${displayName}, givenName:${givenName}, familyName:${familyName}, imageUrl:${avatarUrl}";

  User clone() {
    return new User.fromFields(
        id:id,
        openId: openId,
        email: email,
        displayName: displayName,
        familyName: familyName,
        givenName: givenName,
        avatarUrl: avatarUrl,
        bio: bio);
  }

  @override
  Map toJSON() {
    return {
      "id": id,
      "openId": openId,
      "email": email,
      "displayName": displayName,
      "givenName": givenName,
      "familyName": familyName,
      "avatarUrl": avatarUrl,
      "bio": bio
    };
  }

  @override
  void fromJSON(Map json) {
    id = json["id"];
    openId = json["openId"];
    email = json["email"];
    displayName = json["displayName"];
    givenName = json["givenName"];
    familyName = json["familyName"];
    avatarUrl = json["avatarUrl"];
    bio = json["bio"];
  }
}
