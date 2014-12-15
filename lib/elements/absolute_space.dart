library gex_common_ui_elements.absolute_space;

import 'package:polymer/polymer.dart';


@CustomTag('gex-absolute-space')
class AbsoluteSpace extends PolymerElement {
  
  @published String backgroundColor = "black";
  
  AbsoluteSpace.created() : super.created() ;
  
  void ready() {
    super.ready();
    this.style.backgroundColor = backgroundColor; 
  }
  
}
