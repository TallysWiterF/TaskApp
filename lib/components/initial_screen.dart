import 'package:flutter/material.dart';
import 'package:task_app/components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({
    super.key,
  });

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Tarefas'),
      ),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        child: ListView(
          children: [
            const Task('Aprender Flutter', 'assets/images/dash.png', 3),
            const Task('Andar de Bike', 'assets/images/bike.webp', 2),
            const Task('Meditar', 'assets/images/meditar.jpeg', 5),
            const Task('Ler', 'assets/images/livro.jpg', 4),
            const Task('Jogar', 'assets/images/jogar.jpg', 1),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacidade = !opacidade;
          });
        },
        child: opacidade
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.remove_red_eye),
      ),
    );
  }
}
