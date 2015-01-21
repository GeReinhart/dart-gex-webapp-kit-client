library gex_common_ui_elements.show_room_layout;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/layout.dart' ;

@CustomTag('gex-show-room-layout')
class ShowRoomLayout extends Positionable with Showable {
  
  final Logger log = new Logger('ShowRoomLayout');
  
  Color mainColor = Color.GREY_858585.lightColorAsColor;
  
  Layout layout ;
  LayoutModel model ;
  DivElement content;
  
  ShowRoomLayout.created() : super.created(){
  }
  
  ready() {
    super.ready();
    _setAttributes();
  }
  
  
  @override
  void moveTo(Position position) {
      super.moveTo(position);
      layout.moveTo( new Position(0, 0, position.width, position.height, 100));
  }
    
  
  void _setAttributes(){
    layout = $["layout"] as Layout ;
    
    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add( new ButtonModel(label: "Action 1",action:action1,image:new Image(mainImageUrl:"/images/button/create1.png") )  );
    buttonModels.add( new ButtonModel(label: "Action 2",action:action2,image:new Image(mainImageUrl:"/images/button/factory6.png") )  );
    buttonModels.add( new ButtonModel(label: "Action 3",action:action3,image:new Image(mainImageUrl:"/images/button/login.png") )  );
    ToolbarModel toolbarModel = new ToolbarModel(buttons:buttonModels, color: mainColor, orientation: Orientation.est,colorUsage: ColorUsage.ALTERNATE );  
    
    model = new LayoutModel(toolbarModel: toolbarModel,color: mainColor);
    layout.init(model);
    content = this.shadowRoot.querySelector("#content") as DivElement ;
    
  }

  void viewPortChangeCallBack(ViewPortChangeEvent event){
    ViewPortModel viewPort = event.viewPortModel ;
    
  }
  
  void addContent() {
    DivElement newContent = content.clone(true) as DivElement ;
    newContent.style.display = "inline";
    layout.append(newContent);
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
