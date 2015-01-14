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
        ViewPortModel viewPortDescriptor = new ViewPortModel(100, 50);
        expect( viewPortDescriptor.orientation  , equals(ScreenOrientation.PORTRAIT)); 
      });
      
      test('portrait', (){
        ViewPortModel viewPortDescriptor = new ViewPortModel(50, 100);
        expect( viewPortDescriptor.orientation  , equals(ScreenOrientation.LANDSCAPE)); 
      });
      
    });
    
    group('from window: ', (){
      
      test('landscape', (){
        WindowMock windowMock = new WindowMock();
        when(windowMock.innerHeight).thenReturn(100);
        when(windowMock.innerWidth).thenReturn(50);
        
        ViewPortModel viewPort = new ViewPortModel.fromWindow(windowMock) ;
        expect( viewPort.orientation  , equals(ScreenOrientation.PORTRAIT)); 
      });
      
      test('portrait', (){
        WindowMock windowMock = new WindowMock();
        when(windowMock.innerHeight).thenReturn(50);
        when(windowMock.innerWidth).thenReturn(100);
        
        ViewPortModel viewPortDescriptor = new ViewPortModel.fromWindow(windowMock) ;
        
        var wait = new Duration(milliseconds: 2000);
        new Timer(wait, (){
          expect( viewPortDescriptor.orientation  , equals(ScreenOrientation.LANDSCAPE)) ;
        });
        
      });      
      
    });    
    
    group('equals: ', (){
      
      test('== values', (){
        ViewPortModel viewPortDescriptor1 = new ViewPortModel(100, 200) ;
        ViewPortModel viewPortDescriptor2 = new ViewPortModel(100, 200) ;
        
        expect( viewPortDescriptor1  , equals(viewPortDescriptor2)); 
      });
      
      test('!= values', (){
        ViewPortModel viewPortDescriptor1 = new ViewPortModel(200, 200) ;
        ViewPortModel viewPortDescriptor2 = new ViewPortModel(100, 200) ;
        
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

