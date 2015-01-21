library gex_common_ui_elements.show_room_toolbar;


import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/space.dart' ;
import 'package:gex_common_ui_elements/elements/toolbar.dart' ;

@CustomTag('gex-show-room-toolbar')
class ShowRoomToolbar extends Positionable with Showable {
  
  final Logger log = new Logger('ShowRoomToolbar');
  
  Color mainColor = Color.GREEN_07CC00;
  
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
      estToolbar.moveTo(new Position(0, 0, 160, 160, 102) ) ;
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
    buttonModels.add( new ButtonModel(label: "Action 1",action:action1,image:new Image(mainImageUrl:"/images/button/create1.png"))  );
    buttonModels.add( new ButtonModel(label: "Action 2",action:action2,image:new Image(mainImageUrl:"/images/button/factory6.png") )  );
    buttonModels.add( new ButtonModel(label: "Action 3",action:action3,image:new Image(mainImageUrl:"/images/button/login.png") )  );
    buttonModels.add( new ButtonModel(label: "Action 4",action:action4,image:new Image(mainImageUrl:"/images/button/logout.png") )  );    
    ToolbarModel toolbarModel = new ToolbarModel(buttons:buttonModels, color: mainColor );
    
    estToolbar.init( toolbarModel.clone()..orientation = Orientation.est ..colorUsage = ColorUsage.GRADATION   ) ;
    southToolbar.init( toolbarModel.clone()..orientation = Orientation.south ..colorUsage = ColorUsage.ALTERNATE ) ;
    westToolbar.init( toolbarModel.clone()..orientation = Orientation.west ..colorUsage = ColorUsage.ALTERNATE_WITH_LIGHT ) ; 
    northToolbar.init( toolbarModel.clone()..orientation = Orientation.north ..colorUsage = ColorUsage.UNIFORM) ; 
  }
  

  action1(Parameters params){
    toolbarSpace.style.backgroundColor =  mainColor.veryStrongColor ;
  }
  action2(Parameters params){
    toolbarSpace.style.backgroundColor = mainColor.strongColor ;
  }
  action3(Parameters params){
    toolbarSpace.style.backgroundColor =mainColor.lightColor ;
  }
  action4(Parameters params){
    toolbarSpace.style.backgroundColor =mainColor.veryLightColor ;
  }
  
  
}
