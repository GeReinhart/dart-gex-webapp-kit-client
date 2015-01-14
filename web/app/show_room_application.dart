library gex_common_ui_elements.show_room_app;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/application.dart' ;

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
    
    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add( new ButtonModel(label: "Page 1", image: "images/button/list23.png",action:(p)=>showPage(pageIndex: 0) )  );
    buttonModels.add( new ButtonModel(label: "Page 2", image: "images/button/user58.png",action:(p)=>showPage(pageIndex: 1) )  );
    ToolbarModel toolbarModel = new ToolbarModel(buttons:buttonModels);
    addToolbar(toolbarModel);
    
    pages[0].show();
  }
  
}
