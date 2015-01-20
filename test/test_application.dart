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
  
  group("Application", (){

    setUp((){
      application = querySelector("#application");
      
    });
    
    group('toolbars: ', (){
      setUp((){
      });

      test('landscape orientation', (){
        num width = 1000;
        num height = 500;
        
        application.moveTo( new Position(0,0, width,height, 100)  ) ;
        List<ToolbarModel> toolbars = application.toolbarModels ;
        expect( toolbars.length  , equals(4));
        expect( toolbars[0].orientation  , equals(Orientation.south));
        expect( toolbars[0].mainButtonPosition.left  , equals(0));
        expect( toolbars[0].mainButtonPosition.top  , equals(0));
        
        expect( toolbars[1].orientation  , equals(Orientation.north));
        expect( toolbars[1].mainButtonPosition.left , equals(width -  toolbars[0].mainButtonPosition.width ));
        expect( toolbars[1].mainButtonPosition.top  , equals(height - toolbars[0].mainButtonPosition.height));        
        
        expect( toolbars[2].orientation  , equals(Orientation.west));
        expect( toolbars[2].mainButtonPosition.left , equals(width -  toolbars[0].mainButtonPosition.width ));
        expect( toolbars[2].mainButtonPosition.top  , equals(0));         
        
        expect( toolbars[3].orientation  , equals(Orientation.est));     
        expect( toolbars[3].mainButtonPosition.left , equals(0 ));
        expect( toolbars[3].mainButtonPosition.top  , equals(height - toolbars[0].mainButtonPosition.height));        
        
      });
      
      test('portrait orientation', (){
        num width = 500;
        num height = 1000;
        
        application.moveTo( new Position(0,0, width,height, 100)  ) ;
        List<ToolbarModel> toolbars = application.toolbarModels ;
        expect( toolbars.length  , equals(4));
        expect( toolbars[0].orientation  , equals(Orientation.est));
        expect( toolbars[0].mainButtonPosition.left  , equals(0));
        expect( toolbars[0].mainButtonPosition.top  , equals(0));
        
        expect( toolbars[1].orientation  , equals(Orientation.west));
        expect( toolbars[1].mainButtonPosition.left , equals(width -  toolbars[0].mainButtonPosition.width ));
        expect( toolbars[1].mainButtonPosition.top  , equals(height - toolbars[0].mainButtonPosition.height));        
        
        expect( toolbars[2].orientation  , equals(Orientation.south));
        expect( toolbars[2].mainButtonPosition.left , equals(width -  toolbars[0].mainButtonPosition.width ));
        expect( toolbars[2].mainButtonPosition.top  , equals(0));         
        
        expect( toolbars[3].orientation  , equals(Orientation.north));     
        expect( toolbars[3].mainButtonPosition.left , equals(0 ));
        expect( toolbars[3].mainButtonPosition.top  , equals(height - toolbars[0].mainButtonPosition.height));        
        
      }); 
      
      test('landscape size', (){
        num width = 1000;
        num height = 500;
        num size = width>height?height*0.20:width*0.20;
        
        application.moveTo( new Position(0,0, width,height, 100)  ) ;
        application.toolbarModels.forEach((t){
          expect( t.mainButtonPosition.width  , equals(size));
          expect( t.mainButtonPosition.height  , equals(size));
        } );
      });      
      
      test('portrait size', (){
        num width = 500;
        num height = 1000;
        num size = width>height?height*0.20:width*0.20;
        
        application.moveTo( new Position(0,0, width,height, 100)  ) ;
        application.toolbarModels.forEach((t){
          expect( t.mainButtonPosition.width  , equals(size));
          expect( t.mainButtonPosition.height  , equals(size));
        } );      
      
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

