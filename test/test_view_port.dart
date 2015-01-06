library gex_common_ui_elements.test_virtual_screen;

import 'package:unittest/unittest.dart';
import 'package:mockito/mockito.dart';
import 'dart:html';
import 'dart:async';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/space.dart' ;
import 'package:gex_common_ui_elements/elements/button.dart' ;
import 'package:gex_common_ui_elements/elements/view_port.dart' ;


main() {
  initPolymer();
  
  ViewPort viewPort ;
  
  group("ScreenDescriptor", (){

    group('orientation: ', (){
      setUp((){
      });

      test('landscape', (){
        ViewPortDescriptor viewPort = new ViewPortDescriptor(100, 50);
        expect( viewPort.orientation  , equals(ScreenOrientation.LANDSCAPE)); 
      });
      
      test('portrait', (){
        ViewPortDescriptor viewPort = new ViewPortDescriptor(50, 100);
        expect( viewPort.orientation  , equals(ScreenOrientation.PORTRAIT)); 
      });
      
    });
    
    group('from window: ', (){
      
      test('landscape', (){
        WindowMock windowMock = new WindowMock();
        when(windowMock.innerHeight).thenReturn(100);
        when(windowMock.innerWidth).thenReturn(50);
        
        ViewPortDescriptor viewPort = new ViewPortDescriptor.fromWindow(windowMock) ;
        expect( viewPort.orientation  , equals(ScreenOrientation.LANDSCAPE)); 
      });
      
      test('portrait', (){
        WindowMock windowMock = new WindowMock();
        when(windowMock.innerHeight).thenReturn(50);
        when(windowMock.innerWidth).thenReturn(100);
        
        ViewPortDescriptor viewPort = new ViewPortDescriptor.fromWindow(windowMock) ;
        expect( viewPort.orientation  , equals(ScreenOrientation.PORTRAIT)); 
      });      
      
    });    
    
    
  });
  
  
 
  
  pollForDone(testCases);  
}

class WindowMock extends Mock implements Window{}

pollForDone(List tests) {
  if (tests.every((t)=> t.isComplete)) {
    window.postMessage('dart-main-done', window.location.href);
    return;
  }

  var wait = new Duration(milliseconds: 100);
  new Timer(wait, ()=> pollForDone(tests));
}

