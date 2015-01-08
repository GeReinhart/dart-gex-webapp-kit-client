library gex_common_ui_elements.virtual_screen;

import "dart:html";
import 'package:logging/logging.dart';
import 'dart:async';
import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:polymer/polymer.dart';


@CustomTag('gex-view-port')
class ViewPort extends Positionable with Showable {
  
  final Logger log = new Logger('ViewPort');
  
  ViewPortDescriptor _viewPort ;
  StreamController<ViewPortChangeEvent> _viewPortChangeEventStream ;
  
  ViewPort.created() : super.created(){
    _viewPortChangeEventStream = new StreamController<ViewPortChangeEvent>.broadcast(sync: false);
  } 
  
  void attached() {
    super.attached();
    _updateViewPort(); 
  }
  
  ViewPortDescriptor get descriptor => _viewPort;
  
  void subscribeViewPortChange( ViewPortChangeCallBack callBack  ){
    _viewPortChangeEventStream.stream.listen((event) => callBack(event));
  }
  
  void _updateViewPort(){
    ViewPortDescriptor newScreen = new ViewPortDescriptor.fromWindow( window  ) ;
    if (newScreen != _viewPort  ){
      _viewPort = newScreen ;
      log.info("ViewPort ${id} changed to ${_viewPort}");
      _viewPortChangeEventStream.add( new ViewPortChangeEvent(_viewPort) ) ;
    }
    var wait = new Duration(milliseconds: 250);
    new Timer(wait, ()=> _updateViewPort());
  }
  
}

typedef void ViewPortChangeCallBack(ViewPortChangeEvent event);

class ViewPortChangeEvent{
  ViewPortDescriptor _viewPortDescriptor ;
  
  ViewPortChangeEvent(this._viewPortDescriptor);
  
  ViewPortDescriptor get viewPortDescriptor => _viewPortDescriptor;
}

enum ScreenOrientation { LANDSCAPE , PORTRAIT }

class ViewPortDescriptor {
  
  num _windowHeight ;
  num _windowWidth ;

  ViewPortDescriptor.fromWindow(Window window){
    _windowHeight = window.innerHeight ;
    _windowWidth = window.innerWidth ;
  }
  ViewPortDescriptor(this._windowHeight, this._windowWidth);
  
  num get windowHeigth => _windowHeight ;
  num get windowWidth => _windowWidth ;
  ScreenOrientation get orientation => _windowHeight < _windowWidth ? ScreenOrientation.LANDSCAPE : ScreenOrientation.PORTRAIT;
      
  
  @override
  String toString() => "ViewPortDescriptor: windowHeight: ${_windowHeight}, windowWidth: ${_windowWidth}";
  
  @override
  int get hashCode {
     int result = 17;
     result = 37 * result + _windowHeight.hashCode;
     result = 37 * result + _windowWidth.hashCode;
     return result;
  }

  @override
  bool operator ==(other) {
     if (other is! ViewPortDescriptor) return false;
     ViewPortDescriptor viewPort = other;
     return (viewPort.hashCode == this.hashCode);
   }
  
}