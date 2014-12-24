library gex_common_ui_elements.toolbar;

import "dart:html";
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:gex_common_ui_elements/elements/button.dart';
import 'package:polymer/polymer.dart';

@CustomTag('gex-toolbar')
class Toolbar extends Positionable {
  
  final Logger log = new Logger('Toolbar');
  
  @published String backgroundColor = "black";
  
  Position mainButtonPosition ;
  Position postion ;
  Orientation orientation ;
  List<ActionDescriptor> actions ;
  List<Button> buttons ;
  
  Toolbar.created() : super.created() ;
  
  void attached() {
    super.attached();
    this.style.backgroundColor = backgroundColor; 
  }
  
  
  void init(Position position, Orientation orientation, List<ActionDescriptor> actions) {
    this.mainButtonPosition = position;
    this.orientation = orientation;
    this.actions = actions ;
    buttons = new List<Button>();
    this.postion = position.clone() ;
    for (var i = 0; i < actions.length; i++) {
      Button button = new Element.tag('gex-button') as Button;
      
      ActionDescriptor  action = actions[i];
      button.label = action.name ;
      
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
      button.targetAction(action);
      this.append(button);
      buttons.add(button);
    }
    
    num buttonCount = actions.length  ;
    if ( Orientation.est ==  orientation ){
      this.postion.width = buttonCount * position.width ;
    }
    if ( Orientation.west ==  orientation ){
      this.postion.left =  position.left - (buttonCount-1)* position.width ;
    }
    if ( Orientation.south ==  orientation ){
      this.postion.height =  buttonCount * position.height ;
    }
    if ( Orientation.north ==  orientation ){
      this.postion.top =  position.top - (buttonCount-1)* position.height ;
      this.postion.height =  buttonCount * position.height ;
    }    
    
    moveTo(this.postion);
  }
  
}
