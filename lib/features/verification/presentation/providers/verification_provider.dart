import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnback/features/skills/presentation/providers/skills_provider.dart';
import 'package:learnback/features/profile/presentation/providers/profile_provider.dart';
import 'package:learnback/features/verification/domain/models/skill_test.dart';

// ── Scoped Provider ──────────────────────────────────────────────────────────

/// Provides the current skill ID being verified.
/// Must be overridden in the UI using ProviderScope.
final currentSkillIdProvider = Provider<String>((ref) {
  throw UnimplementedError('currentSkillIdProvider must be overridden');
});

// ── State Model ─────────────────────────────────────────────────────────────

class QuizState {
  QuizState({
    required this.test,
    required List<String?> userAnswers,
    this.currentQuestionIndex = 0,
    this.isSubmitting = false,
    this.result,
  }) : userAnswers = List.from(userAnswers);

  final SkillTest test;
  final List<String?> userAnswers;
  final int currentQuestionIndex;
  final bool isSubmitting;
  final QuizSubmissionResponse? result;

  QuizState copyWith({
    SkillTest? test,
    List<String?>? userAnswers,
    int? currentQuestionIndex,
    bool? isSubmitting,
    QuizSubmissionResponse? result,
  }) {
    return QuizState(
      test: test ?? this.test,
      userAnswers: userAnswers ?? this.userAnswers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      result: result ?? this.result,
    );
  }
}

// ── Notifier ───────────────────────────────────────────────────────────────

class VerificationQuizNotifier extends AsyncNotifier<QuizState> {
  @override
  Future<QuizState> build() async {
    final skillId = ref.watch(currentSkillIdProvider);
    final repo = ref.read(skillsRepositoryProvider);
    final test = await repo.getSkillTest(skillId);

    return QuizState(
      test: test,
      userAnswers: List.filled(test.questions.length, null),
    );
  }

  void selectAnswer(String answer) {
    if (!state.hasValue) return;
    final current = state.value!;

    final answers = List<String?>.from(current.userAnswers);
    answers[current.currentQuestionIndex] = answer;
    state = AsyncData(current.copyWith(userAnswers: answers));
  }

  void nextQuestion() {
    if (!state.hasValue) return;
    final current = state.value!;

    if (current.currentQuestionIndex < current.test.questions.length - 1) {
      state = AsyncData(
        current.copyWith(
          currentQuestionIndex: current.currentQuestionIndex + 1,
        ),
      );
    }
  }

  Future<void> submit() async {
    if (!state.hasValue || state.value!.userAnswers.contains(null)) return;
    final current = state.value!;

    state = AsyncData(current.copyWith(isSubmitting: true));
    try {
      final repo = ref.read(skillsRepositoryProvider);
      final result = await repo.submitSkillTest(
        current.test.id,
        current.userAnswers.cast<String>(),
      );

      state = AsyncData(current.copyWith(isSubmitting: false, result: result));
      if (result.passed) {
        ref.invalidate(userSkillsProvider);
        ref.invalidate(profileProvider);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// ── Provider ───────────────────────────────────────────────────────────────

final verificationQuizProvider =
    AsyncNotifierProvider.autoDispose<VerificationQuizNotifier, QuizState>(
      VerificationQuizNotifier.new,
    );
