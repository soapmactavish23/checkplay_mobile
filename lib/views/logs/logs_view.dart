import 'package:flutter/material.dart';

class LogsView extends StatefulWidget {
  const LogsView({super.key});

  @override
  State<LogsView> createState() => _LogsViewState();
}

class _LogsViewState extends State<LogsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
      ),
      body: Container(),
    );
  }
}
