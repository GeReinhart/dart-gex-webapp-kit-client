import 'package:polymer/polymer.dart';


@CustomTag('gex-absolute-space')
class CodelabElement extends PolymerElement {
  
  @published String backgroundColor = "black";
  
  CodelabElement.created() : super.created() ;
  
  void ready() {
    super.ready();
    this.style.backgroundColor = backgroundColor; 
  }
  
}
