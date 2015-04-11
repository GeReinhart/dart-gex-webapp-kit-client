// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.layout;

import "dart:html";
import 'package:polymer/polymer.dart';
import 'package:logging/logging.dart';

import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:gex_webapp_kit/webapp_kit_common.dart';
import 'package:gex_webapp_kit/client/elements/toolbar.dart';

/**
 * Create a workspace inside the available space.
 * Put toolbars at the 4 corners of the space.
 * Put buttons at the bottom of the space.
 * Adapt the workspace and the toolbars according to the viewPort change events. 
 */
@CustomTag('gex-layout')
class Layout extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('Layout');

  DivElement _space;
  DivElement _emptySpaceBottom;
  DivElement _emptySpaceTop;
  Toolbar _toolbar;
  LayoutModel _model;

  Layout.created() : super.created();

  @override
  void ready() {
    super.ready();
    _setAttributes();
  }

  void init(LayoutModel model) {
    _model = model;
    this.style.backgroundColor = model.color.veryLightColor;
    model.toolbarModel.orientation = Orientation.est;
    _toolbar.init(model.toolbarModel);
  }

  void _setAttributes() {
    _space = $["space"] as DivElement;
    _toolbar = $["toolbar"] as Toolbar;
    _emptySpaceBottom = $["emptySpaceBottom"] as DivElement;
    _emptySpaceTop = $["emptySpaceTop"] as DivElement;
  }

  set margin(Margin margin) {
    _model.margin = margin;
    _adaptElement(position);
  }

  set color(Color color) {
    _model.color = color;
    this.style.background = color.mainColor;
  }

  @override
  void moveTo(Position position) {
    if (_model == null) {
      throw new Exception("On Layout call 'init' before 'moveTo'");
    }
    super.moveTo(position);
    _adaptElement(position);
    _moveToolbar(position);
  }

  @override
  void setApplicationEventBus(ApplicationEventBus value) {
    super.setApplicationEventBus(value);
    _toolbar.setApplicationEventBus(value);
  }

  void _adaptElement(Position position) {
    _space.style.marginLeft = "${_model.leftMarginInPx(position)}px";
    _space.style.marginRight = "${_model.rightMarginInPx(position)}px";
    _space.style.width = "${_model.spaceWidth(position) }px";

    _emptySpaceTop.style.height = "${_model.topMarginInPx(position)}px";
    _emptySpaceBottom.style.height =
        "${_model.bottomMarginInPx(position) + _toolbar.model.mainButtonPosition.height   }px";
  }

  void _moveToolbar(Position position) {
    num nbActions = _toolbar.model.nbActions;
    if (nbActions > 0) {
      Position toolBarPosition = position.clone();
      toolBarPosition.left = _model.leftMarginInPx(position);
      toolBarPosition.height = _model.toolBarHeight(position);
      toolBarPosition.top = position.height - _model.bottomMarginInPx(position) - toolBarPosition.height;
      toolBarPosition.width = (_model.spaceWidth(position) - 10) / nbActions;
      _toolbar.moveTo(toolBarPosition);

      _emptySpaceBottom.style.width = "${toolBarPosition.width}px";
      _emptySpaceBottom.style.height = "${ _model.bottomMarginInPx(position) + toolBarPosition.height}px";
    }
  }
}
