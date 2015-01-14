part of gex_common_ui_elements;


class ButtonModel{
  
  Color _color  ;
  String _image;
  String _label ;
  LaunchAction _action ;
  
  ButtonModel({Color color,String image,String label, LaunchAction action} ){
    if(color == null){
      _color = Color.BLUE_0082C8;
    }else{
      _color = color ;
    }
    _image = image ;
    _label = label ;
    _action = action ;
  }

  Color get color => _color.clone();
  String get image => _image;
  String get label => _label;
  LaunchAction get action => _action ;
  ActionDescriptor get actionDescriptor => new ActionDescriptor(name: _label,launchAction: _action);
  bool get hasImage => _image != null && _image.isNotEmpty ;
  bool get hasLabel => _label != null && _label.isNotEmpty ;
  
  ButtonModel clone(){
    return new ButtonModel(color:color.clone(),image:_image,label:_label,action:_action);
  }
  
}

class ToolbarModel{
   
  List<ButtonModel> _buttons ;
  Position _mainButtonPosition ;
  Orientation _orientation ;
  
  ToolbarModel({List<ButtonModel> buttons,Position mainButtonPosition,Orientation orientation} ){
    if (buttons == null){
      _buttons = new List<ButtonModel>();
    }else{
      _buttons = buttons ;
    }
    if (mainButtonPosition== null){
      _mainButtonPosition = new Position.empty();
    }else{
      _mainButtonPosition = mainButtonPosition;
    }
    _orientation =orientation;
  }
  
   set mainButtonPosition(Position position){
     _mainButtonPosition = position;
   }
  
  Position get mainButtonPosition => _mainButtonPosition.clone(); 
  Orientation get orientation =>  _orientation ;
  set orientation(Orientation value) {
    _orientation = value;
  }
  
 
  num get nbActions =>  _buttons.length;
  
  List<ButtonModel> get buttons {
    List<ButtonModel> buttons = new List<ButtonModel>();
    _buttons.forEach((b)=>buttons.add(b));
    return buttons ; 
  }
  
  ToolbarModel clone(){
    return new ToolbarModel(buttons:buttons,mainButtonPosition:mainButtonPosition,orientation:orientation);
  }
  
}

typedef void ViewPortChangeCallBack(ViewPortChangeEvent event);

class ViewPortChangeEvent{
  ViewPortModel _viewPortModel ;
  
  ViewPortChangeEvent(this._viewPortModel);
  
  ViewPortModel get viewPortModel => _viewPortModel.clone();
  
  ViewPortChangeEvent clone(){
    return new ViewPortChangeEvent(this._viewPortModel.clone());
  }
  
}

class ViewPortModel {
  
  num _windowHeight ;
  num _windowWidth ;

  ViewPortModel.fromWindow(Window window){
    _windowHeight = window.innerHeight ;
    _windowWidth = window.innerWidth ;
  }
  ViewPortModel(this._windowHeight, this._windowWidth);
  
  num get windowHeight => _windowHeight ;
  num get windowWidth => _windowWidth ;
  ScreenOrientation get orientation => _windowHeight < _windowWidth ? ScreenOrientation.LANDSCAPE : ScreenOrientation.PORTRAIT;
      
  ViewPortModel clone(){
    return new ViewPortModel(this._windowHeight, this._windowWidth);
  }
  
  @override
  String toString() => "ViewPortModel: windowHeight: ${_windowHeight}, windowWidth: ${_windowWidth}";
  
  @override
  int get hashCode {
     int result = 17;
     result = 37 * result + _windowHeight.hashCode;
     result = 37 * result + _windowWidth.hashCode;
     return result;
  }

  @override
  bool operator ==(other) {
     if (other is! ViewPortModel) return false;
     ViewPortModel viewPort = other;
     return (viewPort.hashCode == this.hashCode);
   }
  
}

class LayoutModel{
  
  Color _color  ;
  ToolbarModel _toolbarModel ;
  
  LayoutModel({Color color, ToolbarModel toolbarModel }){
    if(color == null){
      _color = Color.GREY_858585;
    }else{
      _color = color ;
    } 
    if(toolbarModel == null){
      _toolbarModel = new ToolbarModel();
    }else{
      _toolbarModel = toolbarModel ;
    }     
  }
  
  Color get color => _color.clone();
  ToolbarModel get toolbarModel => _toolbarModel;
  
  num marginXInPercent(Position position){
    if ( position.width < 800  ){
      return 0;
    }
    if ( position.width > 2000   ){
      return 2000 /  position.width;
    }
    return 0.3;
  }
  
}

