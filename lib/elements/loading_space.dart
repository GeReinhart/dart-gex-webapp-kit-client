// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.absolute_space;

import "dart:html";
import 'package:polymer/polymer.dart';

import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:gex_webapp_kit_client/elements/spinner.dart';

/**
 * Create an absolute positioning space.
 */
@CustomTag('gex-loading-space')
class LoadingSpace extends Positionable with Showable {
  Spinner get _spinner => $["spinner"] as Spinner;
  DivElement get _messageElement => $["message"] as DivElement;

  @observable
  String message = "Loading...";

  LoadingSpace.created() : super.created();

  @override
  void ready() {
    hide();
  }

  @override
  void moveTo(Position position) {
    super.moveTo(position);
    _spinner.size = position.smallerSection / 3;
    _spinner
        .moveTo(new Position(position.width / 3, position.height / 3, position.width / 3, position.height / 3, 101));
    moveAnElementTo(_messageElement, new Position(position.width / 3 + _spinner.innerBallSize, position.height / 3,
        position.width / 3, position.height / 3, 100));
    _messageElement.style.fontSize = "${_spinner.innerBallSize * 2/3}px";
  }

  @override
  void hide() {
    super.hide();
    _spinner.hide();
  }

  void showLoadingSpace(String message) {
    this.message = message;
    _spinner.show();
    this.show();
  }
}
