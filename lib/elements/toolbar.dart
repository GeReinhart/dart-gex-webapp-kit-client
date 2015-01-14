library gex_common_ui_elements.toolbar;

import "dart:html";
import 'package:polymer/polymer.dart';
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:gex_common_ui_elements/elements/button.dart';

/**
 * Display buttons to create a toolbar.
 */
@CustomTag('gex-toolbar') 
class Toolbar extends Positionable with Showable {
  
  final Logger log = new Logger('Toolbar');
  
  ToolbarModel _model ;
  List<Button> _buttons ;
  
  Toolbar.created() : super.created() ;
  
  ToolbarModel get model => _model.clone();
  
  void init(ToolbarModel model) {
    _model = model ;
    _initButtons(model);
  }
  
  @override
  void moveTo(Position position){
    if(_buttons == null){
      throw new Exception("On ToolBar call 'init' before 'moveTo'");
    }    
    if (isCurrentPostion(position)){
      return ;
    }
    _moveButtons(position);
    super.moveTo(this.position);
  }
  
  void _initButtons( ToolbarModel model) {
    this._buttons = new List<Button>();
    List<ButtonModel> buttons = model.buttons;
    for (var i = 0; i < buttons.length; i++) {
      Button button = new Element.tag('gex-button') as Button;
      button.init( buttons[i]) ;
      this.append(button);
      _buttons.add(button);
    }
  }
 
  void _moveButtons(Position position) {
    _model.mainButtonPosition = position;
    this.position.merge(position) ;
    
    for (var i = 0; i < _buttons.length; i++) {
      Button button = _buttons[i];
      
      num left = 0;
      if ( Orientation.est ==  _model.orientation ){
        left =  i * position.width ;
      }
      if ( Orientation.west ==  _model.orientation ){
        left =  (_model.nbActions - i -1 ) * position.width ;
      }
      
      num top = 0;
      if ( Orientation.south ==  _model.orientation ){
        top =  i * position.height ;
      }
      if ( Orientation.north ==  _model.orientation ){
        top =  (_model.nbActions - i -1 )* position.height ;
      }      
      Position currentPostion = position.clone() ;
      currentPostion..left = left
                    ..top = top ;
      
      button.moveTo(currentPostion) ;
    }
    
    if ( Orientation.est ==  _model.orientation ){
      this.position.width = _model.nbActions * position.width ;
    }
    if ( Orientation.west ==  _model.orientation ){
      this.position.left =  position.left - (_model.nbActions-1)* position.width ;
      this.position.width =  _model.nbActions * position.width ;
    }
    if ( Orientation.south ==  _model.orientation ){
      this.position.height =  _model.nbActions * position.height ;
    }
    if ( Orientation.north ==  _model.orientation ){
      this.position.top =  position.top - (_model.nbActions-1)* position.height ;
      this.position.height =  _model.nbActions * position.height ;
    }    
  }  
  
  
  
}
