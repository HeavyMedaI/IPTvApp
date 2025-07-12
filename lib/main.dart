import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guek_iptv/app.dart';
import 'package:guek_iptv/app/AppBindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBindings().dependencies();
  runApp(MyApp());
}
