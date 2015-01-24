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
import 'app/page_one.dart' ;

main() {
  initPolymer();
  
  TestApplication application ;
  ApplicationEventBus applicationEventBus  = new ApplicationEventBus() ;
  
  group("Bus", (){

    setUp((){
      if (application==null){
        application = querySelector("#application");
        application.moveTo( new Position(0,0, 1000,500, 100)  ) ;
        application.setApplicationEventBus(applicationEventBus);
        applicationEventBus.fireApplicationEvent(  new ApplicationEvent(sender: applicationEventBus,  name: "event") ) ;
      }
    });
    
    group('events propagation from bus', (){

      test('to application', (){
        verify(application.dummyActionApplication.doSomething("event" )).called(1);
      });
      
      test('to main toolbars', (){
        verify(application.dummyActionToolBars.doSomething("event" )).called(2);
      });
    
      test('to main toolbars buttons', (){
        verify(application.dummyActionToolBarsButtons.doSomething("event" )).called(6);
      });

      test('to pages', (){
        verify(( application.pages[0] as PageOne ).dummyActionPages.doSomething("event" )).called(1);
        
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


class DummyAction{
  void doSomething(String eventName){
  }
}

class DummyActionMock extends Mock implements DummyAction{}
