// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.test_bus;

import 'package:unittest/unittest.dart';
import 'package:mockito/mockito.dart';
import 'dart:html';
import 'dart:async';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'app/application.dart';
import 'app/page_one.dart';

main() {
  initPolymer();

  TestApplication application;
  ApplicationEventBus applicationEventBus = new ApplicationEventBus();

  group("Bus", () {
    setUp(() {
      if (application == null) {
        application = querySelector("#application");
        application.moveTo(new Position(0, 0, 1000, 500, 100));
        application.setApplicationEventBus(applicationEventBus);
        applicationEventBus.fireApplicationEvent(new ApplicationEvent(applicationEventBus));
      }
    });

    group('events propagation from bus', () {
      test('to application', () {
        new Timer(new Duration(milliseconds: 1000),
            expectAsync(() => verify(application.dummyActionApplication.doSomething("ApplicationEvent")).called(1)));
      });

      test('to main toolbars', () {
        new Timer(new Duration(milliseconds: 1000),
            expectAsync(() => verify(application.dummyActionToolBars.doSomething("ApplicationEvent")).called(2)));
      });

      test('to main toolbars buttons', () {
        new Timer(new Duration(milliseconds: 1000), expectAsync(
            () => verify(application.dummyActionToolBarsButtons.doSomething("ApplicationEvent")).called(3)));
      });

      test('to pages', () {
        new Timer(new Duration(milliseconds: 1000), expectAsync(() =>
            verify((application.pages[0] as PageOne).dummyActionPages.doSomething("ApplicationEvent")).called(1)));
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

class DummyAction {
  void doSomething(String eventName) {}
}

class DummyActionMock extends Mock implements DummyAction {}
