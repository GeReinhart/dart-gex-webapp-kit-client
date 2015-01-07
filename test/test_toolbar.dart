library gex_common_ui_elements.test_extensible_button;

import 'package:unittest/unittest.dart';
import 'package:mockito/mockito.dart';
import 'dart:html';
import 'dart:async';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/space.dart' ;
import 'package:gex_common_ui_elements/elements/button.dart' ;
import 'package:gex_common_ui_elements/elements/toolbar.dart' ;

main() {
  initPolymer();

  Space absoluteSpace ;
  Toolbar toolbarEst ;
  Toolbar toolbarWest ;
  Toolbar toolbarNorth ;
  Toolbar toolbarSouth ;
  
  Position toolbarPostion = new Position(1000, 1000, 50, 40, 101);

  List<ActionDescriptor> toolbarAction ;
  TargetAction action1 = new TargetAction();
  TargetAction action2 = new TargetAction();
  TargetAction action3 = new TargetAction();
    
  
  group("Toolbar", (){
    setUp((){
      absoluteSpace = querySelector("#absoluteSpace");
      toolbarEst = querySelector("#toolbarEst");
      toolbarWest = querySelector("#toolbarWest");
      toolbarNorth = querySelector("#toolbarNorth");
      toolbarSouth = querySelector("#toolbarSouth");
      
      toolbarAction = new List<ActionDescriptor>();
      toolbarAction.add(new ActionDescriptor("one", "one",  action1.targetAction)) ;
      toolbarAction.add(new ActionDescriptor("two", "two",  action2.targetAction)) ;
      toolbarAction.add(new ActionDescriptor("three", "three",  action3.targetAction)) ;
      
      toolbarEst.init(Orientation.est,toolbarAction );
      toolbarEst.moveTo(toolbarPostion);
      toolbarWest.init(Orientation.west,toolbarAction );
      toolbarWest.moveTo(toolbarPostion);
      toolbarNorth.init(Orientation.north,toolbarAction );
      toolbarNorth.moveTo(toolbarPostion);
      toolbarSouth.init(Orientation.south,toolbarAction );    
      toolbarSouth.moveTo(toolbarPostion);
    });

    tearDown((){

    });

    group('buttons: ', (){

      test('actions', (){
        
        List<Button> buttons = toolbarEst.buttons ;
        
        expect( buttons.length , equals(3));
        expect( buttons[0].action.launchAction  , equals(action1.targetAction));
        expect( buttons[1].action.launchAction  , equals(action2.targetAction));
        expect( buttons[2].action.launchAction  , equals(action3.targetAction));

      });  
      
      test('orientation est', (){
        
        List<Button> buttons = toolbarEst.buttons ;
        
        expect( buttons.length , equals(3));
        expect( buttons[0].style.height  , equals("${toolbarPostion.height}px"));
        expect( buttons[1].style.height  , equals("${toolbarPostion.height}px"));
        expect( buttons[2].style.height  , equals("${toolbarPostion.height}px"));
        expect( buttons[0].style.width  , equals("${toolbarPostion.width}px"));
        expect( buttons[1].style.width  , equals("${toolbarPostion.width}px"));
        expect( buttons[2].style.width  , equals("${toolbarPostion.width}px"));
        expect( buttons[0].style.top  , equals("0px"));
        expect( buttons[1].style.top  , equals("0px"));
        expect( buttons[2].style.top  , equals("0px"));
        expect( buttons[0].style.left  , equals("${0}px"));
        expect( buttons[1].style.left  , equals("${toolbarPostion.width }px"));
        expect( buttons[2].style.left  , equals("${2*toolbarPostion.width}px"));        
        
      });       
      
      test('orientation west', (){
        
        List<Button> buttons = toolbarWest.buttons ;
        
        expect( buttons.length , equals(3));
        expect( buttons[0].style.height  , equals("${toolbarPostion.height}px"));
        expect( buttons[1].style.height  , equals("${toolbarPostion.height}px"));
        expect( buttons[2].style.height  , equals("${toolbarPostion.height}px"));
        expect( buttons[0].style.width  , equals("${toolbarPostion.width}px"));
        expect( buttons[1].style.width  , equals("${toolbarPostion.width}px"));
        expect( buttons[2].style.width  , equals("${toolbarPostion.width}px"));
        expect( buttons[0].style.top  , equals("0px"));
        expect( buttons[1].style.top  , equals("0px"));
        expect( buttons[2].style.top  , equals("0px"));
        expect( buttons[0].style.left  , equals("${ 2*toolbarPostion.width}px"));
        expect( buttons[1].style.left  , equals("${ toolbarPostion.width }px"));
        expect( buttons[2].style.left  , equals("0px"));        
        
      });       
      
      test('orientation north', (){
        
        List<Button> buttons = toolbarNorth.buttons ;
        
        expect( buttons.length , equals(3));
        expect( buttons[0].style.height  , equals("${toolbarPostion.height}px"));
        expect( buttons[1].style.height  , equals("${toolbarPostion.height}px"));
        expect( buttons[2].style.height  , equals("${toolbarPostion.height}px"));
        expect( buttons[0].style.width  , equals("${toolbarPostion.width}px"));
        expect( buttons[1].style.width  , equals("${toolbarPostion.width}px"));
        expect( buttons[2].style.width  , equals("${toolbarPostion.width}px"));
        expect( buttons[0].style.top  , equals("${ 2*toolbarPostion.height}px"));
        expect( buttons[1].style.top  , equals("${ toolbarPostion.height}px"));
        expect( buttons[2].style.top  , equals("0px"));
        expect( buttons[0].style.left  , equals("0px"));
        expect( buttons[1].style.left  , equals("0px"));
        expect( buttons[2].style.left  , equals("0px"));        
        
      });      
      
      test('orientation south', (){
        
        List<Button> buttons = toolbarSouth.buttons ;
        
        expect( buttons.length , equals(3));
        expect( buttons[0].style.height  , equals("${toolbarPostion.height}px"));
        expect( buttons[1].style.height  , equals("${toolbarPostion.height}px"));
        expect( buttons[2].style.height  , equals("${toolbarPostion.height}px"));
        expect( buttons[0].style.width  , equals("${toolbarPostion.width}px"));
        expect( buttons[1].style.width  , equals("${toolbarPostion.width}px"));
        expect( buttons[2].style.width  , equals("${toolbarPostion.width}px"));
        expect( buttons[0].style.top  , equals("0px"));
        expect( buttons[1].style.top  , equals("${toolbarPostion.height}px"));
        expect( buttons[2].style.top  , equals("${ 2*toolbarPostion.height}px"));
        expect( buttons[0].style.left  , equals("0px"));
        expect( buttons[1].style.left  , equals("0px"));
        expect( buttons[2].style.left  , equals("0px"));        
        
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
