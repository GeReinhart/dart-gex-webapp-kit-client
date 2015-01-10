library gex_common_ui_elements.show_room_layout;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/space.dart' ;
import 'package:gex_common_ui_elements/elements/view_port.dart' ;
import 'package:gex_common_ui_elements/elements/layout.dart' ;

@CustomTag('gex-show-room-layout')
class ShowRoomLayout extends Positionable with Showable {
  
  final Logger log = new Logger('ShowRoomLayout');
  
  Layout layout ;
  DivElement content;
  List<ActionDescriptor> actions ;
  
  ShowRoomLayout.created() : super.created(){
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
      layout.moveTo( new Position(0, 0, position.width, position.height, 100));
  }
    
  
  void _setAttributes(){
    layout = $["layout"] as Layout ;
    content = this.shadowRoot.querySelector("#content") as DivElement ;
  }

  void _setUpEventsOnElements(){
  }

  void viewPortChangeCallBack(ViewPortChangeEvent event){
    ViewPortDescriptor viewPort = event.viewPortDescriptor ;
    
  }

  void _initialPositionsForElements() {
  }
  
  
  void addButtons() {
    if (actions == null){
      actions = new List<ActionDescriptor>();
      actions.add(new ActionDescriptor("Action 1","",action1));
      actions.add(new ActionDescriptor("Action 2","",action2));
      actions.add(new ActionDescriptor("Action 3","",action3));
      layout.actions = actions ;
    }
  }
  
  void addContent() {
    DivElement newContent = content.clone(true) as DivElement ;
    newContent.style.display = "inline";
    layout.append(newContent);
  }
  
  action1(Parameters params){
    layout.style.backgroundColor ="white" ;
  }
  action2(Parameters params){
    layout.style.backgroundColor ="#00D2B8" ;
  }
  action3(Parameters params){
    layout.style.backgroundColor ="#778899" ;
  }
}
