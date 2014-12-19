library gex_common_ui_elements.absolute_space;

import 'package:polymer/polymer.dart';

@CustomTag('gex-space')
class Space extends PolymerElement {
  
  @published String backgroundColor = "black";
  
  Space.created() : super.created() ;
  
  void ready() {
    super.ready();
    this.style.backgroundColor = backgroundColor; 
  }
  
}
