
import 'package:flutter/material.dart';

import 'home.dart';

main() => runApp(DespesasApp());

class DespesasApp extends StatelessWidget {
  const DespesasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomoPage(),
    );
  }
}


