part of gex_common_ui_elements;


class Color{
  
  static final Color BLUE_0082C8 = new Color("#013552","#8C3100","#0082C8","#59ACD9","#99C6DE",      
                                             "#521E01","#005B8C","#C84600","#D98659","#DEB199");
  
  static final Color GREEN_07CC00 = new Color("#355E34","#4B8549","#63B061","#96D494","#C4E6C3",      
                                             "#5D345E","#834985","#AE61B0","#D294D4","#E5C3E6");

  static final Color GREY_858585 = new Color("#000000","#454545","#858585","#BABABA","#FFFFFF",      
                                             "#1F1E15","#57563A","#8F8D5E","#C9C785","#FCFAA7");
  
  static final Color WHITE = new Color("#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF",      
                                             "#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF");
  
  String _veryStrongColor ;
  String _strongColor ;
  String _mainColor ;
  String _lightColor ;
  String _veryLightColor ;
  
  String _inverseVeryStrongColor ;
  String _inverseStrongColor ;
  String _inverseMainColor ;
  String _inverseLightColor ;
  String _inverseVeryLightColor ;
  
  Color(this._veryStrongColor, this._strongColor, this._mainColor, this._lightColor, this._veryLightColor,
        this._inverseVeryStrongColor, this._inverseStrongColor, this._inverseMainColor, this._inverseLightColor, this._inverseVeryLightColor
       );
  
  String get veryStrongColor => _veryStrongColor ;
  String get strongColor => _strongColor ;
  String get mainColor => _mainColor ;
  String get lightColor => _lightColor ;
  String get veryLightColor => _veryLightColor ;
  
  Color clone(){
    return new Color(this._veryStrongColor, this._strongColor, this._mainColor, this._lightColor, this._veryLightColor,
        this._inverseVeryStrongColor, this._inverseStrongColor, this._inverseMainColor, this._inverseLightColor, this._inverseVeryLightColor);
  }
  
}