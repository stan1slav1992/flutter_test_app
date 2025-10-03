import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'generation_bloc.dart';
import 'fake_generation_api.dart';
import 'prompt_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GenerationBloc(FakeGenerationApi()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prompt Generator',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const PromptScreen(),
      ),
    );
  }
}
