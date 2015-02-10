// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.show_room.bus;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/page.dart';

@CustomTag('page-bus')
class PageBus extends Page with Showable {
  static final String NAME = "bus";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.BLUE_0082C8;

  Layout layout;
  HtmlElement table;
  TableRowElement eventRow;

  PageBus.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;
    LayoutModel layoutModel = new LayoutModel(color: mainColor);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);

    table = $["event-table-body"];
    eventRow = $["event"] as TableRowElement;
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    TableRowElement newEventRow = eventRow.clone(true);

    newEventRow.cells[0].innerHtml = event.type;
    newEventRow.cells[1].innerHtml = event.sender.toString();
    newEventRow.cells[2].innerHtml = event.toString();

    table.insertBefore(newEventRow, eventRow);
    eventRow = newEventRow;
  }
}
