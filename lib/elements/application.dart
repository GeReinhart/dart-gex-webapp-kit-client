library gex_common_ui_elements.application;

import "dart:html" hide ScreenOrientation;
import 'package:polymer/polymer.dart';
import 'package:logging/logging.dart';
import 'dart:async';

import 'package:gex_common_ui_elements/common_ui_elements.dart';

import 'package:gex_common_ui_elements/elements/toolbar.dart' ;
import 'package:gex_common_ui_elements/elements/view_port.dart' ;
import 'package:gex_common_ui_elements/elements/page.dart' ;

/**
 * Listen to the screen/window changes and broadcast ViewPort change events.
 */
@CustomTag('gex-application')
class Application extends Positionable with Showable {
  
  final Logger log = new Logger('Application');
  
  ViewPort _viewPort ;
  Element _toolbarsContainer ;
  List<Toolbar> _toolbars = new List<Toolbar>();
  Element _pagesContainer ;
  List<Page> _pages = new List<Page>();
  
  num _toolBarWidth = 0 ;
  num _toolBarHeight = 0 ;
  
  Application.created() : super.created();
  
  List<Page> get pages => _pages;
  
  
  
  @override
  void ready() {
    super.ready();
    _setAttributes();
  }
  
  void _setAttributes() {
    _viewPort = $["viewPort"] as ViewPort;
    _toolbarsContainer = $["toolBars"] ;
    _pagesContainer = $["pages"] ;
  }

 
  void subscribeViewPortChange( ViewPortChangeCallBack callBack  ){
    _viewPort.subscribeViewPortChange(callBack);
  }
  
  ViewPortModel get viewPortModel => _viewPort.model;
  List<ToolbarModel> get toolbarModels {
    List<ToolbarModel> toolbars = new List<ToolbarModel> ();
    _toolbars.forEach((t)=> toolbars.add(t.model));
    return toolbars ;
  }
  
  
  void fitWithWindow(){
     moveTo( new Position(0,0,viewPortModel.windowWidth,viewPortModel.windowHeight, 100)  );
     subscribeViewPortChange( (event){
         moveTo( new Position(0,0,viewPortModel.windowWidth,viewPortModel.windowHeight, 100)  );
     }) ;
  }
  
  @override
  void moveTo(Position position) {
      super.moveTo(position);
      Position subElementPosition = position.clone();
      subElementPosition.left = 0 ;
      subElementPosition.top = 0 ;
      
      _moveToolBars(subElementPosition,position.orientation);
      _movePages(subElementPosition);
  }
  
  @override
  void show(){
    super.show();
    _pages.forEach((p)=> p.hideOrShowPutToInitialState()) ;
  }
  
  @override
  void hide(){
    super.hide();
    _pages.forEach((p)=> p.hideBeforePutBackInitialState()) ;
  }
  
  void showPage({num pageIndex , Page page  }){
    _pages.forEach((p)=> p.hide()) ;
    if (pageIndex!= null ){
      _pages[pageIndex].show();
    }
    if (page!= null ){
      page.show();
    }
  }
  
  void addToolbar(ToolbarModel model){
    
    Toolbar toolbar = new Element.tag('gex-toolbar') as Toolbar;
    toolbar.init(model);
    _toolbars.add(toolbar);    
    _toolbarsContainer.append(toolbar);
    _moveToolBars(position,position.orientation);
  }

  void _moveToolBars(Position position, ScreenOrientation screenOrientation){
    for(int i=0 ; i<_toolbars.length ; i++){
      Toolbar toolbar = _toolbars[i];
      
      num pagePercentage = 0.20 ;
      num size = position.width>position.height?position.height*pagePercentage:position.width*pagePercentage;
      _toolBarWidth  = size ;
      _toolBarHeight = size;
      
      num zIndex = position.zIndex + 1 ;
      switch(i){ 
        case 0:
          toolbar.orientation =    screenOrientation == ScreenOrientation.LANDSCAPE ? Orientation.south : Orientation.est  ;
          toolbar.moveTo( new Position(0,0, _toolBarWidth,  _toolBarHeight, zIndex  )  );
          break;
        case 1:
          toolbar.orientation =    screenOrientation == ScreenOrientation.LANDSCAPE ? Orientation.north : Orientation.west  ;
          toolbar.moveTo( new Position(position.width - _toolBarWidth,position.height - _toolBarHeight, _toolBarWidth,  _toolBarHeight, zIndex   )  );
          break;
        case 2:
          toolbar.orientation =    screenOrientation == ScreenOrientation.LANDSCAPE ? Orientation.west : Orientation.south  ;
          toolbar.moveTo( new Position(position.width - _toolBarWidth,0, _toolBarWidth,  _toolBarHeight, zIndex   )  );
          break;
        case 3:
          toolbar.orientation =    screenOrientation == ScreenOrientation.LANDSCAPE ? Orientation.est : Orientation.north  ;
          toolbar.moveTo( new Position(0 ,position.height - _toolBarHeight, _toolBarWidth,  _toolBarHeight, zIndex   )  );
          break;
      }
    }
  }
  
  void addPage(Page page){
    _pagesContainer.append(page);
    _pages.add(page);
    page.hide();
    page.moveTo(position);
  }
  
  
  void _movePages(Position position){
    
    Margin margin = new Margin(leftInPx: _toolBarWidth,rightInPx: _toolBarWidth, topInPx:_toolBarHeight , bottomInPx:_toolBarHeight);
    for(Page page in _pages){
      page.margin = margin ;
      page.moveTo(position);
    }
  }
  
}