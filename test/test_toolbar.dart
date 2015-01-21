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
      
      
      List<ButtonModel> toolbarButtons = new List<ButtonModel> ();
      toolbarButtons.add(new ButtonModel(label: "one", image:new Image(mainImageUrl:  "images/button/dart-logo.png"), action: action1.targetAction)) ;
      toolbarButtons.add(new ButtonModel(label: "two", image:new Image(mainImageUrl:"images/button/dart-logo.png"), action: action2.targetAction)) ;
      toolbarButtons.add(new ButtonModel(label: "three", image:new Image(mainImageUrl:"images/button/dart-logo.png"), action: action3.targetAction)) ;
      
      toolbarEst = new Toolbar.fromModel( new ToolbarModel(buttons:toolbarButtons, orientation: Orientation.est   )) ;
      toolbarEst.moveTo(toolbarPostion);
      absoluteSpace.append(toolbarEst);
      
      toolbarWest = new Toolbar.fromModel( new ToolbarModel(buttons:toolbarButtons, orientation: Orientation.west   )) ;
      toolbarWest.moveTo(toolbarPostion);
      absoluteSpace.append(toolbarWest);
      
      toolbarNorth = new Toolbar.fromModel( new ToolbarModel(buttons:toolbarButtons, orientation: Orientation.north   )) ;
      toolbarNorth.moveTo(toolbarPostion);
      absoluteSpace.append(toolbarNorth);
      
      toolbarSouth = new Toolbar.fromModel( new ToolbarModel(buttons:toolbarButtons, orientation: Orientation.south   )) ;
      toolbarSouth.moveTo(toolbarPostion);
      absoluteSpace.append(toolbarSouth);
    });

    tearDown((){
      absoluteSpace.children.clear();
    });

    group('buttons: ', (){

      test('actions', (){
        
        List<ButtonModel> buttons = toolbarEst.model.buttons ;
        
        expect( buttons.length , equals(3));
        expect( buttons[0].action  , equals(action1.targetAction));
        expect( buttons[1].action  , equals(action2.targetAction));
        expect( buttons[2].action  , equals(action3.targetAction));

      });  
      
      test('orientation est', (){
        
        List<Position> buttons = toolbarEst.buttonPositions ;
            
        expect( buttons.length , equals(3));
        expect( buttons[0].height  , equals(toolbarPostion.height));
        expect( buttons[1].height  , equals(toolbarPostion.height));
        expect( buttons[2].height  , equals(toolbarPostion.height));
        expect( buttons[0].width  , equals(toolbarPostion.width));
        expect( buttons[1].width  , equals(toolbarPostion.width));
        expect( buttons[2].width  , equals(toolbarPostion.width));
        expect( buttons[0].top  , equals(0));
        expect( buttons[1].top  , equals(0));
        expect( buttons[2].top  , equals(0));
        expect( buttons[0].left  , equals(0));
        expect( buttons[1].left  , equals(toolbarPostion.width ));
        expect( buttons[2].left  , equals(2*toolbarPostion.width));        
        
      });       
      
      test('orientation west', (){
        
        List<Position> buttons = toolbarWest.buttonPositions ;
        
        expect( buttons.length , equals(3));
        expect( buttons[0].height  , equals(toolbarPostion.height));
        expect( buttons[1].height  , equals(toolbarPostion.height));
        expect( buttons[2].height  , equals(toolbarPostion.height));
        expect( buttons[0].width  , equals(toolbarPostion.width));
        expect( buttons[1].width  , equals(toolbarPostion.width));
        expect( buttons[2].width  , equals(toolbarPostion.width));
        expect( buttons[0].top  , equals(0));
        expect( buttons[1].top  , equals(0));
        expect( buttons[2].top  , equals(0));
        expect( buttons[0].left  , equals( 2*toolbarPostion.width));
        expect( buttons[1].left  , equals( toolbarPostion.width ));
        expect( buttons[2].left  , equals(0));        
        
      });       
      
      test('orientation north', (){
        
        List<Position> buttons = toolbarNorth.buttonPositions ;
        
        expect( buttons.length , equals(3));
        expect( buttons[0].height  , equals(toolbarPostion.height));
        expect( buttons[1].height  , equals(toolbarPostion.height));
        expect( buttons[2].height  , equals(toolbarPostion.height));
        expect( buttons[0].width  , equals(toolbarPostion.width));
        expect( buttons[1].width  , equals(toolbarPostion.width));
        expect( buttons[2].width  , equals(toolbarPostion.width));
        expect( buttons[0].top  , equals( 2*toolbarPostion.height));
        expect( buttons[1].top  , equals( toolbarPostion.height));
        expect( buttons[2].top  , equals(0));
        expect( buttons[0].left  , equals(0));
        expect( buttons[1].left  , equals(0));
        expect( buttons[2].left  , equals(0));        
        
      });      
      
      test('orientation south', (){
        
        List<Position> buttons = toolbarSouth.buttonPositions ;
        
        expect( buttons.length , equals(3));
        expect( buttons[0].height  , equals(toolbarPostion.height));
        expect( buttons[1].height  , equals(toolbarPostion.height));
        expect( buttons[2].height  , equals(toolbarPostion.height));
        expect( buttons[0].width  , equals(toolbarPostion.width));
        expect( buttons[1].width  , equals(toolbarPostion.width));
        expect( buttons[2].width  , equals(toolbarPostion.width));
        expect( buttons[0].top  , equals(0));
        expect( buttons[1].top  , equals(toolbarPostion.height));
        expect( buttons[2].top  , equals( 2*toolbarPostion.height));
        expect( buttons[0].left  , equals(0));
        expect( buttons[1].left  , equals(0));
        expect( buttons[2].left  , equals(0));        
        
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
