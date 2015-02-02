library gex_common_ui_elements.test_routing;

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
  
  group("Routing", (){

    setUp((){
      if (application==null){
        application = querySelector("#application");
        application.moveTo( new Position(0,0, 1000,500, 100)  ) ;
        application.setApplicationEventBus(applicationEventBus);
      }
    });
    
    group('load page from url', (){

      test('simple page', (){
        new Timer(new Duration(milliseconds:1000), expectAsync( (){assert(application.currentPageModel.name == "page2");} ) );
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
