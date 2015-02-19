// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_server;

String encryptPassword(String pass) {
  var toEncrypt = new SHA1();
  toEncrypt.add(UTF8.encode(pass));
  return CryptoUtils.bytesToHex(toEncrypt.close());
}
