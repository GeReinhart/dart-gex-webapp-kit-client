// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.test_application;

import 'package:unittest/unittest.dart';
import 'dart:html';
import 'dart:async';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'app/application.dart';

main() {
  initPolymer();

  TestApplication application4Toolbars;
  TestApplication application2Toolbars;

  num toolBarPercentage = 0.2;
  num marginPercentage = 0.2;

  group("Application", () {
    setUp(() {
      application4Toolbars = querySelector("#application4Toolbars");
      application2Toolbars = querySelector("#application2Toolbars");
    });

    group('toolbars: ', () {
      test('landscape orientation', () {
        num width = 1000;
        num height = 500;

        application4Toolbars.moveTo(new Position(0, 0, width, height, 100));
        List<ToolbarModel> toolbars = application4Toolbars.toolbarModels;
        expect(toolbars.length, equals(4));
        expect(toolbars[0].orientation, equals(Orientation.south));
        expect(toolbars[0].mainButtonPosition.left, equals(0));
        expect(toolbars[0].mainButtonPosition.top, equals(0));

        expect(toolbars[1].orientation, equals(Orientation.north));
        expect(toolbars[1].mainButtonPosition.left, equals(width - toolbars[0].mainButtonPosition.width));
        expect(toolbars[1].mainButtonPosition.top, equals(height - toolbars[0].mainButtonPosition.height));

        expect(toolbars[2].orientation, equals(Orientation.west));
        expect(toolbars[2].mainButtonPosition.left, equals(width - toolbars[0].mainButtonPosition.width));
        expect(toolbars[2].mainButtonPosition.top, equals(0));

        expect(toolbars[3].orientation, equals(Orientation.est));
        expect(toolbars[3].mainButtonPosition.left, equals(0));
        expect(toolbars[3].mainButtonPosition.top, equals(height - toolbars[0].mainButtonPosition.height));
      });

      test('portrait orientation', () {
        num width = 500;
        num height = 1000;

        application4Toolbars.moveTo(new Position(0, 0, width, height, 100));
        List<ToolbarModel> toolbars = application4Toolbars.toolbarModels;
        expect(toolbars.length, equals(4));
        expect(toolbars[0].orientation, equals(Orientation.est));
        expect(toolbars[0].mainButtonPosition.left, equals(0));
        expect(toolbars[0].mainButtonPosition.top, equals(0));

        expect(toolbars[1].orientation, equals(Orientation.west));
        expect(toolbars[1].mainButtonPosition.left, equals(width - toolbars[0].mainButtonPosition.width));
        expect(toolbars[1].mainButtonPosition.top, equals(height - toolbars[0].mainButtonPosition.height));

        expect(toolbars[2].orientation, equals(Orientation.south));
        expect(toolbars[2].mainButtonPosition.left, equals(width - toolbars[0].mainButtonPosition.width));
        expect(toolbars[2].mainButtonPosition.top, equals(0));

        expect(toolbars[3].orientation, equals(Orientation.north));
        expect(toolbars[3].mainButtonPosition.left, equals(0));
        expect(toolbars[3].mainButtonPosition.top, equals(height - toolbars[0].mainButtonPosition.height));
      });

      test('landscape size', () {
        num width = 1000;
        num height = 500;
        num size = width > height ? height * toolBarPercentage : width * toolBarPercentage;

        application4Toolbars.moveTo(new Position(0, 0, width, height, 100));
        application4Toolbars.toolbarModels.forEach((t) {
          expect(t.mainButtonPosition.width, equals(size));
          expect(t.mainButtonPosition.height, equals(size));
        });
      });

      test('portrait size', () {
        num width = 500;
        num height = 1000;
        num size = width > height ? height * toolBarPercentage : width * toolBarPercentage;

        application4Toolbars.moveTo(new Position(0, 0, width, height, 100));
        application4Toolbars.toolbarModels.forEach((t) {
          expect(t.mainButtonPosition.width, equals(size));
          expect(t.mainButtonPosition.height, equals(size));
        });
      });
    });

    group('margin: ', () {
      test('landscape', () {
        num width = 1000;
        num height = 500;
        num sizeToolBar = width > height ? height * toolBarPercentage : width * toolBarPercentage;
        num sizeMargin = sizeToolBar * (1 + marginPercentage);

        application2Toolbars.moveTo(new Position(0, 0, width, height, 100));
        application2Toolbars.pages.forEach((p) {
          expect(p.margin.topInPx, equals(0));
          expect(p.margin.bottomInPx, equals(0));
          expect(p.margin.rightInPx, equals(sizeMargin));
          expect(p.margin.leftInPx, equals(sizeMargin));
        });
      });
    });
  });

  pollForDone(testCases);
}

pollForDone(List tests) {
  if (tests.every((t) => t.isComplete)) {
    window.postMessage('dart-main-done', window.location.href);
    return;
  }

  var wait = new Duration(milliseconds: 100);
  new Timer(wait, () => pollForDone(tests));
}
