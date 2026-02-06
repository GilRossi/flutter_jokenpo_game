import 'dart:math';
import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  static const _opcoes = ["pedra", "papel", "tesoura"];

  String _mensagem = "Escolha uma opção abaixo";
  String _escolhaApp = "padrao";

  void _jogar(String escolhaUsuario) {
    final escolhaApp = _opcoes[Random().nextInt(_opcoes.length)];

    setState(() {
      _escolhaApp = escolhaApp;
      _mensagem = _resultado(escolhaUsuario, escolhaApp);
    });
  }

  String _resultado(String usuario, String app) {
    if (usuario == app) return "Empate 😄";

    if ((usuario == "pedra" && app == "tesoura") ||
        (usuario == "papel" && app == "pedra") ||
        (usuario == "tesoura" && app == "papel")) {
      return "Parabéns! Você ganhou 🎉";
    }

    return "Você perdeu 😢";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JokenPo"),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isPortrait =
                constraints.maxHeight > constraints.maxWidth;

            return isPortrait
                ? _portraitLayout()
                : _landscapeLayout();
          },
        ),
      ),
    );
  }

  // 📱 PORTRAIT
  Widget _portraitLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 24),

        _titulo(),
        const SizedBox(height: 16),

        _imagemApp(),
        const SizedBox(height: 16),

        _mensagemWidget(),
        const SizedBox(height: 16),

        _botoes(),
      ],
    );
  }


  // 📱 LANDSCAPE (AGORA CORRETO)
  Widget _landscapeLayout() {
    return Row(
      children: [
        // 👈 COLUNA ESQUERDA (APP)
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _titulo(),
              const SizedBox(height: 16),
              _imagemApp(),
            ],
          ),
        ),

        // 👉 COLUNA DIREITA (USUÁRIO)
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _mensagemWidget(),
              const SizedBox(height: 16),
              _botoes(),
            ],
          ),
        ),
      ],
    );
  }

  // 🔹 COMPONENTES

  Widget _titulo() {
    return const Text(
      "Escolha do App",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _imagemApp() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Image.asset(
        "images/$_escolhaApp.png",
        key: ValueKey(_escolhaApp),
        width: 180,
      ),
    );
  }

  Widget _mensagemWidget() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        _mensagem,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _botoes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _opcoes.map(_botaoOpcao).toList(),
    );
  }

  Widget _botaoOpcao(String opcao) {
    return GestureDetector(
      onTap: () => _jogar(opcao),
      child: Image.asset(
        "images/$opcao.png",
        width: 80,
      ),
    );
  }
}
