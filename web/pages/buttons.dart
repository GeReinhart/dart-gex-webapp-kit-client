// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.show_room.buttons;

import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/page.dart';
import 'package:gex_webapp_kit_client/elements/button.dart';

import 'bus.dart';

@CustomTag('page-buttons')
class PageButtons extends Page with Showable {
  static final String NAME = "buttons";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.GREY_858585;

  Layout layout;

  Button button1;
  Button button2;
  Button button3;
  Button button4;

  num buttonBasicSize = 300;

  PageButtons.created() : super.created();

  ready() {
    super.ready();
    _setAttributesPage();
    _setAttributesButtons();
    _moveButtons();
  }

  void _setAttributesPage() {
    layout = $["layout"] as Layout;
    LayoutModel layoutModel = new LayoutModel(color: mainColor);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    if (event is ViewPortChangeEvent) {
      buttonBasicSize = event.viewPortModel.windowHeight < event.viewPortModel.windowWidth
          ? event.viewPortModel.windowHeight / 3
          : event.viewPortModel.windowWidth / 3;
      _moveButtons();
    }
  }

  void _setAttributesButtons() {
    button1 = $["button1"] as Button;
    button1.init(new ButtonModel(
        color: Color.GREY_858585,
        image: new Image(mainImageUrl: "images/button/info24.png"),
        label: "Action 1",
        action: action1));

    button2 = $["button2"] as Button;
    button2.init(new ButtonModel(
        color: Color.GREEN_07CC00,
        image: new Image(mainImageUrl: "images/button/list23.png"),
        label: "Action 2",
        action: action2));

    button3 = $["button3"] as Button;
    button3.init(new ButtonModel(
        color: Color.GREEN_07CC00.inverse(),
        image: new Image(mainImageUrl: "images/button/save29.png"),
        label: "Action 3",
        action: action3));

    button4 = $["button4"] as Button;
    button4.init(new ButtonModel(
        color: Color.BLUE_0082C8,
        image: new Image(mainImageUrl: "/images/button/save29.png", mainImageUrl2: "/images/button/vehicle12.png"),
        label: "Call bus page",
        action: action4));
  }

  void _moveButtons() {
    button1.moveTo(new Position(
        buttonBasicSize * 2 / 3, buttonBasicSize * 2 / 3, buttonBasicSize * 2 / 3, buttonBasicSize * 2 / 3, 101));
    button2.moveTo(new Position(
        buttonBasicSize * 2 / 3, buttonBasicSize * 5 / 3, buttonBasicSize * 3 / 3, buttonBasicSize * 3 / 3, 101));
    button3.moveTo(new Position(
        buttonBasicSize * 6 / 3, buttonBasicSize * 2 / 3, buttonBasicSize * 1 / 3, buttonBasicSize * 1 / 3, 101));
    button4.moveTo(new Position(
        buttonBasicSize * 6 / 3, buttonBasicSize * 6 / 3, buttonBasicSize * 4 / 4, buttonBasicSize * 2 / 4, 101));
  }

  action1(Parameters params) {
    layout.color = Color.GREY_858585.lightColorAsColor;
  }
  action2(Parameters params) {
    layout.color = Color.GREEN_07CC00.lightColorAsColor;
  }
  action3(Parameters params) {
    layout.color = Color.GREEN_07CC00.inverse().lightColorAsColor;
  }
  action4(Parameters params) {
    layout.color = Color.BLUE_0082C8.lightColorAsColor;

    fireApplicationEvent(new PageCallEvent.fromPageKey(this, new PageKey(name: PageBus.NAME)));
  }
}
