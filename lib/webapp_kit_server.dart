// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_server;

import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:redstone/server.dart' as app;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:connection_pool/connection_pool.dart';
import "package:redstone_mapper/plugin.dart";
import "package:redstone_mapper_mongo/service.dart";
import "package:oauth2/oauth2.dart";

import 'package:gex_webapp_kit/webapp_kit_common.dart';

part 'server/user_service.dart';
