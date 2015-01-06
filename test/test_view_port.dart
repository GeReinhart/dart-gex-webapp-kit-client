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
  
  
  
  group("ViewPortDescriptor", (){

    group('orientation: ', (){
      setUp((){
      });

      test('landscape', (){
        ViewPortDescriptor viewPortDescriptor = new ViewPortDescriptor(100, 50);
        expect( viewPortDescriptor.orientation  , equals(ScreenOrientation.LANDSCAPE)); 
      });
      
      test('portrait', (){
        ViewPortDescriptor viewPortDescriptor = new ViewPortDescriptor(50, 100);
        expect( viewPortDescriptor.orientation  , equals(ScreenOrientation.PORTRAIT)); 
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
        
        ViewPortDescriptor viewPortDescriptor = new ViewPortDescriptor.fromWindow(windowMock) ;
        
        var wait = new Duration(milliseconds: 2000);
        new Timer(wait, (){
          expect( viewPortDescriptor.orientation  , equals(ScreenOrientation.PORTRAIT)) ;
        });
        
      });      
      
    });    
    
    group('equals: ', (){
      
      test('== values', (){
        ViewPortDescriptor viewPortDescriptor1 = new ViewPortDescriptor(100, 200) ;
        ViewPortDescriptor viewPortDescriptor2 = new ViewPortDescriptor(100, 200) ;
        
        expect( viewPortDescriptor1  , equals(viewPortDescriptor2)); 
      });
      
      test('!= values', (){
        ViewPortDescriptor viewPortDescriptor1 = new ViewPortDescriptor(200, 200) ;
        ViewPortDescriptor viewPortDescriptor2 = new ViewPortDescriptor(100, 200) ;
        
        expect( viewPortDescriptor1  , isNot( equals(viewPortDescriptor2) ) ); 
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

