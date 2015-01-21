library gex_common_ui_elements.show_room_app.page_one;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/layout.dart' ;
import 'package:gex_common_ui_elements/elements/page.dart' ;

@CustomTag('gex-page-one')
class PageOne extends Page with Showable {
  
  final Logger log = new Logger('PageOne');
  
  Color mainColor = Color.GREY_858585.lightColorAsColor;
  
  Layout layout ;
  
  PageOne.created() : super.created() ;
  
  
  ready() {
    super.ready();
    _setAttributes();
  }
  
  void _setAttributes(){
     layout = $["layout"] as Layout ;
     
     List<ButtonModel> buttonModels = new List<ButtonModel>();
     buttonModels.add( new ButtonModel(label: "Action 1",action:action1,image:new Image(mainImageUrl:"/images/button/create1.png") )  );
     buttonModels.add( new ButtonModel(label: "Action 2",action:action2,image:new Image(mainImageUrl:"/images/button/factory6.png") )  );
     buttonModels.add( new ButtonModel(label: "Action 3",action:action3,image:new Image(mainImageUrl:  "/images/button/save29.png",mainImageUrl2:"/images/button/map32.png" ) )  );
     ToolbarModel toolbarModel = new ToolbarModel(buttons:buttonModels, color: mainColor, orientation: Orientation.est,colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );  
     
     LayoutModel layoutModel = new LayoutModel(toolbarModel: toolbarModel,color: mainColor);
     PageModel model = new PageModel(layoutModel:layoutModel );
     this.init(model) ;
     
   }
  
  action1(Parameters params){
    layout.style.backgroundColor =mainColor.strongColor ;
  }
  action2(Parameters params){
    layout.style.backgroundColor =mainColor.mainColor ;
  }
  action3(Parameters params){
    layout.style.backgroundColor =mainColor.lightColor ;
  }
  
}