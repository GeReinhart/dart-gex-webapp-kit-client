library gex_common_ui_elements.test_app.page_one;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:gex_common_ui_elements/elements/layout.dart';
import 'package:gex_common_ui_elements/elements/page.dart';

import '../test_bus.dart';

@CustomTag('gex-page-one')
class PageOne extends Page with Showable {
  final Logger log = new Logger('PageOne');

  Color mainColor = Color.GREY_858585.lightColorAsColor;

  Layout layout;

  DummyActionMock dummyActionPages = new DummyActionMock();

  PageOne.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;

    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add(new ButtonModel(label: "Action 1", action: action1));
    buttonModels.add(new ButtonModel(label: "Action 2", action: action2));
    buttonModels.add(new ButtonModel(label: "Action 3", action: action3));
    ToolbarModel toolbarModel =
        new ToolbarModel(buttons: buttonModels, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT);

    LayoutModel layoutModel = new LayoutModel(toolbarModel: toolbarModel, color: mainColor);
    PageModel model = new PageModel(
        name: "PageOne", layoutModel: layoutModel, applicationEventCallBack: recieveApplicationEventPages);
    this.init(model);
  }

  action1(Parameters params) {
    layout.style.backgroundColor = mainColor.strongColor;
  }
  action2(Parameters params) {
    layout.style.backgroundColor = mainColor.mainColor;
  }
  action3(Parameters params) {
    layout.style.backgroundColor = mainColor.lightColor;
  }

  void recieveApplicationEventPages(ApplicationEvent event) {
    dummyActionPages.doSomething(event.name);
  }
}
