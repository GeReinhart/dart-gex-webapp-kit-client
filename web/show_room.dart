// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_clients.show_room;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';

import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/elements/application.dart';

import 'pages/home.dart';
import 'pages/bus.dart';
import 'pages/login.dart';
import 'pages/view_port.dart';
import 'pages/buttons.dart';

void main() {
  initPolymer().run(() {
    Polymer.onReady.then((_) {
      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((LogRecord rec) {
        print('${rec.level.name}: ${rec.time}: ${rec.message}');
      });

      ShowRoomApplication application = querySelector("#application") as ShowRoomApplication;

      ApplicationEventBus applicationEventBus = new ApplicationEventBus();
      PageKeyUrlConverter pageKeyUrlConverter = new PageKeyUrlConverter();
      Router router = new Router(pageKeyUrlConverter);
      ApplicationEventLogger applicationEventLogger = new ApplicationEventLogger();

      Authenticator authenticator = new GoogleAuthenticator(clientId());
      LoginFlow loginFlow = new LoginFlow(authenticator, new UserChecker());

      loginFlow.setApplicationEventBus(applicationEventBus);
      authenticator.setApplicationEventBus(applicationEventBus);
      router.setApplicationEventBus(applicationEventBus);
      application.setApplicationEventBus(applicationEventBus);
      applicationEventLogger.setApplicationEventBus(applicationEventBus);

      router.init();
      application.init();
    });
  });
}

String clientId() {
  if (window.location.hostname == "localhost") {
    return "765376678220-21161f3h7quqp1l57mh96sopdjndhntl.apps.googleusercontent.com";
  }
  if (window.location.hostname == "gex-webapp-kit.herokuapp.com") {
    return "765376678220-i7rcrl0nsqgafsh9fcjhc8kr4q6gefk7.apps.googleusercontent.com";
  }

  return "";
}

@CustomTag('show-room-app')
class ShowRoomApplication extends Application {
  final Logger log = new Logger('ShowRoomApplication');

  Color mainColor = Color.GREEN_07CC00;

  ShowRoomApplication.created() : super.created() {}

  @override
  void ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    addPage(new Element.tag('page-home'));
    addPage(new Element.tag('page-login'));
    addPage(new Element.tag('page-buttons'));
    addPage(new Element.tag('page-bus'));
    addPage(new Element.tag('page-view-port'));

    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add(new ButtonModel(
        label: "Home",
        image: new Image(mainImageUrl: "images/button/back57.png"),
        type: ButtonType.PAGE_LAUNCHER,
        targetPageKey: new PageKey(name: PageHome.NAME)));
    buttonModels.add(new ButtonModel(
        label: "Buttons",
        image: new Image(mainImageUrl: "images/button/click5.png"),
        type: ButtonType.PAGE_LAUNCHER,
        targetPageKey: new PageKey(name: PageButtons.NAME)));
    ToolbarModel toolbarModel =
        new ToolbarModel(buttons: buttonModels, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT);
    addToolbar(toolbarModel);

    List<ButtonModel> bottomToolbar = new List<ButtonModel>();
    bottomToolbar.add(new ButtonModel(
        label: "Login",
        image: new Image(mainImageUrl: "images/button/login.png"),
        type: ButtonType.PAGE_LAUNCHER,
        targetPageKey: new PageKey(name: PageLogin.NAME)));
    bottomToolbar.add(new ButtonModel(
        label: "Events",
        image: new Image(mainImageUrl: "images/button/vehicle12.png"),
        type: ButtonType.PAGE_LAUNCHER,
        targetPageKey: new PageKey(name: PageBus.NAME)));
    bottomToolbar.add(new ButtonModel(
        label: "ViewPort",
        image: new Image(mainImageUrl: "images/button/tv21.png"),
        type: ButtonType.PAGE_LAUNCHER,
        targetPageKey: new PageKey(name: PageViewPort.NAME)));
    ToolbarModel bottomToolbarModel =
        new ToolbarModel(buttons: bottomToolbar, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT);
    addToolbar(bottomToolbarModel);
  }
}
