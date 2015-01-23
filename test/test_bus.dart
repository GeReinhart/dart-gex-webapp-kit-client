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
import 'package:gex_common_ui_elements/elements/application.dart' ;
import 'package:gex_common_ui_elements/elements/page.dart' ;
import 'app/application.dart' ;

main() {
  initPolymer();
  
  TestApplication application ;
  num width = 1000;
  num height = 500;
  
  
  group("Bus of events", (){

    setUp((){
      application = querySelector("#application");
      application.moveTo( new Position(0,0, width,height, 100)  ) ;
      
    });
    
    group('events propagation from bus events ', (){

      test('to main toolbars', (){
        
        application.fireApplicationEvent( new ApplicationEvent(name: "event")) ;    
        
      });
      
      test('to main toolbars buttons', (){
        
        
      });

      test('to pages', (){
        
        
      }); 
      
      test('to pages toolbar', (){
        
        
      });      

      test('to pages toolbar buttons', (){
        
        
      });
      
      test('to pages internals buttons', (){
        
        
      });      
      
    });
      
    
  });
  
  
 
  
  pollForDone(testCases);  
}



pollForDone(List tests) {
  if (tests.every((t)=> t.isComplete)) {
    window.postMessage('dart-main-done', window.location.href);
    return;
  }

  var wait = new Duration(milliseconds: 100);
  new Timer(wait, ()=> pollForDone(tests));
}

