import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import 'package:learnback/features/verification/presentation/providers/verification_provider.dart';

class VerificationQuizScreen extends StatelessWidget {
  const VerificationQuizScreen({
    super.key,
    required this.skillId,
    required this.skillName,
  });

  final String skillId;
  final String skillName;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        currentSkillIdProvider.overrideWithValue(skillId),
        verificationQuizProvider.overrideWith(VerificationQuizNotifier.new),
      ],
      child: _VerificationQuizScreenContent(skillName: skillName),
    );
  }
}

class _VerificationQuizScreenContent extends ConsumerWidget {
  const _VerificationQuizScreenContent({required this.skillName});

  final String skillName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizAsync = ref.watch(verificationQuizProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.darkBgPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.colorFifth,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text('Quiz', style: AppTextStyles.headingSmall),
        centerTitle: true,
      ),
      body: quizAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.colorFifth),
        ),
        error: (err, stack) => Center(
          child: Text(
            'Error: $err',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        data: (state) {
          final test = state.test;
          final currentIndex = state.currentQuestionIndex;
          final answers = state.userAnswers;
          final isSubmitting = state.isSubmitting;

          final currentQuestion = test.questions[currentIndex];
          final progress = (currentIndex) / test.questions.length;
          final isLastQuestion = currentIndex == test.questions.length - 1;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      skillName,
                      style: AppTextStyles.headingMedium.copyWith(
                        color: AppColors.colorFifth,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${currentIndex + 1}/${test.questions.length}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.darkTextSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${(progress * 100).round()}% completed',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.colorFifth,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.darkBgSecondary,
                    valueColor: const AlwaysStoppedAnimation(
                      AppColors.colorFifth,
                    ),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.darkBgSecondary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListView(
                        children: [
                          Text(
                            currentQuestion.question,
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          ...currentQuestion.options.asMap().entries.map((
                            entry,
                          ) {
                            final index = entry.key;
                            final option = entry.value;
                            final isSelected =
                                answers.length > currentIndex &&
                                answers[currentIndex] == option;
                            final letter = String.fromCharCode(65 + index);

                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.md,
                              ),
                              child: _OptionTile(
                                letter: letter,
                                text: option,
                                isSelected: isSelected,
                                onTap: () => ref
                                    .read(verificationQuizProvider.notifier)
                                    .selectAnswer(option),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _ActionButton(
                    label: isLastQuestion ? 'Submit' : 'Next',
                    isLoading: isSubmitting,
                    onPressed: () async {
                      if (isLastQuestion) {
                        try {
                          await ref
                              .read(verificationQuizProvider.notifier)
                              .submit();

                          if (context.mounted) {
                            final result = ref
                                .read(verificationQuizProvider)
                                .value
                                ?.result;
                            if (result != null) {
                              context.pushReplacement(
                                '/home/verify-result',
                                extra: result,
                              );
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        }
                      } else {
                        ref
                            .read(verificationQuizProvider.notifier)
                            .nextQuestion();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.letter,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String letter;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.colorFifth.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.colorFifth : AppColors.darkBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.colorFifth
                    : AppColors.darkBgPrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  letter,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : AppColors.colorFifth,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                text,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected
                      ? Colors.white
                      : AppColors.darkTextSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.colorFifth, AppColors.colorSixth],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(label, style: AppTextStyles.labelButton),
      ),
    );
  }
}
