import 'package:flutter/material.dart';
import 'home.dart'; // Certifique-se de que este caminho está correto

void main() => runApp(DespesasApp());

class DespesasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Despesas Pessoais', // Adicione um título ao seu MaterialApp
      theme: ThemeData(
        primarySwatch: Colors.teal, // Mantendo a cor padrão para primário
        primaryColor: Color.fromRGBO(10, 193, 199, 1.0), // Usando RGBA para a cor primária

        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromRGBO(0, 150, 136, 100), // Usando RGBA para a cor da AppBar
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(0, 150, 136, 100), // Usando RGBA para o FloatingActionButton
          foregroundColor: Colors.white, // Cor do ícone
          elevation: 6, // Sombra
        ),
        fontFamily: 'RobotoMano'
      ),

      home: MyHomoPage(), // Certifique-se de que a classe esteja nomeada corretamente
    );
  }
}
