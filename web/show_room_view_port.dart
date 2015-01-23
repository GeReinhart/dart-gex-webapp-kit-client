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
  SpanElement viewPortDiagonal;
  SpanElement viewPortDevicePixelRatio;
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
    viewPortDevicePixelRatio = this.shadowRoot.querySelector("#viewPortDevicePixelRatio") as SpanElement ;
    viewPortDiagonal = this.shadowRoot.querySelector("#viewPortDiagonal") as SpanElement ;
    viewPortOrientation = this.shadowRoot.querySelector("#viewPortOrientation") as SpanElement ;
    
    viewPortSpace.style.backgroundColor = Color.BLUE_0082C8.veryLightColor;
    _viewPortChangeCallBack( new ViewPortChangeEvent(viewPort.model)) ;
  }

  void _setUpEventsOnElements(){
    viewPort.subscribeViewPortChange(_viewPortChangeCallBack) ;
  }

  void _viewPortChangeCallBack(ViewPortChangeEvent event){
    ViewPortModel viewPort = event.viewPortModel ;
    viewPortSpace.moveTo( new Position(0, 0, viewPort.windowWidth-140, viewPort.windowHeight-140, 100));
    viewPortWidth.innerHtml = viewPort.windowWidth.toString();
    viewPortHeight.innerHtml = viewPort.windowHeight.toString();
    viewPortDiagonal.innerHtml = viewPort.windowDiagonal.toString();
    viewPortDevicePixelRatio.innerHtml = viewPort.windowDevicePixelRatio.toString();
    viewPortHeight.innerHtml = viewPort.windowHeight.toString();
    viewPortOrientation.innerHtml = viewPort.orientation.toString();
  }

  void _initialPositionsForElements() {
    viewPortSpace.moveTo( new Position(0, 0, window.innerWidth-140, window.innerHeight-140, 101));
  }
  

 
  
  
}
