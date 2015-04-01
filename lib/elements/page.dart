// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.page;

import 'package:logging/logging.dart';
import 'dart:async';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/application.dart';
import 'package:paper_elements/paper_toast.dart';

abstract class Page extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('Page');

  Application _application;
  Layout _layout;
  PageModel _model;

  Page.created() : super.created();

  @override
  void ready() {
    super.ready();
    _setAttributes();
  }
  
  void showPage({Parameters resources, Parameters params}){
    show();
  }

  PageModel get model => _model.clone();
  String get name => _model.name;

  set application(Application value) {
    _application = value;
  }
  get application => _application;

  void _setAttributes() {
    _layout = $["layout"] as Layout;
  }

  void init(PageModel model) {
    _model = model;
    _layout.init(model.layoutModel);
  }

  Margin get margin => _model.margin;

  set margin(Margin margin) {
    _model.margin = margin;
    _layout.margin = margin;
  }

  void toastMessage(String message, {Color color, num zIndex} ) {
    PaperToast toast = new PaperToast();
    if (color != null) {
      toast.style.backgroundColor = color.veryStrongColor;
    }
    if (zIndex == null){
      zIndex = 10000;
    }
    toast.style.zIndex = "${zIndex}";
    toast.text = message;
    _layout.append(toast);
    toast.show();
    new Timer(new Duration(seconds: 10), () => toast.remove());
  }

  @override
  void setApplicationEventBus(ApplicationEventBus value) {
    super.setApplicationEventBus(value);
    _layout.setApplicationEventBus(value);
  }

  @override
  void moveTo(Position position) {
    super.moveTo(position);
    _layout.moveTo(position);
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    _model.recieveApplicationEvent(event);
  }
}
