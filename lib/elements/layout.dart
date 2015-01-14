library gex_common_ui_elements.layout;

import "dart:html";
import 'package:polymer/polymer.dart';
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';

import 'package:gex_common_ui_elements/elements/toolbar.dart';

/**
 * Create a workspace inside the available space.
 * Put toolbars at the 4 corners of the space.
 * Put buttons at the bottom of the space.
 * Adapt the workspace and the toolbars according to the viewPort change events. 
 */
@CustomTag('gex-layout')
class Layout extends Positionable with Showable {
  
  final Logger log = new Logger('Layout');
  
  DivElement _space ;
  DivElement _emptySpace ;
  Toolbar _toolbar ;
  LayoutModel _model ;
  
  Layout.created() : super.created() ;
  
  @override
  void ready() {
    super.ready();
    _setAttributes();
  }

  void init(LayoutModel model){
    _model = model ;
    this.style.backgroundColor = model.color.veryLightColor ;
    _toolbar.init(model.toolbarModel);
  }
  
  void _setAttributes(){
    _space = $["space"] as DivElement ;
    _toolbar = $["toolbar"] as Toolbar ;
    _emptySpace = $["emptySpace"] as DivElement ;
  }
  
  @override
  void moveTo(Position position) {
      if(_model == null){
         throw new Exception("On Layout call 'init' before 'moveTo'");
      }
      super.moveTo(position);
      Position spacePosition = position.clone(); 
      num marginXInPercent = _model.marginXInPercent(position);
      spacePosition.left =  spacePosition.width * marginXInPercent / 2; 
      spacePosition.width =  spacePosition.width * (1- marginXInPercent);
      spacePosition.top =  spacePosition.height ;
      spacePosition.height =  spacePosition.height * (1 - 0.1 );
      
      _space.style.marginLeft = "${spacePosition.left}px";
      _space.style.width = "${spacePosition.width}px";
      
      _moveToolbar(position);
  }
  
  void _moveToolbar(Position position){
    num nbActions = _toolbar.model.nbActions;
    if( nbActions > 0){
      Position toolBarPosition = position.clone();
      num marginXInPercent = _model.marginXInPercent(position);
      toolBarPosition.left =  position.width *  marginXInPercent / 2; 
      toolBarPosition.height =  position.height ;
      toolBarPosition.top  = position.height - toolBarPosition.height - (toolBarPosition.height  ) ;
      toolBarPosition.width =  position.width * (1- marginXInPercent) / nbActions  ;
      _toolbar.moveTo(toolBarPosition);
      
      _emptySpace.style.width = "${toolBarPosition.width}px";
      _emptySpace.style.height = "${toolBarPosition.height}px";
    }
  }
  
}