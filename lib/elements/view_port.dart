// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.virtual_screen;

import "dart:html";
import 'dart:js' as js;
import 'package:logging/logging.dart';
import 'dart:async';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:polymer/polymer.dart';

/**
 * Listen to the screen/window changes and broadcast ViewPort change events.
 */
@CustomTag('gex-view-port')
class ViewPort extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('ViewPort');

  ViewPortModel _model = new ViewPortModel(0, 0);

  ViewPort.created() : super.created() {
    _model = new ViewPortModel.fromWindow(window, hasTouchSupport);
  }

  @override
  void setApplicationEventBus(ApplicationEventBus value) {
    super.setApplicationEventBus(value);
  }

  ViewPortModel get model => _model.clone();

  void init() {
    fireApplicationEvent(new ViewPortChangeEvent(this, _model));
    _updateViewPort();
  }

  void _updateViewPort() {
    ViewPortModel newScreen = new ViewPortModel.fromWindow(window, hasTouchSupport);
    if (newScreen != _model) {
      _model = newScreen;
      log.info("ViewPort ${id} changed to ${_model}");
      fireApplicationEvent(new ViewPortChangeEvent(this, _model));
    }
    var wait = new Duration(milliseconds: 125);
    new Timer(wait, () => _updateViewPort());
  }

  bool _hasTouchSupport;
  bool get hasTouchSupport {
    if (_hasTouchSupport == null) {
      _hasTouchSupport = js.context.callMethod('hasTouchSupport');
    }
    return _hasTouchSupport;
  }
}
