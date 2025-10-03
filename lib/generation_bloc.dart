import 'package:flutter_bloc/flutter_bloc.dart';
import 'fake_generation_api.dart';

// Events
abstract class GenerationEvent {}

class GenerateImage extends GenerationEvent {
  final String prompt;
  GenerateImage(this.prompt);
}

class TryAnother extends GenerationEvent {}

class NewPrompt extends GenerationEvent {}

// States
abstract class GenerationState {}

class GenerationInitial extends GenerationState {
  final String? prompt;
  GenerationInitial({this.prompt});
}

class GenerationLoading extends GenerationState {}

class GenerationSuccess extends GenerationState {
  final String imageUrl;
  final String prompt;
  GenerationSuccess(this.imageUrl, this.prompt);
}

class GenerationFailure extends GenerationState {
  final String message;
  final String prompt;
  GenerationFailure(this.message, this.prompt);
}

// Bloc
class GenerationBloc extends Bloc<GenerationEvent, GenerationState> {
  final FakeGenerationApi api;
  String? currentPrompt;

  GenerationBloc(this.api) : super(GenerationInitial()) {
    on<GenerateImage>((event, emit) async {
      currentPrompt = event.prompt;
      emit(GenerationLoading());
      try {
        final url = await api.generate(event.prompt);
        emit(GenerationSuccess(url, event.prompt));
      } catch (e) {
        emit(GenerationFailure(e.toString(), event.prompt));
      }
    });

    on<TryAnother>((event, emit) async {
      if (currentPrompt == null) return;
      emit(GenerationLoading());
      try {
        final url = await api.generate(currentPrompt!);
        emit(GenerationSuccess(url, currentPrompt!));
      } catch (e) {
        emit(GenerationFailure(e.toString(), currentPrompt!));
      }
    });

    on<NewPrompt>((event, emit) {
      emit(GenerationInitial(prompt: currentPrompt));
    });
  }
}
