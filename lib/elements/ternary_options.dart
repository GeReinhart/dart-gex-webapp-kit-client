// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.ternary_options;

import 'package:polymer/polymer.dart';
import 'dart:html';

import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'button.dart';

@CustomTag('gex-ternary-options')
class TernaryOptions extends Positionable with Showable {
  @observable TernaryOptionsModel model;

  TernaryOptions.created() : super.created();

  void init(TernaryOptionsModel model) {
    this.model = model;

    buttonsContainerRelative.style
      ..height = "${model.buttonSize*2}px";

    buttonsContainer.style
      ..height = "${model.buttonSize}px";
    desc.style
      ..left = "${model.buttonSize*3 + 10}px"
      ..top = "${model.buttonSize/2}px";

    label.style
      ..left = "${10}px"
      ..top = "${model.buttonSize +10}px";

    this.width = model.width;
      
    buttonNone.init(new ButtonModel(color: model.color, action: (p) => this.option = TernaryOption.NONE));
    buttonNone.moveTo(new Position(0, 0, model.buttonSize, model.buttonSize, 100));
    buttonEnabled.init(new ButtonModel(
        color: model.color,
        action: (p) => this.option = TernaryOption.ENABLED,
        image: new Image(mainImageUrl: "/images/button/checkmark17.png")));
    buttonEnabled.moveTo(new Position(model.buttonSize, 0, model.buttonSize, model.buttonSize, 100));
    buttonDisabled.init(new ButtonModel(
        color: model.color,
        action: (p) => this.option = TernaryOption.DISABLED,
        image: new Image(mainImageUrl: "/images/button/croos.png")));
    buttonDisabled.moveTo(new Position(model.buttonSize * 2, 0, model.buttonSize, model.buttonSize, 100));

    option = model.option;
  }

  set width(num value){
    model.width = value;

    buttonsContainerRelative.style.width = "${model.width}px";
    buttonsContainer.style.width = "${model.buttonSize*3}px";
    desc.style.width  = "${model.width - model.buttonSize*4}px";
    label.style.width = "${model.width - model.buttonSize*4}px";
  }
  
  set option(TernaryOption value) {
    switch (value.toString()) {
      case "TernaryOption.NONE":
        buttonNone.status = ButtonStatus.HIGHLIGHTED;
        buttonEnabled.status = ButtonStatus.NORMAL;
        buttonDisabled.status = ButtonStatus.NORMAL;
        label.innerHtml = model.labelNone;
        break;
      case "TernaryOption.ENABLED":
        buttonNone.status = ButtonStatus.NORMAL;
        buttonEnabled.status = ButtonStatus.HIGHLIGHTED;
        buttonDisabled.status = ButtonStatus.NORMAL;
        label.innerHtml = model.labelEnabled;
        break;
      case "TernaryOption.DISABLED":
        buttonNone.status = ButtonStatus.NORMAL;
        buttonEnabled.status = ButtonStatus.NORMAL;
        buttonDisabled.status = ButtonStatus.HIGHLIGHTED;
        label.innerHtml = model.labelDisabled;
        break;
    }
    model.option = value;
  }

  TernaryOption get option => model.option;

  bool get optionAsBool {
    switch (model.option.toString()) {
      case "TernaryOption.NONE":
        return null;
      case "TernaryOption.ENABLED":
        return true;
      case "TernaryOption.DISABLED":
        return false;
    }
    return null;
  }

  set optionAsBool(bool value) {
    if (value == null) {
      this.option = TernaryOption.NONE;
    }
    if (value) {
      this.option = TernaryOption.ENABLED;
    } else {
      this.option = TernaryOption.DISABLED;
    }
  }

  HtmlElement get label => $["label"];
  HtmlElement get desc => $["desc"];
  HtmlElement get buttonsContainer => $["buttonsContainer"];
  HtmlElement get buttonsContainerRelative => $["buttonsContainerRelative"];
  Button get buttonNone => $["buttonNone"];
  Button get buttonEnabled => $["buttonEnabled"];
  Button get buttonDisabled => $["buttonDisabled"];
}
