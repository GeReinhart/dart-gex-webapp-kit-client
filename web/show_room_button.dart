library gex_common_ui_elements.show_room_button;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/space.dart' ;
import 'package:gex_common_ui_elements/elements/button.dart' ;

@CustomTag('gex-show-room-button')
class ShowRoomButton extends Positionable with Showable {
  
  final Logger log = new Logger('ShowRoomButton');
  
  Space buttonSpace ;
  Button button1 ;
  Button button2 ;
  Button button3 ;
  Button button4;
 
  
  
  ShowRoomButton.created() : super.created(){
  }

  
  ready() {
    super.ready();
    _setAttributes();
    _setUpEventsOnElements();
    _initialPositionsForElements();
    _cloneAndMoveButtons();
  }
  
  void _setAttributes(){
    button1 = $["button1"] as Button ;
    button2 = $["button2"] as Button ;
    button3 = $["button3"] as Button ;
    button4 = $["button4"] as Button ; 
    buttonSpace = $["buttonSpace"] as Space ;
  }

  void _setUpEventsOnElements(){
    button1.targetAction( new ActionDescriptor("","",action1) );
    button2.targetAction( new ActionDescriptor("","",action2 ) );
    button3.targetAction( new ActionDescriptor("","",action3 ) );
    button4.targetAction( new ActionDescriptor("","",action4 ) );
  }

  void _initialPositionsForElements() {
    button1.moveTo( new Position(0, 100, 150, 120, 101));
    button2.moveTo( new Position(150, 100, 150, 120, 101));
    button3.moveTo( new Position(300, 100, 150, 120, 101));
    button4.moveTo( new Position(600, 100, 150, 120, 101));
  }
  

  action1(Parameters params){
    buttonSpace.style.backgroundColor ="white" ;
  }
  action2(Parameters params){
    buttonSpace.style.backgroundColor ="#00D2B8" ;
  }
  action3(Parameters params){
    buttonSpace.style.backgroundColor ="#778899" ;
  }
  action4(Parameters params){
    buttonSpace.style.backgroundColor ="#FFFFE0" ;
  }
  
  
  void _cloneAndMoveButtons() {
    _cloneAndMove(button1,new Position(0, 300, 150, 120, 102),action1);
    _cloneAndMove(button2,new Position(150, 300, 150, 120, 102),action2);
    _cloneAndMove(button3,new Position(300, 300, 150, 120, 102),action3);
    _cloneAndMove(button4,new Position(600, 300, 150, 120, 102),action4);
    
    _cloneAndMove(button1,new Position(0, 500, 50, 50, 102),action1);
    _cloneAndMove(button2,new Position(150, 500, 50, 50, 102),action2);
    _cloneAndMove(button3,new Position(500, 300, 50, 50, 102),action3);
    _cloneAndMove(button4,new Position(600, 500, 50, 50, 102),action4);
  }
  
  void _cloneAndMove(Button button,Position position, LaunchAction action){
    buttonSpace.append(button.cloneAndMove(position));
  }
  
  
  
}