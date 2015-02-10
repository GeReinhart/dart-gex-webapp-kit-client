// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.extensible_button;

import "dart:html";
import 'package:polymer/polymer.dart';
import 'package:logging/logging.dart';

import 'package:gex_webapp_kit_client/webapp_kit_client.dart';

import 'package:paper_elements/paper_shadow.dart';

/**
 * Change it's display according to the space it can take.
 * Execute the action on the click on the button.
 */
@CustomTag('gex-button')
class Button extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('Button');
  final num MIN_SIZE_WITH_TEXT = 90;
  final num MIN_HEIGHT_TEXT = 30;
  final num PART_USED_BY_IMAGE = .85;

  ButtonModel _model;

  Button.created() : super.created();

  String get label => _model.label;
  Image get image => _model.image;

  bool get isButtonLabelVisible => _labelSpan.style.display != "none";
  bool get isImageVisible => _imageElement.style.display != "none" && _imageElement.src.isNotEmpty;

  SpanElement get _labelSpan => $["label"] as SpanElement;
  ImageElement get _imageElement => $["image"] as ImageElement;
  ImageElement get _imageElement2 => $["image2"] as ImageElement;
  ImageElement get imageElement => _imageElement.clone(true);
  PaperShadow get _shadow => $["shadow"] as PaperShadow;
  HtmlElement get _button => $["button"] as HtmlElement;
  DivElement get _colorElement => $["color"] as DivElement;
  DivElement get _mainElement => $["main"] as DivElement;

  factory Button.fromModel(ButtonModel model) {
    Button button = new Element.tag('gex-button') as Button;
    button.init(model);
    return button;
  }

  void init(ButtonModel model) {
    _model = model;
    _colorElement.style.backgroundColor = _model.color.mainColor;

    if (_model.hasImage) {
      _imageElement.style.display = "inline";
      _imageElement.src = image.mainImageUrl;
      if (image.mainImageUrls.length > 1) {
        _imageElement2.src = image.mainImageUrls[1];
      }
    } else {
      _imageElement.style.display = "none";
    }
    if (_model.hasLabel) {
      _labelSpan.innerHtml = _model.label;
      _labelSpan.style.fontWeight = "bold";
      _labelSpan.style.color = _model.color.veryStrongColor;
    }

    this.onClick.listen((_) => _targetAction());
    this.onMouseDown.listen((_) => _buttonDown());
    this.onMouseUp.listen((_) => _buttonUp());
  }

  void _buttonDown() {
    _shadow.z = 1;
    switch (status.toString()) {
      case "ButtonStatus.NORMAL":
        _colorElement.style.backgroundColor = _model.color.veryLightColor;
        _labelSpan.style.color = _model.color.veryStrongColor;
        _labelSpan.style.fontWeight = "bolder";
        break;
    }
  }

  void _buttonUp() {
    _shadow.z = 2;
    switch (status.toString()) {
      case "ButtonStatus.NORMAL":
        _colorElement.style.backgroundColor = _model.color.mainColor;
        _labelSpan.style.color = _model.color.veryStrongColor;
        _labelSpan.style.fontWeight = "bold";
        break;
      case "ButtonStatus.HIGHLIGHTED":
        _colorElement.style.backgroundColor = _model.color.veryLightColor;
        _labelSpan.style.color = _model.color.veryStrongColor;
        _labelSpan.style.fontWeight = "bolder";
        break;
    }
  }

  void _targetAction() {
    if (_model.type == ButtonType.PAGE_LAUNCHER) {
      if (_model.targetPageKey != null) {
        fireApplicationEvent(new PageCallEvent.fromPageKey(this, _model.targetPageKey));
      }
      return;
    }
    if (_model.action != null) {
      _model.action(null);
    }
  }

  set action(LaunchAction action) {
    _model.action = action;
  }

  @override
  void moveTo(Position position) {
    if (_model == null) {
      throw new Exception("On Button call 'init' before 'moveTo'");
    }
    if (isCurrentPostion(position)) {
      return;
    }
    super.moveTo(position);

    Position fullButtonPosition = new Position(0, 0, position.width, position.height, 100);
    moveAnElementTo(_mainElement, fullButtonPosition);
    moveAnElementTo(_shadow, fullButtonPosition);
    moveAnElementTo(_button, fullButtonPosition);
    moveAnElementTo(_colorElement, fullButtonPosition);

    num heightForImage;
    num heightForText = 0;
    if (_model.hasImage && (position.height < MIN_SIZE_WITH_TEXT || !_model.hasLabel)) {
      _labelSpan.style.display = "none";
      heightForImage = position.smallerSection;
    } else {
      _labelSpan.style.display = "";
      heightForImage = position.smallerSection - MIN_HEIGHT_TEXT;
      heightForText = MIN_HEIGHT_TEXT > position.height * (1 - PART_USED_BY_IMAGE)
          ? MIN_HEIGHT_TEXT
          : position.height * (1 - PART_USED_BY_IMAGE);
      ;
    }
    num squareSizeAsNum = heightForImage * PART_USED_BY_IMAGE;
    String squareSize = "${squareSizeAsNum}px";
    String smallMargin = "${heightForImage * (1-PART_USED_BY_IMAGE)/2 }px";
    String largeMargin =
        "${heightForImage * (1-PART_USED_BY_IMAGE)/2  + ( position.largerSection - position.smallerSection+heightForText)/2 }px";

    if (_model.hasImage) {
      if (_model.image.mainImageUrls.length == 1 || position.width < squareSizeAsNum * 2) {
        _imageElement.style
          ..width = squareSize
          ..height = squareSize
          ..top = position.height < position.width ? smallMargin : largeMargin
          ..left = position.height > position.width ? smallMargin : largeMargin;
        _imageElement2.style.display = "none";
      } else {
        if (_model.image.mainImageUrls.length == 2) {
          _imageElement2.style.display = "";
          _imageElement.style
            ..width = squareSize
            ..height = squareSize
            ..top = position.height < position.width ? smallMargin : largeMargin
            ..left = "${ (position.width - squareSizeAsNum *2) /2          }px";
          _imageElement2.style
            ..width = squareSize
            ..height = squareSize
            ..top = position.height < position.width ? smallMargin : largeMargin
            ..left = "${ (position.width - squareSizeAsNum *2) /2 + squareSizeAsNum}px";
        }
      }
    }

    _labelSpan.style.zIndex = "${position.zIndex +1 }";
    _imageElement.style.zIndex = "${position.zIndex +1 }";
    _imageElement2.style.zIndex = "${position.zIndex +1 }";
    _button.style.zIndex = "${position.zIndex +2 }";
    _colorElement.style.zIndex = "${position.zIndex -1}";

    try {
      Element internalButton = _button.shadowRoot.querySelector('div');
      internalButton.style
        ..position = "absolute"
        ..left = "0px"
        ..top = "0px"
        ..width = "${position.width}px"
        ..height = "${position.height}px";
    } catch (exception) {
      log.fine("Unable to change size of the internal button of ExtensibleButton ${id}");
    }
  }

  @override
  Button clone(bool deep) {
    Button clone = (new Element.tag('gex-button')) as Button;
    clone.init(_model.clone());
    return clone;
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    if (_model.type == ButtonType.PAGE_LAUNCHER) {
      if (_model.targetPageKey != null) {
        if (event is PageDisplayedEvent) {
          PageDisplayedEvent pageDisplayed = event;
          if (event.name == _model.targetPageKey.name) {
            this.status = ButtonStatus.HIGHLIGHTED;
          } else {
            this.status = ButtonStatus.NORMAL;
          }
        }
      }
      return;
    }
    _model.recieveApplicationEvent(event);
  }

  Button cloneAndMove(Position position) {
    Button clone = this.clone(true);
    return clone..moveTo(position);
  }

  ButtonStatus get status => _model.status;
  set status(ButtonStatus status) {
    _model.status = status;

    switch (status.toString()) {
      case "ButtonStatus.NORMAL":
        _colorElement.style.backgroundColor = _model.color.mainColor;
        _labelSpan.style.color = _model.color.veryStrongColor;
        _labelSpan.style.fontWeight = "bold";
        break;
      case "ButtonStatus.HIGHLIGHTED":
        _colorElement.style.backgroundColor = _model.color.veryLightColor;
        _labelSpan.style.color = _model.color.veryStrongColor;
        _labelSpan.style.fontWeight = "bolder";
        break;
    }
  }
}
