library gex_common_ui_elements.layout;

import "dart:html";
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:gex_common_ui_elements/elements/space.dart';
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
  
  num margin = 0.3 ;
  DivElement space ;
  
  Layout.created() : super.created() ;
  
  ready() {
    super.ready();
    this.style.backgroundColor = backgroundColor; 
    _setAttributes();
  }

  void _setAttributes(){
    space = $["space"] as DivElement ;
  }
  
  @override
  void moveTo(Position position) {
      super.moveTo(position);
      Position spacePosition = position.clone();
      spacePosition.left =  spacePosition.width *  margin / 2; 
      spacePosition.width =  spacePosition.width * (1- margin);
      space.style.marginLeft = "${spacePosition.left}px";
      space.style.width = "${spacePosition.width}px";
  }
  
}