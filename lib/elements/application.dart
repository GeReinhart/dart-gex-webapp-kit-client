library gex_common_ui_elements.application;

import "dart:html";
import 'package:logging/logging.dart';
import 'dart:async';
import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:gex_common_ui_elements/elements/space.dart' ;
import 'package:gex_common_ui_elements/elements/button.dart' ;
import 'package:gex_common_ui_elements/elements/toolbar.dart' ;
import 'package:gex_common_ui_elements/elements/view_port.dart' ;
import 'package:gex_common_ui_elements/elements/page.dart' ;
import 'package:polymer/polymer.dart';

/**
 * Listen to the screen/window changes and broadcast ViewPort change events.
 */
@CustomTag('gex-application')
class Application extends Positionable with Showable {
  
  final Logger log = new Logger('Application');
  
  ViewPort _viewPort ;
  Element _toolBarsContainer ;
  List<Toolbar> _toolbars = new List<Toolbar>();
  Element _pagesContainer ;
  List<Page> _pages = new List<Page>();
  
  Application.created() : super.created(){
  } 
  
  List<Page> get pages => _pages;
  
  @override
  void ready() {
    super.ready();
    _setAttributes();
    _initialPositionsForElements();
    _setUpEventsOnElements(); 
  }
  
  void _setAttributes() {
    _viewPort = $["viewPort"] as ViewPort;
    _toolBarsContainer = $["toolBars"] ;
    _pagesContainer = $["pages"] ;
  }

  void _setUpEventsOnElements() {
  }
  
  void _initialPositionsForElements() {
  }
  
  @override
  void moveTo(Position position) {
      super.moveTo(position);
      Position subElementPosition = position.clone();
      subElementPosition.left = 0 ;
      subElementPosition.top = 0 ;
      
      _moveToolBars(subElementPosition);
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
  
  void addToolbar(List<ActionDescriptor> actions, String backgroundColor ){
    
    Toolbar toolbar = new Element.tag('gex-toolbar') as Toolbar;
    toolbar.backgroundColor = backgroundColor;
    _toolbars.add(toolbar);
    switch(_toolbars.length-1){
      case 0:
        toolbar.init( Orientation.est, actions );
        break;
      case 1:
        toolbar.init( Orientation.south, actions );
        break;
      case 2:
        toolbar.init( Orientation.west, actions );        
        break;
      case 3:
        toolbar.init( Orientation.north, actions );        
        break;
    }    
    
    _toolBarsContainer.append(toolbar);
    _moveToolBars(position);
  }

  void _moveToolBars(Position position){
    for(int i=0 ; i<_toolbars.length ; i++){
      Toolbar toolbar = _toolbars[i];
      
      num width  = position.width / 8 ;
      num height = position.height * 0.15;
      num zIndex = position.zIndex + 1 ;
      switch(i){
        case 0:
          toolbar.moveTo( new Position(0,0, width,  height, zIndex  )  );
          break;
        case 1:
          toolbar.moveTo( new Position(position.width - width,0, width,  height, zIndex   )  );
          break;
        case 2:
          toolbar.moveTo( new Position(position.width - width,position.top - height, width,  height, zIndex   )  );
          break;
        case 3:
          toolbar.moveTo( new Position(0 ,position.top - height, width,  height, zIndex   )  );
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
  
  Page buildPage(HtmlElement pageContent){
    Page page = new Element.tag('gex-page') as Page;
    page.content = pageContent;
    return page ;
  }
  
  void _movePages(Position position){
    for(Page page in _pages){
      page.moveTo(position);
    }
  }
  
}