// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.test_routing;

import 'package:unittest/unittest.dart';
import 'package:mockito/mockito.dart';
import 'dart:html';
import 'dart:async';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'app/application.dart';

main() {
  initPolymer();

  TestApplication application;
  ApplicationEventBus applicationEventBus = new ApplicationEventBus();
  PageKeyUrlConverter pageKeyUrlConverter = new PageKeyUrlConverter();
  PageKeyUrlConverterMock pageKeyUrlConverterMock = new PageKeyUrlConverterMock();
  Router router = new Router(pageKeyUrlConverterMock);
  router.setApplicationEventBus(applicationEventBus);

  group("PageKeyUrlConverter", () {
    test('no page', () {
      String name = "";
      Parameters resources = new Parameters(null);
      Parameters params = new Parameters(null);
      String expectedPageKey = "PageKey: name:${name}, resources:${resources}, params:${params}";
      expect(pageKeyUrlConverter.convertToPageKey("http://dartisans.net/").toString(), equals(expectedPageKey));
      expect(pageKeyUrlConverter.convertToPageKey("http://dartisans.net").toString(), equals(expectedPageKey));
      expect(
          pageKeyUrlConverter.convertToPageKey("http://connecting.dartisans.net/").toString(), equals(expectedPageKey));
      expect(
          pageKeyUrlConverter.convertToPageKey("http://connecting.dartisans.net").toString(), equals(expectedPageKey));
      expect(pageKeyUrlConverter.convertToPageKey("https://dartisans.net/").toString(), equals(expectedPageKey));
      expect(pageKeyUrlConverter.convertToPageKey("https://dartisans.net").toString(), equals(expectedPageKey));
      expect(pageKeyUrlConverter.convertToPageKey("https://connecting.dartisans.net/").toString(),
          equals(expectedPageKey));
      expect(
          pageKeyUrlConverter.convertToPageKey("https://connecting.dartisans.net").toString(), equals(expectedPageKey));
    });

    test('simple page', () {
      String name = "page1";
      Parameters resources = new Parameters(null);
      Parameters params = new Parameters(null);
      String expectedPageKey = "PageKey: name:${name}, resources:${resources}, params:${params}";
      expect(pageKeyUrlConverter.convertToPageKey("http://dartisans.net/#${name}").toString(), equals(expectedPageKey));
      expect(pageKeyUrlConverter.convertToPageKey("http://connecting.dartisans.net/#${name}").toString(),
          equals(expectedPageKey));
      expect(
          pageKeyUrlConverter.convertToPageKey("https://dartisans.net/#${name}").toString(), equals(expectedPageKey));
      expect(pageKeyUrlConverter.convertToPageKey("https://connecting.dartisans.net/#${name}").toString(),
          equals(expectedPageKey));
      expect(pageKeyUrlConverter.convertToPageKey("/#${name}").toString(), equals(expectedPageKey));
    });
  });

  group("Routing", () {
    setUp(() {
      if (application == null) {
        application = querySelector("#application");
        application.moveTo(new Position(0, 0, 1000, 500, 100));
        application.setApplicationEventBus(applicationEventBus);

        PageKey pageKey1 = new PageKey(name: "PageOne");
        when(pageKeyUrlConverterMock.convertToPageKey(argThat(endsWith("#PageOne")))).thenReturn(pageKey1);
        PageKey pageKey2 = new PageKey(name: "PageTwo");
        when(pageKeyUrlConverterMock.convertToPageKey(argThat(endsWith("#PageTwo")))).thenReturn(pageKey2);

        router.init();
      }
    });

    group('load page from url', () {
      test('simple page', () {
        new Timer(new Duration(milliseconds: 1000), expectAsyncUntil(() {
          assert(application.currentPageModel.name == "PageTwo");
        }, () {
          return application.currentPageModel != null;
        }));
      });
    });

    group('update window location', () {
      test('when change page', () {
        applicationEventBus
            .fireApplicationEvent(new PageDisplayedEvent(sender: applicationEventBus, pageName: "PageOne"));

        new Timer(new Duration(milliseconds: 1000), expectAsyncUntil(() {
          assert(window.location.href.endsWith("#PageOne"));
        }, () {
          return window.location.href.endsWith("#PageOne");
        }));
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

class PageKeyUrlConverterMock extends Mock implements PageKeyUrlConverter {}
