library gex_common_ui_elements.show_room_view_port;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/space.dart' ;
import 'package:gex_common_ui_elements/elements/view_port.dart' ;

@CustomTag('gex-show-room-view-port')
class ShowRoomViewPort extends Positionable with Showable {
  
  final Logger log = new Logger('ShowRoomViewPort');
  
  ViewPort viewPort ;
  Space viewPortSpace ;
  SpanElement viewPortWidth;
  SpanElement viewPortHeight;
  SpanElement viewPortOrientation;
  
  ShowRoomViewPort.created() : super.created(){
  }
  
  ready() {
    super.ready();
    _setAttributes();
    _setUpEventsOnElements();
  }
  
  @override
  void moveTo(Position position) {
      super.moveTo(position);
      _initialPositionsForElements();
  }
    
  
  void _setAttributes(){
    viewPort = $["viewPort"] as ViewPort ;
    viewPortSpace = $["viewPortSpace"] as Space ;
    viewPortWidth = this.shadowRoot.querySelector("#viewPortWidth") as SpanElement ;
    viewPortHeight = this.shadowRoot.querySelector("#viewPortHeight") as SpanElement ;
    viewPortOrientation = this.shadowRoot.querySelector("#viewPortOrientation") as SpanElement ;
  }

  void _setUpEventsOnElements(){
    viewPort.subscribeViewPortChange(_viewPortChangeCallBack) ;
  }

  void _viewPortChangeCallBack(ViewPortChangeEvent event){
    ViewPortDescriptor viewPort = event.viewPortDescriptor ;
    viewPortSpace.moveTo( new Position(0, 0, viewPort.windowWidth-140, viewPort.windowHeigth-140, 100));
    viewPortWidth.innerHtml = viewPort.windowWidth.toString();
    viewPortHeight.innerHtml = viewPort.windowHeigth.toString();
    viewPortOrientation.innerHtml = viewPort.orientation.toString();
  }

  void _initialPositionsForElements() {
    viewPortSpace.moveTo( new Position(0, 0, window.innerWidth-140, window.innerHeight-140, 101));
  }
  

 
  
  
}
