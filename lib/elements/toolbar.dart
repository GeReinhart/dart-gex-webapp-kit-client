library gex_common_ui_elements.toolbar;

import "dart:html";
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:gex_common_ui_elements/elements/button.dart';
import 'package:polymer/polymer.dart';

/**
 * Display buttons to create a toolbar.
 */
@CustomTag('gex-toolbar')
class Toolbar extends Positionable {
  
  final Logger log = new Logger('Toolbar');
  
  @published String backgroundColor = "black";
  
  Position mainButtonPosition = new Position.empty();
  Orientation orientation ;
  List<ActionDescriptor> actions ;
  List<Button> buttons ;
  
  Toolbar.created() : super.created() ;
  
  void attached() {
    super.attached();
    this.style.backgroundColor = backgroundColor; 
  }
  
  void init(Orientation orientation, List<ActionDescriptor> actions) {
    this.orientation = orientation;
    _initButtons(actions);
  }
  
  @override
  void moveTo(Position position){
    if (isCurrentPostion(position)){
      return ;
    }
    _moveButtons(position);
    super.moveTo(this.position);
  }
  
  void _initButtons( List<ActionDescriptor> actions) {
    this.actions = actions ;
    this.buttons = new List<Button>();
    
    for (var i = 0; i < actions.length; i++) {
      Button button = new Element.tag('gex-button') as Button;
      
      ActionDescriptor  action = actions[i];
      button.label = action.name ;
      if (action.image != null){
        button.image = action.image;
      }
      button.targetAction(action);
      this.append(button);
      buttons.add(button);
    }
  }
 
  void _moveButtons(Position position) {
    this.mainButtonPosition = position;
    this.position.merge(position) ;
    for (var i = 0; i < buttons.length; i++) {
      Button button = buttons[i];
      
      num left = 0;
      if ( Orientation.est ==  orientation ){
        left =  i * position.width ;
      }
      if ( Orientation.west ==  orientation ){
        left =  (actions.length - i -1 ) * position.width ;
      }
      
      num top = 0;
      if ( Orientation.south ==  orientation ){
        top =  i * position.height ;
      }
      if ( Orientation.north ==  orientation ){
        top =  (actions.length - i -1 )* position.height ;
      }      
      Position currentPostion = position.clone() ;
      currentPostion..left = left
                    ..top = top ;
      
      button.moveTo(currentPostion) ;
    }
    
    num buttonCount = buttons.length  ;
    if ( Orientation.est ==  orientation ){
      this.position.width = buttonCount * position.width ;
    }
    if ( Orientation.west ==  orientation ){
      this.position.left =  position.left - (buttonCount-1)* position.width ;
      this.position.width =  buttonCount * position.width ;
    }
    if ( Orientation.south ==  orientation ){
      this.position.height =  buttonCount * position.height ;
    }
    if ( Orientation.north ==  orientation ){
      this.position.top =  position.top - (buttonCount-1)* position.height ;
      this.position.height =  buttonCount * position.height ;
    }    
    
    
  }  
  
  
  
}
