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
  }
  
  @override
  void moveTo(Position position) {
      super.moveTo(position);
      _initialPositionsForElements();
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
    
    List<ActionDescriptor> actions = new List<ActionDescriptor>();
    actions.add(new ActionDescriptor("Action 1","",action1)..image ="/images/button/dart-logo.png");
    actions.add(new ActionDescriptor("Action 2","",action2));
    actions.add(new ActionDescriptor("Action 3","",action3));
    actions.add(new ActionDescriptor("Action 4","",action4));
    estToolbar.init(new Position(0, 0, 100, 160, 102), Orientation.est,actions ) ;
    southToolbar.init(new Position( position.width - 100   , 0, 100, 30, 102), Orientation.south,actions ) ;
    westToolbar.init(new Position( position.width - 100 , position.height - 50 , 100, 50, 102), Orientation.west,actions ) ; 
    northToolbar.init(new Position( 0 , position.height - 50 , 100, 50, 103), Orientation.north,actions ) ; 
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
