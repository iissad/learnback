import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import 'package:learnback/features/skills/presentation/providers/skills_provider.dart';
import 'package:learnback/features/skills/domain/models/skill.dart';

class EditLearningGoalsScreen extends ConsumerStatefulWidget {
  const EditLearningGoalsScreen({super.key});

  @override
  ConsumerState<EditLearningGoalsScreen> createState() =>
      _EditLearningGoalsScreenState();
}

class _EditLearningGoalsScreenState
    extends ConsumerState<EditLearningGoalsScreen> {
  final Set<String> _selectedSkillIds = {};
  bool _isSaving = false;

  void _toggleSkill(String skillId) {
    setState(() {
      if (_selectedSkillIds.contains(skillId)) {
        _selectedSkillIds.remove(skillId);
      } else {
        _selectedSkillIds.add(skillId);
      }
    });
  }

  Future<void> _save() async {
    if (_selectedSkillIds.isEmpty) {
      Navigator.pop(context);
      return;
    }

    setState(() => _isSaving = true);

    try {
      final repo = ref.read(skillsRepositoryProvider);
      for (final skillId in _selectedSkillIds) {
        await repo.addLearningGoal(skillId);
      }
      ref.invalidate(userGoalsProvider);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error saving goals: $e',
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userGoalsAsync = ref.watch(userGoalsProvider);
    final allSkillsAsync = ref.watch(allSkillsProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.darkBgPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.blueLight,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Learning Goals', style: AppTextStyles.headingSmall),
        centerTitle: true,
      ),
      body: allSkillsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.blueLight),
        ),
        error: (e, _) => Center(
          child: Text('Error loading skills', style: AppTextStyles.errorText),
        ),
        data: (allSkills) {
          return userGoalsAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.blueLight),
            ),
            error: (e, _) => Center(
              child: Text(
                'Error loading your goals',
                style: AppTextStyles.errorText,
              ),
            ),
            data: (userGoals) {
              final goalSkillIds = userGoals.map((g) => g.skillId).toSet();
              final availableSkills = allSkills
                  .where((s) => !goalSkillIds.contains(s.id))
                  .toList();

              // Build quick lookup: id -> skill
              final allSkillById = {for (final s in allSkills) s.id: s};

              return Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      // ── Your Current Goals ────────────────────────────
                      if (userGoals.isNotEmpty) ...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.lg,
                              AppSpacing.lg,
                              AppSpacing.lg,
                              0,
                            ),
                            child: Text(
                              'Your Goals',
                              style: AppTextStyles.headingSmall.copyWith(
                                color: AppColors.darkTextSecondary,
                              ),
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.sm,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final goal = userGoals[index];
                              final skill = allSkillById[goal.skillId];
                              final skillName = skill?.name ?? goal.skillId;
                              return _GoalTile(name: skillName);
                            }, childCount: userGoals.length),
                          ),
                        ),
                      ] else
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.lg,
                              AppSpacing.lg,
                              AppSpacing.lg,
                              AppSpacing.sm,
                            ),
                            child: _EmptySection(
                              icon: Icons.flag_outlined,
                              message:
                                  'No learning goals set yet. Add some below!',
                            ),
                          ),
                        ),

                      // ── Divider ──────────────────────────────────────
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.md,
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Divider(color: AppColors.darkBorder),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                ),
                                child: Text(
                                  'Add More Goals',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.darkTextSecondary,
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Divider(color: AppColors.darkBorder),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ── Available Skills ──────────────────────────────
                      if (availableSkills.isEmpty)
                        SliverToBoxAdapter(
                          child: _EmptySection(
                            icon: Icons.check_circle_outline,
                            message:
                                'You\'ve set a goal for every available skill!',
                          ),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.lg,
                            0,
                            AppSpacing.lg,
                            100,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final skill = availableSkills[index];
                              final isSelected = _selectedSkillIds.contains(
                                skill.id,
                              );
                              return _AvailableGoalTile(
                                skill: skill,
                                isSelected: isSelected,
                                onTap: () => _toggleSkill(skill.id),
                              );
                            }, childCount: availableSkills.length),
                          ),
                        ),
                    ],
                  ),

                  // ── Floating Save Button ──────────────────────────────
                  Positioned(
                    left: AppSpacing.lg,
                    right: AppSpacing.lg,
                    bottom: AppSpacing.lg,
                    child: _GradientSaveButton(
                      label: _selectedSkillIds.isEmpty
                          ? 'Done'
                          : 'Save ${_selectedSkillIds.length} Goal${_selectedSkillIds.length > 1 ? 's' : ''}',
                      isLoading: _isSaving,
                      onPressed: _save,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// ── Private widgets ────────────────────────────────────────────────────────────

class _GoalTile extends StatelessWidget {
  const _GoalTile({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.colorSixth.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.colorSixth,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              name,
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(Icons.flag_rounded, color: AppColors.colorSixth, size: 18),
        ],
      ),
    );
  }
}

class _AvailableGoalTile extends StatelessWidget {
  const _AvailableGoalTile({
    required this.skill,
    required this.isSelected,
    required this.onTap,
  });

  final Skill skill;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 4,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.colorSixth.withValues(alpha: 0.08)
              : AppColors.darkBgSecondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.colorSixth.withValues(alpha: 0.6)
                : AppColors.darkBorder.withValues(alpha: 0.25),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    skill.name,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: isSelected ? AppColors.colorSixth : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (skill.description != null &&
                      skill.description!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      skill.description!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.darkTextSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isSelected
                  ? const Icon(
                      Icons.check_circle_rounded,
                      key: ValueKey('checked'),
                      color: AppColors.colorSixth,
                    )
                  : Icon(
                      Icons.add_circle_outline_rounded,
                      key: const ValueKey('unchecked'),
                      color: AppColors.darkTextSecondary.withValues(alpha: 0.6),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GradientSaveButton extends StatelessWidget {
  const _GradientSaveButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          gradient: isLoading ? null : AppColors.ctaGradient,
          color: isLoading ? AppColors.darkBgSecondary : null,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isLoading
              ? []
              : [
                  BoxShadow(
                    color: AppColors.blueLight.withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.blueLight,
                  ),
                )
              : Text(label, style: AppTextStyles.labelButton),
        ),
      ),
    );
  }
}

class _EmptySection extends StatelessWidget {
  const _EmptySection({required this.icon, required this.message});
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.darkTextSecondary, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.darkTextSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
