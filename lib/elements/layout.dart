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
  DivElement _emptySpaceBottom ;
  DivElement _emptySpaceTop ;
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
    _emptySpaceBottom = $["emptySpaceBottom"] as DivElement ;
    _emptySpaceTop = $["emptySpaceTop"] as DivElement ;
  }
  
  set margin(Margin margin){
    _model.margin=margin;
  }
  
  @override
  void moveTo(Position position) {
      if(_model == null){
         throw new Exception("On Layout call 'init' before 'moveTo'");
      }
      super.moveTo(position);
      
      _space.style.marginLeft = "${_model.leftMarginInPx(position)}px";
      _space.style.width = "${_model.spaceWidth(position) }px";
      
      _emptySpaceTop.style.height = "${_model.topMarginInPx(position)}px";
      _emptySpaceTop.style.width = "${ _model.spaceWidth(position)}px";
      
      _moveToolbar(position);
  }
  
  void _moveToolbar(Position position){
    num nbActions = _toolbar.model.nbActions;
    if( nbActions > 0){
      Position toolBarPosition = position.clone();
      toolBarPosition.left =  _model.leftMarginInPx(position); 
      toolBarPosition.height =  _model.toolBarHeight(position); 
      toolBarPosition.top  = position.height - toolBarPosition.height - (toolBarPosition.height * 0.05  ) ;
      toolBarPosition.width =   _model.spaceWidth(position)  / nbActions  ;
      _toolbar.moveTo(toolBarPosition);
      

      _emptySpaceBottom.style.width = "${toolBarPosition.width}px";
      _emptySpaceBottom.style.height = "${toolBarPosition.height}px";
    }
  }
  
}