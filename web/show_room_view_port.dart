library gex_common_ui_elements.show_room_view_port;


import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/view_port.dart' ;

@CustomTag('gex-show-room-view-port')
class ShowRoomViewPort extends Positionable with Showable {
  
  final Logger log = new Logger('ShowRoomViewPort');
  
  ViewPort viewPort ;
  
  ShowRoomViewPort.created() : super.created(){
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
    viewPort = $["viewPort"] as ViewPort ;
  }

  void _setUpEventsOnElements(){
  }

  void _initialPositionsForElements() {
    
  }
  

 
  
  
}
