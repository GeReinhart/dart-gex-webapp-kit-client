part of gex_common_ui_elements;

enum ScreenOrientation { LANDSCAPE , PORTRAIT }

class Parameter{
  String _key ;
  String _value;
  
  Parameter(this._key,this._value) ;
  
  String get key => _key;
  String get value => _value;
  
  Parameter clone(){
    return new Parameter(this._key,this._value) ;
  }
}

class Parameters{
  List<Parameter> _parameters ;
  
  Parameters(List<Parameter> parameters){
    if (parameters == null){
      _parameters = new List<Parameter>() ;
    }else{
      _parameters = parameters;
    }
  }
  
  List<Parameter> get parameters {
    List<Parameter> parameters = new List<Parameter>() ;
    _parameters.forEach((p)=> parameters.add(p));
    return parameters;
  } 
  
  void add(String key, String value){
    _parameters.add( new Parameter(key,value) ) ;
  }
  
  Parameters clone(){
    return new Parameters(parameters);
  }
}

class ActionDescriptor{
  
  String _name;
  String _description;
  LaunchAction _launchAction;
  
  ActionDescriptor({String name,String description,LaunchAction launchAction}){
    _name = name;
    _description = description;
    _launchAction = launchAction;
  }
  
  String get name => _name;
  String get description => _description == null ? _name : _description;
  LaunchAction get launchAction => _launchAction;
  
  ActionDescriptor clone(){
    return new ActionDescriptor(name:_name,description:_description,launchAction:launchAction);
  }
  
}
