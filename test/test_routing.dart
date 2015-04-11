// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.test_routing;

import 'package:unittest/unittest.dart';
import 'package:mockito/mockito.dart';
import 'dart:html';
import 'dart:async';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:gex_webapp_kit/webapp_kit_common.dart';
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
    /*  test('no page', () {
      expect(pageKeyUrlConverter.convertToPageKey("http://dartisans.net/"), equals(null));
      expect(pageKeyUrlConverter.convertToPageKey("http://dartisans.net"), equals(null));
      expect(pageKeyUrlConverter.convertToPageKey("http://connecting.dartisans.net/"), equals(null));
      expect(pageKeyUrlConverter.convertToPageKey("http://connecting.dartisans.net/#"), equals(null));
      expect(pageKeyUrlConverter.convertToPageKey("http://connecting.dartisans.net"), equals(null));
      expect(pageKeyUrlConverter.convertToPageKey("https://dartisans.net/"), equals(null));
      expect(pageKeyUrlConverter.convertToPageKey("https://dartisans.net"), equals(null));
      expect(pageKeyUrlConverter.convertToPageKey("https://connecting.dartisans.net/"), equals(null));
      expect(pageKeyUrlConverter.convertToPageKey("https://connecting.dartisans.net"), equals(null));
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
      expect(pageKeyUrlConverter.convertToPageKey("http://localhost:9090/index.html#${name}").toString(),
          equals(expectedPageKey));
    });

    test('page  with one resource', () {
      String name = "page1";
      String key = "id";
      String value = "123456";
      Parameters resources = new Parameters.withOneParam(key, value);
      Parameters params = new Parameters(null);
      String expectedPageKey = "PageKey: name:${name}, resources:${resources}, params:${params}";
      expect(
          pageKeyUrlConverter.convertToPageKey("http://connecting.dartisans.net/#${name}/${key}/${value}").toString(),
          equals(expectedPageKey));
      expect(
          pageKeyUrlConverter.convertToPageKey("http://connecting.dartisans.net/#${name}/${key}/${value}/").toString(),
          equals(expectedPageKey));
    });*/
    test('page  with params', () {
      String name = "page1";
      String key3 = "id3";
      String value3 = "12345678";
      Parameters resources = new Parameters.withOneParam(key3, value3);
      String key = "id";
      String value = "123456";
      String key2 = "id2";
      String value2 = "1234567";
      Parameters params = new Parameters.withOneParam(key, value);
      params.add(key2, value2);
      String expectedPageKey = "PageKey: name:${name}, resources:${resources}, params:${params}";
      expect(pageKeyUrlConverter
          .convertToPageKey(
              "http://connecting.dartisans.net/#${name}/${key3}/${value3}?${key}=${value}&${key2}=${value2}")
          .toString(), equals(expectedPageKey));
    });

    test('page  resources with params', () {
      String name = "page1";
      String key = "id";
      String value = "123456";
      String key2 = "id2";
      String value2 = "1234567";
      Parameters params = new Parameters.withOneParam(key, value);
      params.add(key2, value2);
      Parameters resources = new Parameters(null);
      String expectedPageKey = "PageKey: name:${name}, resources:${resources}, params:${params}";
      expect(pageKeyUrlConverter
          .convertToPageKey("http://connecting.dartisans.net/#${name}?${key}=${value}&${key2}=${value2}")
          .toString(), equals(expectedPageKey));
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

    /*   group('load page from url', () {
      test('simple page', () {
        new Timer(new Duration(milliseconds: 1000), expectAsyncUntil(() {
          assert(application.currentPageModel.name == "PageTwo");
        }, () {
          return application.currentPageModel != null;
        }));
      });
    });*/

    group('update window location', () {
      test('when change page', () {
        applicationEventBus.fireApplicationEvent(new ApplicationEvent.pageDisplayed(applicationEventBus, "PageOne"));

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
