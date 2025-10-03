import 'dart:async';
import 'dart:math';

class FakeGenerationApi {
  Future<String> generate(String prompt) async {
    await Future.delayed(const Duration(seconds: 2));
    final rnd = Random().nextBool();

    if (rnd) {
      // success: return image url
      return "https://picsum.photos/400?random=${DateTime.now().millisecondsSinceEpoch}";
    } else {
      // fail: throw error
      throw Exception("Generation failed. Please try again.");
    }
  }
}
