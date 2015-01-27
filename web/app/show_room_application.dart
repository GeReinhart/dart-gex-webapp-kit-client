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
  ApplicationEventBus applicationEventBus  = new ApplicationEventBus() ;
  
  
  ShowRoomApplication.created() : super.created(){
  } 
  
  @override
  void ready() {
    super.ready();
    _setAttributes();
    this.setApplicationEventBus(applicationEventBus);
    fireApplicationEvent(new PageCallEvent( sender: this,  pageName:'PageOne' )  );
  }
  
  void _setAttributes() {
    addPage( new Element.tag('gex-page-one') ) ;
    addPage( new Element.tag('gex-page-two') ) ;
    
    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add( new ButtonModel(label: "Page 1", image:new Image(mainImageUrl:"images/button/list23.png"),type: ButtonType.PAGE_LAUNCHER , targetPageKey: new PageKey(name: "PageOne")  )  );
    buttonModels.add( new ButtonModel(label: "Page 2", image:new Image(mainImageUrl: "images/button/user58.png"),type: ButtonType.PAGE_LAUNCHER , targetPageKey: new PageKey(name: "PageTwo")  )  );
    ToolbarModel toolbarModel = new ToolbarModel(buttons:buttonModels, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );
    addToolbar(toolbarModel);
    
    
    List<ButtonModel> bottomToolbar = new List<ButtonModel>();
    bottomToolbar.add( new ButtonModel(label: "Login", image:new Image(mainImageUrl: "images/button/login.png"))  );
    bottomToolbar.add( new ButtonModel(label: "Register", image:new Image(mainImageUrl: "images/button/create1.png"))  );
    bottomToolbar.add( new ButtonModel(label: "About", image:new Image(mainImageUrl: "images/button/info24.png") )  );
    ToolbarModel bottomToolbarModel = new ToolbarModel(buttons:bottomToolbar, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );
    addToolbar(bottomToolbarModel);    

  }
  
}
