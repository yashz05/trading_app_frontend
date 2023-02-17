import 'dart:convert';

class twillo_config {
  static var sid = "VA8f498c7066571873de899df719f6b195";
  static var uname = 'AC70ca16facc3697820f260ccc4cc9ebd1';
  static var pword = '0bc8e9838d2ac16c53d465072fdd1182';
  static var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));
}
