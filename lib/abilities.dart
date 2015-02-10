// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_client;

typedef void LaunchAction(Parameters params);

enum Orientation {
  north,
  est,
  south,
  west
}

/**
 * Be able to move the element in an absolute space.
 */
abstract class Positionable extends PolymerElement {
  final Logger log = new Logger('Positionable');

  final Position position = new Position.empty();

  Positionable.created() : super.created() {}

  bool isCurrentPostion(Position position) {
    return position == this.position;
  }

  void moveTo(Position position) {
    this.position.merge(position);
    _moveToTargetPosition(this, position);
  }

  void moveAnElementTo(HtmlElement element, Position position) {
    _moveToTargetPosition(element, position);
  }

  void _moveToTargetPosition(HtmlElement element, Position position) {
    element.style.position = "absolute";
    element.style
      ..left = "${position.left}px"
      ..top = "${position.top}px"
      ..width = "${position.width}px"
      ..height = "${position.height}px"
      ..zIndex = position.zIndex.toString();
  }
}

class Position {
  num left = 0;
  num top = 0;
  num width = 0;
  num height = 0;
  num zIndex = 0;

  Position.empty();

  Position(this.left, this.top, this.width, this.height, this.zIndex);

  Position clone() {
    return new Position(this.left, this.top, this.width, this.height, this.zIndex);
  }

  num get smallerSection => width > height ? height : width;
  num get largerSection => width < height ? height : width;

  ScreenOrientation get orientation => width > height ? ScreenOrientation.LANDSCAPE : ScreenOrientation.PORTRAIT;

  @override
  String toString() => "SquarePosition: left:${left}, top:${top}, width:${width}, height:${height}, zIndex:${zIndex}";

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + left.hashCode;
    result = 37 * result + top.hashCode;
    result = 37 * result + width.hashCode;
    result = 37 * result + height.hashCode;
    result = 37 * result + zIndex.hashCode;
    return result;
  }

  @override
  bool operator ==(other) {
    if (other is! Position) return false;
    Position position = other;
    return (position.hashCode == this.hashCode);
  }

  void merge(Position position) {
    this.left = position.left;
    this.top = position.top;
    this.width = position.width;
    this.height = position.height;
    this.zIndex = position.zIndex;
  }
}

class Showable {
  String initialDisplay = null;

  bool isShowed() {
    assert(this is PolymerElement);
    return (this as PolymerElement).style.display != "none";
  }

  bool isHidden() {
    return !isShowed();
  }

  void show() {
    assert(this is PolymerElement);
    (this as PolymerElement).style.display = initialDisplay;
  }

  void hide() {
    assert(this is PolymerElement);
    PolymerElement element = this as PolymerElement;
    if (initialDisplay == null) {
      element.style.display = initialDisplay;
    }
    (this as PolymerElement).style.display = "none";
  }

  bool _initialState;
  void hideBeforePutBackInitialState() {
    _initialState = isShowed();
    hide();
  }

  void hideOrShowPutToInitialState() {
    if (_initialState) {
      show();
    }
  }
}
