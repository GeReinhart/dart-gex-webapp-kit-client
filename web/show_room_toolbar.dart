library gex_common_ui_elements.show_room_toolbar;


import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/space.dart' ;
import 'package:gex_common_ui_elements/elements/toolbar.dart' ;

@CustomTag('gex-show-room-toolbar')
class ShowRoomToolbar extends Positionable with Showable {
  
  final Logger log = new Logger('ShowRoomToolbar');
  
  Space toolbarSpace ;
  Toolbar estToolbar;
  Toolbar southToolbar;
  Toolbar westToolbar;
  Toolbar northToolbar;
  
  ShowRoomToolbar.created() : super.created(){
  }
  
  ready() {
    super.ready();
    _setAttributes();
    _setUpEventsOnElements();
    _initialPositionsForElements();
  }
  
  @override
  void moveTo(Position position) {
      super.moveTo(position);
      estToolbar.moveTo(new Position(0, 0, 100, 160, 102) ) ;
      southToolbar.moveTo(new Position( position.width - 100   , 0, 100, 30, 102) ) ;
      westToolbar.moveTo(new Position( position.width - 100 , position.height - 50 , 100, 50, 102) ) ; 
      northToolbar.moveTo(new Position( 0 , position.height - 50 , 100, 50, 103) ) ;
  }
    
  
  void _setAttributes(){
    toolbarSpace = $["toolbarSpace"] as Space ;
    estToolbar = $["estToolbar"] as Toolbar ;
    southToolbar = $["southToolbar"] as Toolbar ;    
    westToolbar = $["westToolbar"] as Toolbar ;
    northToolbar = $["northToolbar"] as Toolbar ;     
  }

  void _setUpEventsOnElements(){
  }

  void _initialPositionsForElements() {
    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add( new ButtonModel(label: "Action 1",action:action1,image:"/images/button/dart-logo.png" )  );
    buttonModels.add( new ButtonModel(label: "Action 2",action:action2 )  );
    buttonModels.add( new ButtonModel(label: "Action 3",action:action3 )  );
    ToolbarModel toolbarModel = new ToolbarModel(buttons:buttonModels );
    
    estToolbar.init( toolbarModel.clone()..orientation = Orientation.est ) ;
    southToolbar.init( toolbarModel.clone()..orientation = Orientation.south ) ;
    westToolbar.init( toolbarModel.clone()..orientation = Orientation.west ) ; 
    northToolbar.init( toolbarModel.clone()..orientation = Orientation.north) ; 
  }
  

  action1(Parameters params){
    toolbarSpace.style.backgroundColor ="white" ;
  }
  action2(Parameters params){
    toolbarSpace.style.backgroundColor ="#00D2B8" ;
  }
  action3(Parameters params){
    toolbarSpace.style.backgroundColor ="#778899" ;
  }
  action4(Parameters params){
    toolbarSpace.style.backgroundColor ="#0082C8" ;
  }
  
  
}
