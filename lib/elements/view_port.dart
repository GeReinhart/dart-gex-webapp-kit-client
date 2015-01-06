library gex_common_ui_elements.virtual_screen;

import "dart:html";
import 'package:logging/logging.dart';
import 'dart:async';
import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:polymer/polymer.dart';


@CustomTag('gex-virtual-screen')
class ViewPort extends Positionable with Showable {
  
  ViewPortDescriptor _viewPort ;
  
  
  ViewPort.created() : super.created() ;
  
  
  ViewPortDescriptor get descriptor => _viewPort;
  
  void _updateViewPort(){
  
    ViewPortDescriptor newScreen = new ViewPortDescriptor.fromWindow( window  ) ;
    if (newScreen != _viewPort  ){
      _viewPort = newScreen ;
    }
    var wait = new Duration(milliseconds: 100);
    new Timer(wait, ()=> _updateViewPort());
    
  }
  
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
  ScreenOrientation get orientation => _windowHeight > _windowWidth ? ScreenOrientation.LANDSCAPE : ScreenOrientation.PORTRAIT;
      
}