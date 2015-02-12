// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.page;

import 'package:logging/logging.dart';

import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/application.dart';

abstract class Page extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('Page');

  Application _application ; 
  Layout _layout;
  PageModel _model;

  Page.created() : super.created();

  @override
  void ready() {
    super.ready();
    _setAttributes();
  }

  PageModel get model => _model.clone();
  String get name => _model.name;

  set application ( Application value){
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
