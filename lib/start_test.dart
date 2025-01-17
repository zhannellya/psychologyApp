import 'package:flutter/material.dart';
import 'package:psycho/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PsychoApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NameInputPage(),
    );
  }
}

class NameInputPage extends StatefulWidget {
  const NameInputPage({Key? key}) : super(key: key);

  @override
  _NameInputPageState createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  final TextEditingController _nameController = TextEditingController();
  bool _isReady = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тест'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Ваше имя',
              ),
              onChanged: (value) {
                setState(() {
                  _isReady = value.isNotEmpty;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: !_isReady
                  ? null
                  : () {
                      setState(() {
                        _isReady = false; // Reset to disable the button again
                      });
                      // Show the additional content
                      showDialog(
                        context: context,
                        builder: (context) {
                          bool _isChecked = false; // Manage checkbox state here
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Представьте себе, что все услышанное вами далее сказано от вашего имени человеком, который давно и хорошо вас знает. Кое-что из сказанного верно, подходит к вам, а кое-что — не верно, то есть вы с этим утверждением не согласны. Нажмите "Да" если вы согласны и  "Нет" если это утверждение не про вас. Не старайтесь долго рассуждать. Обычно то, что в начале приходит в голову и является наиболее точным ответом',
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StatefulBuilder(
                                      builder: (context, setState) {
                                        return Checkbox(
                                          value: _isChecked,
                                          onChanged: (value) {
                                            setState(() {
                                              _isChecked = value!;
                                            });
                                          },
                                        );
                                      },
                                    ),
                                    const Text(
                                      'Я хорошо прочитал всю инструкцию и готов к тесту !',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_isChecked) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const QuizScreen(),
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Дальше'),
                              ),
                            ],
                          );
                        },
                      );
                    },
              child: const Text('Дальше'),
            ),
          ],
        ),
      ),
    );
  }
}
