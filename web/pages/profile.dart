// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.show_room.login;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';

import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/page.dart';

@CustomTag('page-profile')
class PageProfile extends Page with Showable {
  static final String NAME = "profile";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.BLUE_0082C8;

  Layout layout;

  @observable User user;

  PageProfile.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;

    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add(
        new ButtonModel(label: "Logout", action: logout, image: new Image(mainImageUrl: "/images/button/logout.png")));
    ToolbarModel toolbarModel = new ToolbarModel(
        buttons: buttonModels,
        color: mainColor,
        orientation: Orientation.est,
        colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT);

    LayoutModel layoutModel = new LayoutModel(toolbarModel: toolbarModel, color: mainColor);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  void login(Parameters params) {
    fireApplicationEvent(new CallUserAuthEvent(this));
  }
  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    super.recieveApplicationEvent(event);
    if (event is UserAuthEvent) {
      user = event.user;
    }
  }

  void logout(Parameters params) {
    fireApplicationEvent(new LogoutUserEvent(this, user));
    user = null;
  }
}
