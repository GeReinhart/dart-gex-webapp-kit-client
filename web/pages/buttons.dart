library gex_common_ui_elements.show_room.buttons;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/layout.dart' ;
import 'package:gex_common_ui_elements/elements/page.dart' ;
import 'package:gex_common_ui_elements/elements/button.dart' ;


@CustomTag('page-buttons')
class PageButtons extends Page with Showable {
  
  static final String NAME = "buttons" ;
  final Logger log = new Logger(NAME);
  
  Color mainColor = Color.GREY_858585 ;
  
  Layout layout ;
  
  Button button1 ;
  Button button2 ;
  Button button3 ;
  Button button4;
  
  PageButtons.created() : super.created() ;
  
  
  ready() {
    super.ready();
    _setAttributesPage();
    _setAttributesButtons();    
    _initialPositionsForElements();
    _cloneAndMoveButtons();    
  }
  
  void _setAttributesPage(){
     layout = $["layout"] as Layout ;
     LayoutModel layoutModel = new LayoutModel(color: mainColor);
     PageModel model = new PageModel(name:NAME, layoutModel:layoutModel);
     this.init(model) ;
  }
  
  
  void _setAttributesButtons(){
    button1 = $["button1"] as Button ;
    button1.init(new ButtonModel(color:Color.WHITE, image: new Image(mainImageUrl:"images/button/info24.png"),label: "Action 1" , action: action1));
    
    button2 = $["button2"] as Button ;
    button2.init(new ButtonModel(color:Color.GREEN_07CC00, image: new Image(mainImageUrl:"images/button/list23.png"),label: "Action 2", action: action2 ));
    
    button3 = $["button3"] as Button ;
    button3.init(new ButtonModel(color:Color.GREY_858585, image: new Image(mainImageUrl:"images/button/save29.png"),label: "Action 3", action: action3 ));
    
    button4 = $["button4"] as Button ; 
    button4.init(new ButtonModel(color:Color.BLUE_0082C8, image: new Image(mainImageUrl:  "/images/button/save29.png",mainImageUrl2:"/images/button/map32.png" ),label: "Action 4", action: action4 ));
    button4.status = ButtonStatus.HIGHLIGHTED;
    
  }


  void _initialPositionsForElements() {
    button2.moveTo( new Position(150, 100, 150, 120, 101));
    button3.moveTo( new Position(300, 100, 150, 120, 101));
    button4.moveTo( new Position(600, 100, 250, 120, 101));
    button1.moveTo( new Position(850, 100, 150, 120, 101));
  }
  

  action1(Parameters params){
    layout.color =Color.WHITE.lightColorAsColor ;
  }
  action2(Parameters params){
    layout.color =Color.GREEN_07CC00.lightColorAsColor ;
  }
  action3(Parameters params){
    layout.color =Color.GREY_858585.lightColorAsColor ;
  }
  action4(Parameters params){
    layout.color =Color.BLUE_0082C8.lightColorAsColor ;
  }
  
  
  void _cloneAndMoveButtons() {
    _cloneAndMove(button2,new Position(150, 300, 150, 120, 102));
    _cloneAndMove(button3,new Position(300, 300, 150, 120, 102));
    _cloneAndMove(button4,new Position(600, 300, 150, 120, 102));
    _cloneAndMove(button1,new Position(850, 300, 150, 120, 102));
    
    _cloneAndMove(button2,new Position(150, 500, 50, 50, 102));
    _cloneAndMove(button3,new Position(500, 300, 50, 50, 102));
    _cloneAndMove(button4,new Position(600, 500, 50, 50, 102));
    _cloneAndMove(button1,new Position(850, 500, 50, 50, 102));
    
    _cloneAndMove(button2,new Position(150, 600, 250, 120, 103));
    _cloneAndMove(button3,new Position(600, 600, 300, 200, 103));
  }
  
  void _cloneAndMove(Button button,Position position){
    layout.append(button.cloneAndMove(position));
  }  

}