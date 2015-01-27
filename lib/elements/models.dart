part of gex_common_ui_elements;


enum ButtonStatus {
  NORMAL,HIGHLIGHTED 
}

enum ButtonType {
  PAGE_LAUNCHER,CUSTOM 
}


class ButtonModel extends Object with ApplicationEventCallBackHolder{
  
  Color _color  ;
  Image _image;
  String _label ;
  ButtonStatus _status =  ButtonStatus.NORMAL;
  ButtonType _type =  ButtonType.CUSTOM;
  PageKey _targetPageKey  ;
  LaunchAction _action ;
  
  ButtonModel({Color color,Image image,String label, ButtonType type, PageKey targetPageKey, LaunchAction action, ApplicationEventCallBack applicationEventCallBack} ){
    this.color = color ;
    _image = image ;
    _label = label ;
    _type = type ;
    _targetPageKey = targetPageKey;
    _action = action ;
    _applicationEventCallBack = applicationEventCallBack;    
  }

  Color get color => _color.clone();
  set color(Color value ){
    if(value == null){
          _color = Color.BLUE_0082C8;
    }else{
          _color = value ;
    }
  }
  
  ButtonStatus get status => _status;
  set status(ButtonStatus value){
    _status = value ;
  }
  
  ButtonType get type => _type;
  set type(ButtonType value){
    _type = value ;
  }  
  
  PageKey get targetPageKey => _targetPageKey  ;
  
  Image get image => _image;
  String get label => _label;
  LaunchAction get action => _action ;
  set action(LaunchAction action){
    _action = action;
  }
  
  ActionDescriptor get actionDescriptor => new ActionDescriptor(name: _label,launchAction: _action);
  bool get hasImage => _image != null  ;
  bool get hasLabel => _label != null && _label.isNotEmpty ;
  
  ButtonModel clone(){
    return new ButtonModel(color:color.clone(),image:_image,label:_label,type:_type,targetPageKey:_targetPageKey,action:_action,applicationEventCallBack:_applicationEventCallBack);
  }
  
  @override
  void recieveApplicationEvent(ApplicationEvent event){
    if (_applicationEventCallBack != null){
      _applicationEventCallBack(event);
    }
  }
  
}

class ToolbarModel extends Object with ApplicationEventCallBackHolder{
   
  List<ButtonModel> _buttons ;
  Position _mainButtonPosition ;
  Orientation _orientation ;
  Color _color;
  ColorUsage _colorUsage;
  
  ToolbarModel({List<ButtonModel> buttons,Position mainButtonPosition,Orientation orientation,Color color, ColorUsage colorUsage, ApplicationEventCallBack applicationEventCallBack} ){
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
    _color = color;
    _colorUsage = colorUsage;
    _applicationEventCallBack = applicationEventCallBack;
  }
  
   set mainButtonPosition(Position position){
     _mainButtonPosition = position;
   }
   set colorUsage(ColorUsage value){
     _colorUsage = value;
   }
  
  Position get mainButtonPosition => _mainButtonPosition.clone(); 
  Orientation get orientation =>  _orientation ;
  set orientation(Orientation value) {
    _orientation = value;
  }
  Color get color => _color == null ? null : _color.clone();
  
  num get nbActions =>  _buttons.length;
  
  List<ButtonModel> get buttons {
    List<ButtonModel> buttons = new List<ButtonModel>();
    _buttons.forEach((b)=>buttons.add(b));
    return buttons ; 
  }
  
  Color getColorForBackGround(num buttonIndex){
    assert(buttonIndex <= _buttons.length );
    
    if ( _colorUsage != null && _color != null ){
      switch (_colorUsage){
        case ColorUsage.GRADATION :
          switch (buttonIndex){
            case 0: return _color.veryStrongColorAsColor;
            case 1: return _color.strongColorAsColor;
            case 2: return _color;
            case 3: return _color.lightColorAsColor;
            default : return _color.veryLightColorAsColor;
          }
          break;
        case ColorUsage.ALTERNATE :
          if (buttonIndex % 2 == 0){
              return  _color;           
          }else{
              return  _color.inverseLightColorAsColor;  
          }
          break;
        case ColorUsage.ALTERNATE_WITH_LIGHT :
          if (buttonIndex % 2 == 0){
              return  _color;           
          }else{
              return  _color.lightColorAsColor;  
          }
          break;          
        case ColorUsage.UNIFORM :
          return  _color;
        default :
          return  _color;
      }
    }else{
      return _buttons[buttonIndex].color;
    }
    return null;
  }
  
  ToolbarModel clone(){
    return new ToolbarModel(buttons:buttons,mainButtonPosition:mainButtonPosition,orientation:orientation,color:color, colorUsage:_colorUsage,applicationEventCallBack:_applicationEventCallBack);
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
  num _devicePixelRatio ;

  ViewPortModel.fromWindow(Window window){
    _windowHeight = window.innerHeight ;
    _windowWidth = window.innerWidth ;
    _devicePixelRatio = window.devicePixelRatio ;
  }
  ViewPortModel(this._windowHeight, this._windowWidth);
  
  num get windowHeight => _windowHeight ;
  num get windowWidth => _windowWidth ;
  num get windowDevicePixelRatio => _devicePixelRatio ;
  num get windowDiagonal => sqrt( pow(_windowHeight, 2) +  pow(_windowWidth, 2)   ).truncate();
  
  ScreenOrientation get orientation => _windowHeight < _windowWidth ? ScreenOrientation.LANDSCAPE : ScreenOrientation.PORTRAIT;
      
  ViewPortModel clone(){
    return new ViewPortModel(this._windowHeight, this._windowWidth);
  }
  
  @override
  String toString() => "ViewPortModel: windowHeight: ${_windowHeight}, windowWidth: ${_windowWidth}, devicePixelRatio: ${_devicePixelRatio}";
  
  @override
  int get hashCode {
     int result = 17;
     result = 37 * result + _windowHeight.hashCode;
     result = 37 * result + _windowWidth.hashCode;
     result = 37 * result + _devicePixelRatio.hashCode;
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
  
  num _small = 500 ;
  num _big = 2000 ; 
  num incompressible = 18 ;
  
  Color _color  ;
  ToolbarModel _toolbarModel ;
  Margin _margin;
  
  LayoutModel({Color color, ToolbarModel toolbarModel, Margin margin }){
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
    if(margin == null){
      _margin = new Margin();
    }else{
      _margin = margin ;
    } 
   
  }
  
  Color get color => _color.clone();
  ToolbarModel get toolbarModel => _toolbarModel.clone();
  Margin get margin => _margin.clone();
  set margin(Margin margin){
    _margin=margin;
  }
  
  num leftMarginInPx(Position position){
    if ( position.width > _big   ){
      return   (position.width - _big ) /2 ;
    }
    return _margin.leftInPx +incompressible;
  }
  num rightMarginInPx(Position position){
    if ( position.width > _big   ){
      return   (position.width - _big ) /2 ;
    }
    return _margin.rightInPx+incompressible;
  }
  num topMarginInPx(Position position){
    return _margin.topInPx;
  }  
  num bottomMarginInPx(Position position){
    return _margin.bottomInPx;
  } 
  num spaceWidth(Position position){
    return position.width - leftMarginInPx(position) - rightMarginInPx(position)  ;
  }
  
  num toolBarHeight(Position position){
    num percent = 0.15 ;
    if ( position.height < _small  ){
      return _small * percent;
    }
    if ( position.width > _big   ){
      return _big * percent;
    }
    return position.height * percent;
  }
  
  LayoutModel clone(){
    return new LayoutModel(color:color, toolbarModel:toolbarModel, margin:margin);
  }
  
}


class PageModel extends Object with ApplicationEventCallBackHolder{
  
  String _name ;
  LayoutModel _layoutModel ;
  Margin _margin ;
  
  PageModel ({String name ,LayoutModel layoutModel,Margin margin , ApplicationEventCallBack applicationEventCallBack}){
    assert(name != null);
    _name = name;
    if(layoutModel == null){
      _layoutModel = new LayoutModel();
    }else{
      _layoutModel = layoutModel ;
    }     
    if(margin == null){
      _margin = new Margin();
    }else{
      _margin = margin ;
    }    
    _applicationEventCallBack = applicationEventCallBack;    
  }
  
  String get name => _name ;
  
  Margin get margin => _margin.clone();
  set margin(Margin margin){
    _margin=margin;
  }
  
  LayoutModel get layoutModel => _layoutModel.clone();
  
  
}
