part of gex_common_ui_elements;

typedef void LaunchAction(Parameters params);

class Parameter{
  String key ;
  String value;
  
  Parameter(this.key,this.value) ;
}

class Parameters{
  List<Parameter> parameters = new List<Parameter>() ;
  
  add(String key, String value){
    parameters.add( new Parameter(key,value) ) ;
  }
}

class ActionDescriptor{
  
  String name;
  String description;
  LaunchAction launchAction;
  
  ActionDescriptor(this.name,this.description,this.launchAction);
  
  ActionDescriptor clone(){
    return new ActionDescriptor(name,description,launchAction);
  }
  
  
}


class Actionable{
  
  ActionDescriptor _action ;
  
  void targetAction(ActionDescriptor action) {
    this._action = action ;
  }
  
  void launchAction(Parameters params){
    if (_action != null){
      _action.launchAction(params);
    }
  }
  
  ActionDescriptor get action => _action.clone();
}
