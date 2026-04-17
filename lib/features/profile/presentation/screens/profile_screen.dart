import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import 'package:learnback/features/profile/presentation/providers/profile_provider.dart';
import 'package:learnback/features/skills/presentation/providers/skills_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _showAvatarPicker(
    BuildContext context,
    WidgetRef ref,
    String currentAvatar,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkBgSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Choose Avatar', style: AppTextStyles.headingSmall),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: 16,
                  itemBuilder: (context, index) {
                    final avatarName = 'avatar${index + 1}.png';
                    final isSelected = currentAvatar == avatarName;
                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(profileProvider.notifier)
                            .updateProfile(avatar: avatarName);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.colorFifth
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/avatars/$avatarName',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditFieldDialog(
    BuildContext context,
    WidgetRef ref,
    String field,
    String currentValue,
  ) {
    final controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.darkBgSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Edit $field',
            style: AppTextStyles.headingSmall.copyWith(color: Colors.white),
          ),
          content: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            cursorColor: AppColors.colorFifth,
            decoration: InputDecoration(
              hintText: 'Enter your $field...',
              hintStyle: TextStyle(
                color: AppColors.darkTextSecondary.withValues(alpha: 0.8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColors.darkBorder.withValues(alpha: 0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.colorFifth),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.darkTextSecondary),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final newValue = controller.text.trim();
                if (field == 'Name' && newValue.isEmpty)
                  return; // Basic validation

                if (field == 'Name') {
                  ref
                      .read(profileProvider.notifier)
                      .updateProfile(name: newValue);
                } else if (field == 'Bio') {
                  ref
                      .read(profileProvider.notifier)
                      .updateProfile(bio: newValue);
                }
                Navigator.pop(context);
              },
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final userSkillsAsync = ref.watch(userSkillsProvider);
    final userGoalsAsync = ref.watch(userGoalsProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/icons/logo.png', width: 40, height: 40),
                  const Text('Profile', style: AppTextStyles.headingLarge),
                  const Icon(Icons.more_vert, color: AppColors.blue, size: 28),
                ],
              ),
            ),

            Expanded(
              child: profileState.when(
                skipLoadingOnReload: true,
                data: (user) {
                  final avatar = user.avatar == null || user.avatar!.isEmpty
                      ? 'avatar5.png'
                      : user.avatar;

                  return RefreshIndicator(
                    color: AppColors.colorFifth,
                    backgroundColor: AppColors.darkBgSecondary,
                    onRefresh: () async {
                      ref.invalidate(profileProvider);
                      ref.invalidate(userSkillsProvider);
                      ref.invalidate(userGoalsProvider);
                    },
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.lg,
                      ),
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        // Avatar
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.blue,
                                    width: 3.5,
                                  ),
                                ),
                                child: profileState.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.colorFifth,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 60,
                                        backgroundColor:
                                            AppColors.darkBgSecondary,
                                        backgroundImage: AssetImage(
                                          'assets/avatars/$avatar',
                                        ),
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: profileState.isLoading
                                      ? null
                                      : () => _showAvatarPicker(
                                          context,
                                          ref,
                                          avatar!,
                                        ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: AppColors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      color: AppColors.darkBgPrimary,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),

                        // Big points card
                        _buildPointsCard(user.points),
                        const SizedBox(height: AppSpacing.xl),

                        // Stats: Goals and Skills
                        Row(
                          children: [
                            Expanded(
                              child: userGoalsAsync.when(
                                data: (goals) => _buildStatCard(
                                  'Learning Goals',
                                  goals.length.toString(),
                                  subtitle: goals.isEmpty
                                      ? 'Set some goals!'
                                      : null,
                                ),
                                loading: () => _buildStatCard(
                                  'Learning Goals',
                                  '...',
                                  isLoading: true,
                                ),
                                error: (err, stack) =>
                                    _buildStatCard('Learning Goals', '0'),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: userSkillsAsync.when(
                                data: (skills) => _buildStatCard(
                                  'Mastered Skills',
                                  skills.length.toString(),
                                  subtitle: skills.isEmpty
                                      ? 'Start learning!'
                                      : null,
                                ),
                                loading: () => _buildStatCard(
                                  'Mastered Skills',
                                  '...',
                                  isLoading: true,
                                ),
                                error: (err, stack) =>
                                    _buildStatCard('Mastered Skills', '0'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xl),

                        const Text(
                          'Personal Info',
                          style: AppTextStyles.headingSmall,
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Info Fields
                        _buildProfileField(
                          context,
                          'Name',
                          user.name,
                          isEditable: true,
                          onEdit: () => _showEditFieldDialog(
                            context,
                            ref,
                            'Name',
                            user.name,
                          ),
                        ),
                        _buildProfileField(
                          context,
                          'Bio',
                          user.bio ?? '',
                          isEditable: true,
                          onEdit: () => _showEditFieldDialog(
                            context,
                            ref,
                            'Bio',
                            user.bio ?? '',
                          ),
                        ),
                        _buildProfileField(
                          context,
                          'Email',
                          user.email,
                          isEditable: false,
                        ),

                        const SizedBox(height: AppSpacing.xxl),
                      ],
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.colorFifth),
                ),
                error: (e, _) => Center(
                  child: Text(
                    'Error loading profile',
                    style: AppTextStyles.errorText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsCard(int points, {bool isLoading = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.colorFifth, AppColors.colorSixth],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Icon(Icons.stars_rounded, color: Colors.white, size: 48),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Total Points',
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isLoading ? '...' : points.toString(),
            style: AppTextStyles.displayLarge.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value, {
    String? subtitle,
    bool isLoading = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.darkBorder.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.headingLarge.copyWith(
              color: AppColors.colorFifth,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.colorFifth.withValues(alpha: 0.8),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProfileField(
    BuildContext context,
    String label,
    String value, {
    bool isEditable = false,
    VoidCallback? onEdit,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value.isEmpty ? 'Not provided' : value,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: value.isEmpty
                        ? AppColors.darkTextSecondary
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          if (isEditable)
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: AppColors.colorFifth,
                size: 20,
              ),
              onPressed: onEdit,
            ),
        ],
      ),
    );
  }
}
