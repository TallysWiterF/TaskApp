import 'package:flutter/material.dart';
import 'package:task_app/components/difficulty.dart';
import 'package:task_app/data/task_dao.dart';

class Task extends StatefulWidget {
  final String name;
  final String image;
  final int difficulty;
  int level;
  int mastery = 0;

  Task(this.name, this.image, this.difficulty, this.level, this.mastery,
      {super.key});

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
                color: getMaestriaColor(widget.mastery),
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
                            onLongPress: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Deletar'),
                                    content: const Text(
                                        'Tem certeza que deseja deletar essa tarefa?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          TaskDao().delete(widget.name);
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                ),
                            onPressed: () {
                              setState(() {
                                widget.level++;
                                if ((widget.difficulty > 0 &&
                                    widget.level > (widget.difficulty * 10))) {
                                  widget.mastery++;
                                  widget.level = 0;
                                }
                              });
                              TaskDao().save(widget);
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
                            ? (widget.level / widget.difficulty) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text("Nível: ${widget.level}",
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

Color getMaestriaColor(int mastery) {
  switch (mastery) {
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
