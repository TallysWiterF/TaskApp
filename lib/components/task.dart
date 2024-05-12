import 'package:flutter/material.dart';
import 'package:task_app/components/difficulty.dart';

class Task extends StatefulWidget {
  final String name;
  final String image;
  final int difficulty;
  Task(this.name, this.image, this.difficulty, {super.key});

  int nivel = 0;
  int nivelMaestria = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool isImageNetwork() => widget.image.contains('http');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: getMaestriaColor(widget.nivelMaestria),
                borderRadius: BorderRadius.circular(4)),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)),
                height: 100,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(4)),
                        width: 72,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: isImageNetwork()
                              ? Image.network(
                                  widget.image,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  widget.image,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              widget.name,
                              style: const TextStyle(
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Difficulty(
                            difficultyLevel: widget.difficulty,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 52,
                        width: 52,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                widget.nivel++;
                                if ((widget.difficulty > 0 &&
                                    widget.nivel > (widget.difficulty * 10))) {
                                  widget.nivelMaestria++;
                                  widget.nivel = 0;
                                }
                              });
                            },
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.arrow_drop_up),
                                Text(
                                  "UP",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            )),
                      )
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: widget.difficulty > 0
                            ? (widget.nivel / widget.difficulty) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text("Nível: ${widget.nivel}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

Color getMaestriaColor(int nivelMaestria) {
  switch (nivelMaestria) {
    case 0:
      return Colors.blue;
    case 1:
      return Colors.green;
    case 2:
      return Colors.yellow;
    case 3:
      return Colors.orange;
    case 4:
      return Colors.red;
    case 5:
      return Colors.purple;
    default:
      return Colors.black;
  }
}
