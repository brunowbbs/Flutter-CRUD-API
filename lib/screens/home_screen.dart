import 'package:cleanarch/controllers/todo_controller.dart';
import 'package:cleanarch/models/todo.dart';
import 'package:cleanarch/repositories/todo_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //injeção de dependencia
    var todoController = TodoController(TodoRepository());

    todoController.fetchTodoList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rest API"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Todo todo = Todo(userId: 3, title: "Sample Post", completed: false);
          var response = await todoController.postTodo(todo);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                response.toString(),
              ),
              duration: const Duration(milliseconds: 500),
              backgroundColor: Colors.green,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Erro ao carregar todos"),
            );
          }

          return SafeArea(
            child: ListView.separated(
              itemBuilder: (context, index) {
                var todo = snapshot.data?[index];

                return Container(
                  height: 100.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text('${todo?.id}')),
                      Expanded(flex: 3, child: Text('${todo?.title}')),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                todoController.updatePatchCompleted(todo!).then(
                                      (value) => {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(value),
                                            duration: const Duration(
                                                milliseconds: 500),
                                            backgroundColor: Colors.green,
                                          ),
                                        )
                                      },
                                    );
                              },
                              child: buildCallContainer(
                                'Patch',
                                const Color(0xFFFB8C00),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                todoController.updatePutCompleted(todo!).then(
                                      (value) => {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(value),
                                            duration: const Duration(
                                                milliseconds: 500),
                                            backgroundColor: Colors.blue,
                                          ),
                                        )
                                      },
                                    );
                              },
                              child: buildCallContainer(
                                'Put',
                                const Color(0xFF6D4C41),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                todoController.deleteTodo(todo!).then(
                                      (value) => {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(value),
                                            duration: const Duration(
                                                milliseconds: 500),
                                            backgroundColor: Colors.green,
                                          ),
                                        )
                                      },
                                    );
                              },
                              child: buildCallContainer(
                                'Del',
                                const Color(0xFFB71C1C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 0.5,
                  height: 0.5,
                );
              },
              itemCount: snapshot.data?.length ?? 0,
            ),
          );
        },
      ),
    );
  }

  Container buildCallContainer(String title, Color color) {
    return Container(
      width: 48.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
