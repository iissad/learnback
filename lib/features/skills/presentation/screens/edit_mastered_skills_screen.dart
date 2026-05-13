import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import 'package:learnback/features/skills/presentation/providers/skills_provider.dart';
import 'package:learnback/features/skills/domain/models/skill.dart';
import 'package:learnback/features/skills/domain/models/user_skill.dart';

class EditMasteredSkillsScreen extends ConsumerStatefulWidget {
  const EditMasteredSkillsScreen({super.key});

  @override
  ConsumerState<EditMasteredSkillsScreen> createState() =>
      _EditMasteredSkillsScreenState();
}

class _EditMasteredSkillsScreenState
    extends ConsumerState<EditMasteredSkillsScreen> {
  // Map<skillId, level> for newly selected skills
  final Map<String, String> _selectedSkills = {};
  bool _isSaving = false;

  // Levels available for selection
  static const _levels = ['Beginner', 'Intermediate', 'Advanced'];

  Future<void> _pickLevel(Skill skill) async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.darkBgSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppSpacing.md,
                    left: AppSpacing.lg,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select level for "${skill.name}"',
                      style: AppTextStyles.headingSmall,
                    ),
                  ),
                ),
                const Divider(color: AppColors.darkBorder, height: 1),
                ..._levels.map(
                  (level) => ListTile(
                    title: Text(level, style: AppTextStyles.bodyLarge),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColors.blueLight,
                    ),
                    onTap: () => Navigator.pop(ctx, level),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedSkills[skill.id] = picked);
    }
  }

  void _toggleSkill(Skill skill) {
    if (_selectedSkills.containsKey(skill.id)) {
      setState(() => _selectedSkills.remove(skill.id));
    } else {
      _pickLevel(skill);
    }
  }

  Future<void> _save(List<UserSkill> userSkills) async {
    if (_selectedSkills.isEmpty) {
      Navigator.pop(context);
      return;
    }

    setState(() => _isSaving = true);

    try {
      final repo = ref.read(skillsRepositoryProvider);
      for (final entry in _selectedSkills.entries) {
        await repo.addUserSkill(entry.key, entry.value);
      }
      ref.invalidate(userSkillsProvider);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error saving skills: $e',
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
    final userSkillsAsync = ref.watch(userSkillsProvider);
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
        title: const Text('Mastered Skills', style: AppTextStyles.headingSmall),
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
          return userSkillsAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.blueLight),
            ),
            error: (e, _) => Center(
              child: Text(
                'Error loading your skills',
                style: AppTextStyles.errorText,
              ),
            ),
            data: (userSkills) {
              // Skills not yet in the user's list
              final userSkillIds = userSkills.map((s) => s.skillId).toSet();
              final availableSkills = allSkills
                  .where((s) => !userSkillIds.contains(s.id))
                  .toList();

              // Build a quick lookup: id -> name for userSkills
              final allSkillById = {for (final s in allSkills) s.id: s};

              return Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      // ── Your Current Skills ──────────────────────────
                      if (userSkills.isNotEmpty) ...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.lg,
                              AppSpacing.lg,
                              AppSpacing.lg,
                              0,
                            ),
                            child: Text(
                              'Your Skills',
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
                              final userSkill = userSkills[index];
                              final skill = allSkillById[userSkill.skillId];
                              final skillName =
                                  skill?.name ?? userSkill.skillId;
                              final isVerified =
                                  userSkill.source == 'verified' ||
                                  userSkill.source == 'match-completion';
                              return _UserSkillTile(
                                skillId: userSkill.skillId,
                                name: skillName,
                                level: userSkill.level,
                                isVerified: isVerified,
                              );
                            }, childCount: userSkills.length),
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
                              icon: Icons.school_outlined,
                              message: 'No skills added yet. Add some below!',
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
                                  'Add More Skills',
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
                            message: 'You\'ve added all available skills!',
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
                              final isSelected = _selectedSkills.containsKey(
                                skill.id,
                              );
                              return _AvailableSkillTile(
                                skill: skill,
                                isSelected: isSelected,
                                selectedLevel: _selectedSkills[skill.id],
                                onTap: () => _toggleSkill(skill),
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
                      label: _selectedSkills.isEmpty
                          ? 'Done'
                          : 'Save ${_selectedSkills.length} Skill${_selectedSkills.length > 1 ? 's' : ''}',
                      isLoading: _isSaving,
                      onPressed: () => _save(userSkills),
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

class _UserSkillTile extends StatelessWidget {
  const _UserSkillTile({
    required this.skillId,
    required this.name,
    required this.level,
    required this.isVerified,
  });

  final String skillId;
  final String name;
  final String level;
  final bool isVerified;

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
          color: isVerified
              ? AppColors.blueLight.withValues(alpha: 0.35)
              : AppColors.darkBorder.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  level,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (isVerified)
            _VerifiedBadge()
          else
            _VerifyButton(skillId: skillId, skillName: name),
        ],
      ),
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.blueLight.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.blueLight.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.verified_rounded,
            color: AppColors.blueLight,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            'Verified',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.blueLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerifyButton extends StatelessWidget {
  const _VerifyButton({required this.skillId, required this.skillName});

  final String skillId;
  final String skillName;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.blueLight, width: 1),
        foregroundColor: AppColors.blueLight,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      icon: const Icon(Icons.quiz_outlined, size: 14),
      label: Text(
        'Verify',
        style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
      ),
      onPressed: () {
        context.push(
          '/home/verify-skill/$skillId?name=${Uri.encodeComponent(skillName)}',
        );
      },
    );
  }
}

class _AvailableSkillTile extends StatelessWidget {
  const _AvailableSkillTile({
    required this.skill,
    required this.isSelected,
    required this.selectedLevel,
    required this.onTap,
  });

  final Skill skill;
  final bool isSelected;
  final String? selectedLevel;
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
              ? AppColors.blueLight.withValues(alpha: 0.08)
              : AppColors.darkBgSecondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.blueLight.withValues(alpha: 0.6)
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
                      color: isSelected ? AppColors.blueLight : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (isSelected && selectedLevel != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      selectedLevel!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.blueLight,
                      ),
                    ),
                  ] else if (skill.description != null &&
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
                      color: AppColors.blueLight,
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
