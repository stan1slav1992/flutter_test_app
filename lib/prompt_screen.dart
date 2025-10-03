import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'generation_bloc.dart';
import 'result_screen.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isNotEmpty = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isNotEmpty = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prompt Generator")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Describe what you want to see...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isNotEmpty
                  ? () {
                      context
                          .read<GenerationBloc>()
                          .add(GenerateImage(_controller.text));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ResultScreen()),
                      );
                    }
                  : null,
              child: const Text("Generate"),
            ),
          ],
        ),
      ),
    );
  }
}
