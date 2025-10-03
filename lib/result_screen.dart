import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'generation_bloc.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Result")),
      body: BlocBuilder<GenerationBloc, GenerationState>(
        builder: (context, state) {
          if (state is GenerationLoading) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text("Generating...")
                ],
              ),
            );
          } else if (state is GenerationSuccess) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      child: Image.network(
                        state.imageUrl,
                        key: ValueKey(state.imageUrl), // 👈 важно для анимации
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<GenerationBloc>().add(TryAnother());
                      },
                      child: const Text("Try another"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<GenerationBloc>().add(NewPrompt());
                        Navigator.pop(context);
                      },
                      child: const Text("New prompt"),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            );
          } else if (state is GenerationFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GenerationBloc>().add(TryAnother());
                    },
                    child: const Text("Retry"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GenerationBloc>().add(NewPrompt());
                      Navigator.pop(context);
                    },
                    child: const Text("New prompt"),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
