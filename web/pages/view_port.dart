library gex_common_ui_elements.show_room.view_port;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:gex_common_ui_elements/elements/layout.dart';
import 'package:gex_common_ui_elements/elements/page.dart';

@CustomTag('page-view-port')
class PageViewPort extends Page with Showable {
  static final String NAME = "view-port";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.BLUE_0082C8.inverse();

  Layout layout;

  SpanElement viewPortWidth;
  SpanElement viewPortHeight;
  SpanElement viewPortDiagonal;
  SpanElement viewPortDevicePixelRatio;
  SpanElement viewPortOrientation;
  SpanElement viewPortTouchDevice;

  PageViewPort.created() : super.created();

  @override
  void ready() {
    super.ready();
    _setAttributes();
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    if (event is ViewPortChangeEvent) {
      _viewPortChangeCallBack(event);
    }
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;

    viewPortWidth = this.shadowRoot.querySelector("#viewPortWidth") as SpanElement;
    viewPortHeight = this.shadowRoot.querySelector("#viewPortHeight") as SpanElement;
    viewPortDevicePixelRatio = this.shadowRoot.querySelector("#viewPortDevicePixelRatio") as SpanElement;
    viewPortDiagonal = this.shadowRoot.querySelector("#viewPortDiagonal") as SpanElement;
    viewPortOrientation = this.shadowRoot.querySelector("#viewPortOrientation") as SpanElement;
    viewPortTouchDevice = this.shadowRoot.querySelector("#viewPortTouchDevice") as SpanElement;

    LayoutModel layoutModel = new LayoutModel(color: mainColor);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  void _viewPortChangeCallBack(ViewPortChangeEvent event) {
    ViewPortModel viewPort = event.viewPortModel;
    viewPortWidth.innerHtml = viewPort.windowWidth.toString();
    viewPortHeight.innerHtml = viewPort.windowHeight.toString();
    viewPortDiagonal.innerHtml = viewPort.windowDiagonal.toString();
    viewPortDevicePixelRatio.innerHtml = viewPort.windowDevicePixelRatio.toString();
    viewPortHeight.innerHtml = viewPort.windowHeight.toString();
    viewPortOrientation.innerHtml = viewPort.orientation.toString();
    viewPortTouchDevice.innerHtml = viewPort.isTouchDevice.toString();
  }
}
