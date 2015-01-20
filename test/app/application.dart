library gex_common_ui_elements.test_app;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/application.dart' ;

@CustomTag('gex-test-application')
class TestApplication  extends Application{
  
  final Logger log = new Logger('TestApplication');
  
  Color mainColor = Color.GREEN_07CC00 ;
  
  TestApplication.created() : super.created(){
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
    buttonModels.add( new ButtonModel(label: "Page 1",action:(p)=>showPage(pageIndex: 0) )  );
    buttonModels.add( new ButtonModel(label: "Page 2",action:(p)=>showPage(pageIndex: 1) )  );
    ToolbarModel toolbarModel = new ToolbarModel(buttons:buttonModels, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );
    addToolbar(toolbarModel);
    
    
    buttonModels = new List<ButtonModel>();
    buttonModels.add( new ButtonModel(label: "Page 11",action:(p)=>showPage(pageIndex: 0) )  );
    buttonModels.add( new ButtonModel(label: "Page 12",action:(p)=>showPage(pageIndex: 1) )  );
    buttonModels.add( new ButtonModel(label: "Page 13",action:(p)=>showPage(pageIndex: 0) )  );
    toolbarModel = new ToolbarModel(buttons:buttonModels, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );
    addToolbar(toolbarModel);    

    buttonModels = new List<ButtonModel>();
    buttonModels.add( new ButtonModel(label: "Page 21",action:(p)=>showPage(pageIndex: 0) )  );
    buttonModels.add( new ButtonModel(label: "Page 22",action:(p)=>showPage(pageIndex: 1) )  );
    buttonModels.add( new ButtonModel(label: "Page 23",action:(p)=>showPage(pageIndex: 0) )  );
    toolbarModel = new ToolbarModel(buttons:buttonModels, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );
    addToolbar(toolbarModel);    
    
    buttonModels = new List<ButtonModel>();
    buttonModels.add( new ButtonModel(label: "Page 31",action:(p)=>showPage(pageIndex: 0) )  );
    buttonModels.add( new ButtonModel(label: "Page 32",action:(p)=>showPage(pageIndex: 1) )  );
    buttonModels.add( new ButtonModel(label: "Page 33",action:(p)=>showPage(pageIndex: 0) )  );
    toolbarModel = new ToolbarModel(buttons:buttonModels, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );
    addToolbar(toolbarModel);        
    
    
    pages[0].show();
  }
  
}
