library gex_common_ui_elements.test_extensible_button;

import 'package:unittest/unittest.dart';
import 'package:mockito/mockito.dart';
import 'dart:html';
import 'dart:async';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/absolute_space.dart' ;
import 'package:gex_common_ui_elements/elements/extensible_button.dart' ;


main() {
  initPolymer();

  AbsoluteSpace absoluteSpace ;
  
  ExtensibleButton smallButton ;
  ExtensibleButton largeButton ;
  ExtensibleButton noImageButton ;    
  
  group("ExtensibleButton", (){
    setUp((){
      absoluteSpace = querySelector("#absoluteSpace");
      smallButton = querySelector("#smallButton");
      largeButton = querySelector("#largeButton");
      noImageButton = querySelector("#noImageButton");
            
    });

    tearDown((){

    });

    group('text: ', (){
      setUp((){
        smallButton.moveTo( new Position(200, 100, 50, 50, 101));
        largeButton.moveTo( new Position(300, 100, 200, 200, 101));
      });

      test('small button shouldn''t show the text', (){
        expect( smallButton.isButtonLabelVisible  , isFalse);
      });

      test('large button should show the text', (){
        expect( largeButton.isButtonLabelVisible  , isTrue); 
      });
      
    });

    group('image: ', (){
      setUp((){
        smallButton.moveTo( new Position(200, 100, 50, 50, 100));
        largeButton.moveTo( new Position(300, 100, 250, 150, 100));
        noImageButton.moveTo( new Position(600, 100, 200, 200, 100));
      });

      test('image should be visible', (){
        expect( smallButton.isImageVisible  , isTrue);
        expect( noImageButton.isImageVisible  , isFalse);
      });

      test('image should be center and proportial to the size of the button', (){
        
        ImageElement smallImageElement = smallButton.imageElement ;
        ImageElement largeImageElement = largeButton.imageElement ;
        Position smallButtonPosition = smallButton.position ;
        Position largeButtonPosition = largeButton.position ;
        
        expect( smallImageElement.src  , endsWith("/images/button/dart-logo.png"));
        expect( extractInt(smallImageElement.style.width)  , lessThan(smallButtonPosition.width * .80));
        expect( extractInt(smallImageElement.style.height)  , lessThan(smallButtonPosition.height * .80));
        expect(smallImageElement.style.height  , equals(smallImageElement.style.width));
        expect( extractInt(smallImageElement.style.top)  , greaterThan(smallButtonPosition.height * .05));
        expect( extractInt(smallImageElement.style.left)  , greaterThan(smallButtonPosition.width * .05));
        
        expect( extractInt(largeImageElement.style.width)  , lessThan(largeButtonPosition.width * .80));
        expect( extractInt(largeImageElement.style.height)  , lessThan(largeButtonPosition.height * .80));
        expect(largeImageElement.style.height  , equals(largeImageElement.style.width));
        expect( extractInt(largeImageElement.style.top)  , greaterThan(largeButtonPosition.height * .05));
        expect( extractInt(largeImageElement.style.left)  , greaterThan(largeButtonPosition.width * .25));
        
      });
      
      test('zIndex', (){
        expect( smallButton.style.zIndex  , equals("${smallButton.position.zIndex}"));
      });      
      
    });

    group('action: ', (){
      
      ActionDescriptor action = new ActionDescriptor();
      TargetAction targetAction = new TargetAction();
      action.launchAction = targetAction.targetAction;
      
      setUp((){
        smallButton.moveTo( new Position(200, 100, 50, 50, 101));
        smallButton.targetAction( action ) ;        
        
      });

      test('click launch the action', (){
        smallButton.click();
        verify( targetAction.mock.targetAction(null)).called(1);
      });

    });
    
  });

  pollForDone(testCases);
}

class TargetAction{
  TargetActionMock mock = new TargetActionMock();
  void targetAction(Parameters params){
    mock.targetAction(params);
  }
}

class TargetActionMock extends Mock implements TargetAction{}

num extractInt(String sizeInPx){
  if (sizeInPx.isEmpty || !sizeInPx.endsWith("px")){
    return 0;
  }
  return num.parse( sizeInPx.substring(0, sizeInPx.length -2));
}

pollForDone(List tests) {
  if (tests.every((t)=> t.isComplete)) {
    window.postMessage('dart-main-done', window.location.href);
    return;
  }

  var wait = new Duration(milliseconds: 100);
  new Timer(wait, ()=> pollForDone(tests));
}
