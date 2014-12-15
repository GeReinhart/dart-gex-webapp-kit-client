library gex_common_ui_elements.test_extensible_button;

import 'package:unittest/unittest.dart';
import 'dart:html';
import 'dart:async';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;



main() {
  initPolymer();

  AbsoluteSpace absoluteSpace ;
  ExtensibleButton smallButton ;
  ExtensibleButton largeButton ;
    
  
  group("ExtensibleButton tests", (){
    setUp((){
      absoluteSpace = querySelector("#absoluteSpace");
      smallButton = querySelector("#smallButton");
      largeButton = querySelector("#largeButton");
      
    
            
    });

    tearDown((){

    });

    test('has a shadowRoot', (){
      expect( absoluteSpace.shadowRoot, isNotNull );
      expect( smallButton.shadowRoot, isNotNull );
      expect( largeButton.shadowRoot, isNotNull );
    });


    group('test visibility of the text', (){
      setUp((){
        smallButton.moveTo( new SquarePosition(200, 100, 50, 50, 101));
        largeButton.moveTo( new SquarePosition(300, 100, 200, 200, 101));
      });

      test('small button shouldn''t show the text', (){
        expect( smallButton.isButtonLabelVisible  , isFalse);
      });

      test('large button should show the text', (){
        expect( largeButton.isButtonLabelVisible  , isTrue); 
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
