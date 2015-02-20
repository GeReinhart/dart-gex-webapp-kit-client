// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.user.edit;

import "dart:html";
import 'dart:js' as js;
import 'package:logging/logging.dart';
import 'dart:async';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:polymer/polymer.dart';

@CustomTag('gex-user-edit')
class UserEdit extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('UserEdit');

   @observable String openId;
   @observable String email;
   @observable String displayName;
   @observable String familyName;
   @observable String givenName;
   @observable String avatarUrl;
   @observable String bio;

   UserEdit.created() : super.created();

   set user(User user) {
     openId = user.openId;
     email = user.email;
     displayName = user.displayName;
     familyName = user.familyName;
     givenName = user.givenName;
     avatarUrl = user.avatarUrl;
     bio = user.bio;
   }
   User get user => new User(
       openId: openId,
       email: email,
       displayName: displayName,
       familyName: familyName,
       givenName: givenName,
       avatarUrl: avatarUrl,
       bio: bioTextArea.value);

   TextAreaElement get bioTextArea => $["bioTextArea"] as TextAreaElement;  


}
