library gex_common_ui_elements.layout;

import "dart:html";
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:gex_common_ui_elements/elements/button.dart';
import 'package:gex_common_ui_elements/elements/space.dart';
import 'package:gex_common_ui_elements/elements/toolbar.dart';
import 'package:polymer/polymer.dart';

/**
 * Create a workspace inside the available space.
 * Put toolbars at the 4 corners of the space.
 * Put buttons at the bottom of the space.
 * Adapt the workspace and the toolbars according to the viewPort change events. 
 */
@CustomTag('gex-layout')
class Layout extends Positionable with Showable {
  
  
  
  final Logger log = new Logger('Toolbar');
  
  @published String backgroundColor = "white";
  
  num marginXInPercent = 0.3 ;
  num buttonYInPercent = 0.1 ;
  
  DivElement _space ;
  DivElement _emptySpace ;
  
  Toolbar _toolbar ;
  
  Layout.created() : super.created() ;
  
  ready() {
    super.ready();
    this.style.backgroundColor = backgroundColor; 
    _setAttributes();
  }

  void _setAttributes(){
    _space = $["space"] as DivElement ;
    _toolbar = $["toolbar"] as Toolbar ;
    _toolbar.hide();
    _emptySpace = $["emptySpace"] as DivElement ;
  }
  
  @override
  void moveTo(Position position) {
      super.moveTo(position);
      Position spacePosition = position.clone();
      spacePosition.left =  spacePosition.width *  marginXInPercent / 2; 
      spacePosition.width =  spacePosition.width * (1- marginXInPercent);
      _space.style.marginLeft = "${spacePosition.left}px";
      _space.style.width = "${spacePosition.width}px";
      
      _moveToToolbar(position);
  }
  
  void _moveToToolbar(Position position){
    if(_toolbar.nbActions > 0){
      Position toolBarPosition = position.clone();
      toolBarPosition.left =  position.width *  marginXInPercent / 2; 
      toolBarPosition.height =  position.height * buttonYInPercent;
      toolBarPosition.top  = position.height - toolBarPosition.height - (toolBarPosition.height * buttonYInPercent  ) ;
      toolBarPosition.width =  position.width * (1- marginXInPercent) / _toolbar.nbActions  ;
      _toolbar.moveTo(toolBarPosition);
      
      _emptySpace.style.width = "${toolBarPosition.width}px";
      _emptySpace.style.height = "${toolBarPosition.height}px";
    }
  }
  
  set actions(List<ActionDescriptor> actions) {
    _toolbar.init(Orientation.est, actions);
    _moveToToolbar(position);
    _toolbar.show();
  }
  
}