library gex_common_ui_elements.layout;

import "dart:html";
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';
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
  
  Layout.created() : super.created() ;
  
  void attached() {
    super.attached();
    this.style.backgroundColor = backgroundColor; 
  }
  
}