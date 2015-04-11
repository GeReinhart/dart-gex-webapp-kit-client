// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.test_app.page_two;

import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:gex_webapp_kit/webapp_kit_common.dart';
import 'package:gex_webapp_kit/client/elements/layout.dart';
import 'package:gex_webapp_kit/client/elements/page.dart';

@CustomTag('gex-page-two')
class PageTwo extends Page with Showable {
  final Logger log = new Logger('PageTwo');

  Color mainColor = Color.BLUE_0082C8.lightColorAsColor;

  Layout layout;

  PageTwo.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;

    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add(new ButtonModel(label: "Action 1", action: action1));
    buttonModels.add(new ButtonModel(label: "Action 2", action: action2));
    buttonModels.add(new ButtonModel(label: "Action 3", action: action3));
    ToolbarModel toolbarModel =
        new ToolbarModel(buttons: buttonModels, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT);

    LayoutModel layoutModel = new LayoutModel(toolbarModel: toolbarModel, color: mainColor);
    PageModel model = new PageModel(name: "PageTwo", layoutModel: layoutModel);
    this.init(model);
  }

  action1(Parameters params) {
    layout.style.backgroundColor = mainColor.strongColor;
  }
  action2(Parameters params) {
    layout.style.backgroundColor = mainColor.mainColor;
  }
  action3(Parameters params) {
    layout.style.backgroundColor = mainColor.lightColor;
  }
}
