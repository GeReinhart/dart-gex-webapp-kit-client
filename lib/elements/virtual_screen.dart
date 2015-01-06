library gex_common_ui_elements.virtual_screen;

import "dart:html";
import 'package:logging/logging.dart';
import 'dart:async';
import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:polymer/polymer.dart';


@CustomTag('gex-virtual-screen')
class VirtualScreen extends Positionable with Showable {
  
  ScreenDescriptor _screen ;
  
  
  VirtualScreen.created() : super.created() ;
  
  
  ScreenDescriptor get descriptor => _screen;
  
  void _updateScreen(){
  
    ScreenDescriptor newScreen = new ScreenDescriptor.fromWindow( window  ) ;
    if (newScreen != _screen  ){
      _screen = newScreen ;
    }
    var wait = new Duration(milliseconds: 100);
    new Timer(wait, ()=> _updateScreen());
    
  }
  
}


enum ScreenOrientation { LANDSCAPE , PORTRAIT }

class ScreenDescriptor {
  
  num _height ;
  num _width ;
  num _size ;

  ScreenDescriptor.fromWindow(Window window){
    _height = window.innerHeight ;
    _width = window.innerWidth ;
  }
  ScreenDescriptor(this._height, this._width, this._size);
  
  num get heigth => _height ;
  num get width => _width ;
  num get size => _size ;
  ScreenOrientation get orientation => _height > _width ? ScreenOrientation.LANDSCAPE : ScreenOrientation.PORTRAIT;
      
}