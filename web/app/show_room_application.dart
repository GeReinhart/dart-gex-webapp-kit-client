library gex_common_ui_elements.show_room_app;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/application.dart' ;
import 'package:gex_common_ui_elements/elements/toolbar.dart' ;

@CustomTag('gex-show-room-application')
class ShowRoomApplication  extends Application{
  
  final Logger log = new Logger('ShowRoomApplication');
  
  ShowRoomApplication.created() : super.created(){
  } 
  
  @override
  void ready() {
    super.ready();
    _setAttributes();
  }
  
  void _setAttributes() {
    addPage( buildPage(new Element.tag('gex-page-one')) ) ;
    addPage( buildPage(new Element.tag('gex-page-two')) ) ;
    
    List<ActionDescriptor> actions = new List<ActionDescriptor>();
    actions.add(new ActionDescriptor("Page 1","",(_)=> showPage(pageIndex: 0) ));
    actions.add(new ActionDescriptor("Page 2","",(_)=> showPage(pageIndex: 1) ));
    addToolbar(actions,"#778899");
    
    pages[0].show();
  }
  
}
