library gex_common_ui_elements.show_room_app;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/application.dart' ;

@CustomTag('gex-show-room-application')
class ShowRoomApplication  extends Application{
  
  final Logger log = new Logger('ShowRoomApplication');
  
  Color mainColor = Color.GREEN_07CC00 ;
  
  ShowRoomApplication.created() : super.created(){
  } 
  
  @override
  void ready() {
    super.ready();
    _setAttributes();
  }
  
  void _setAttributes() {
    addPage( new Element.tag('gex-page-one') ) ;
    addPage( new Element.tag('gex-page-two') ) ;
    
    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add( new ButtonModel(label: "Page 1", image: "images/button/list23.png",action:(p)=>showPage(pageIndex: 0) )  );
    buttonModels.add( new ButtonModel(label: "Page 2", image: "images/button/user58.png",action:(p)=>showPage(pageIndex: 1) )  );
    ToolbarModel toolbarModel = new ToolbarModel(buttons:buttonModels, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );
    addToolbar(toolbarModel);
    
    
    List<ButtonModel> bottomToolbar = new List<ButtonModel>();
    bottomToolbar.add( new ButtonModel(label: "Login", image: "images/button/login.png",action:(p)=>showPage(pageIndex: 0) )  );
    bottomToolbar.add( new ButtonModel(label: "Register", image: "images/button/create1.png",action:(p)=>showPage(pageIndex: 1) )  );
    bottomToolbar.add( new ButtonModel(label: "About", image: "images/button/info24.png",action:(p)=>showPage(pageIndex: 0) )  );
    ToolbarModel bottomToolbarModel = new ToolbarModel(buttons:bottomToolbar, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );
    addToolbar(bottomToolbarModel);    

    pages[0].show();
  }
  
}
