import 'dart:convert';

class twillo_config {
  static var sid = "VA8f498c7066571873de899df719f6b195";
  static var uname = 'AC70ca16facc3697820f260ccc4cc9ebd1';
  static var pword = 'b074c6169c62583114b533dff97d31ba';
  static var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));
}
