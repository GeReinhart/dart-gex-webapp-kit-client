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
    _initialPositionsForElements();
    _cloneAndMoveButtons();
  }
  
  void _setAttributes(){
    button1 = $["button1"] as Button ;
    button1.init(new ButtonModel(color:Color.WHITE, image: "images/button/info24.png",label: "Action 1" , action: action1));
    
    button2 = $["button2"] as Button ;
    button2.init(new ButtonModel(color:Color.GREEN_07CC00, image: "images/button/list23.png",label: "Action 2", action: action2 ));
    
    button3 = $["button3"] as Button ;
    button3.init(new ButtonModel(color:Color.GREY_858585, image: "images/button/save29.png",label: "Action 3", action: action3 ));
    
    button4 = $["button4"] as Button ; 
    button4.init(new ButtonModel(color:Color.BLUE_0082C8, image: "images/button/user58.png",label: "Action 4", action: action4 ));
    
    buttonSpace = $["buttonSpace"] as Space ;
  }


  void _initialPositionsForElements() {
    button1.moveTo( new Position(0, 100, 150, 120, 101));
    button2.moveTo( new Position(150, 100, 150, 120, 101));
    button3.moveTo( new Position(300, 100, 150, 120, 101));
    button4.moveTo( new Position(600, 100, 150, 120, 101));
  }
  

  action1(Parameters params){
    buttonSpace.style.backgroundColor =Color.WHITE.lightColor ;
  }
  action2(Parameters params){
    buttonSpace.style.backgroundColor =Color.GREEN_07CC00.lightColor ;
  }
  action3(Parameters params){
    buttonSpace.style.backgroundColor =Color.GREY_858585.lightColor ;
  }
  action4(Parameters params){
    buttonSpace.style.backgroundColor =Color.BLUE_0082C8.lightColor ;
  }
  
  
  void _cloneAndMoveButtons() {
    _cloneAndMove(button1,new Position(0, 300, 150, 120, 102));
    _cloneAndMove(button2,new Position(150, 300, 150, 120, 102));
    _cloneAndMove(button3,new Position(300, 300, 150, 120, 102));
    _cloneAndMove(button4,new Position(600, 300, 150, 120, 102));
    
    _cloneAndMove(button1,new Position(0, 500, 50, 50, 102));
    _cloneAndMove(button2,new Position(150, 500, 50, 50, 102));
    _cloneAndMove(button3,new Position(500, 300, 50, 50, 102));
    _cloneAndMove(button4,new Position(600, 500, 50, 50, 102));
  }
  
  void _cloneAndMove(Button button,Position position){
    buttonSpace.append(button.cloneAndMove(position));
  }
  
  
  
}