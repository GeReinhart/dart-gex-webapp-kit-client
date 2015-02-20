// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.show_room.login;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';

import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/page.dart';
import 'package:gex_webapp_kit_client/elements/user_edit.dart';

@CustomTag('page-profile')
class PageProfile extends Page with Showable {
  static final String NAME = "profile";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.WHITE;

  Layout layout;
  UserEdit userEdit ;

  PageProfile.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;
    userEdit = $["userEdit"] as UserEdit;    

    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels
        .add(new ButtonModel(label: "Save", action: save, image: new Image(mainImageUrl: "/images/button/save29.png")));
    buttonModels.add(
        new ButtonModel(label: "Logout", action: logout, image: new Image(mainImageUrl: "/images/button/logout.png")));
    buttonModels.add(
        new ButtonModel(label: "Cancel", action: cancel, image: new Image(mainImageUrl: "/images/button/back57.png")));
    ToolbarModel toolbarModel = new ToolbarModel(
        buttons: buttonModels,
        color: Color.GREY_858585.lightColorAsColor,
        orientation: Orientation.est,
        colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT);

    LayoutModel layoutModel = new LayoutModel(toolbarModel: toolbarModel, color: mainColor);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    super.recieveApplicationEvent(event);
    if (event.isUserAuthSuccess || event.isLoginSuccess || event.isRegisterSuccess) {
      userEdit.user = event.user;
    }
    if (event.isLogoutSuccess) {
      userEdit.user = new User();
    }
  }

  void save(Parameters params) {
    fireApplicationEvent(new ApplicationEvent.callSaveUser(this, userEdit.user));
  }
  void logout(Parameters params) {
    // TODO Should call logout first...
    fireApplicationEvent(new ApplicationEvent.logoutSuccess(this, userEdit.user));
    userEdit.user = new User();
  }
  void cancel(Parameters params) {
    fireApplicationEvent(new ApplicationEvent.callIndexPage(this));
  }
}
