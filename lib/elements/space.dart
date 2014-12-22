library gex_common_ui_elements.absolute_space;

import 'package:polymer/polymer.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';

@CustomTag('gex-space')
class Space extends Positionable with Showable {
  
  @published String backgroundColor = "black";
  
  Space.created() : super.created() ;
  
  void ready() {
    super.ready();
    this.style.backgroundColor = backgroundColor; 
  }
  
}
