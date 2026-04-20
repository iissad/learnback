import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import 'package:learnback/features/profile/presentation/providers/profile_provider.dart';
import 'package:learnback/features/skills/presentation/providers/skills_provider.dart';
import 'package:learnback/features/courses/presentation/providers/courses_provider.dart';
import 'package:learnback/features/courses/domain/models/course.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  int _activeTabIndex = 0;

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

  void _showEditProfileDialog(
    BuildContext context,
    WidgetRef ref,
    String currentName,
    String? currentBio,
  ) {
    final nameController = TextEditingController(text: currentName);
    final bioController = TextEditingController(text: currentBio ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.darkBgSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Edit Profile', style: AppTextStyles.headingSmall),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: const TextStyle(
                    color: AppColors.darkTextSecondary,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.darkBorder.withValues(alpha: 0.5),
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.colorFifth),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: bioController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Bio',
                  labelStyle: const TextStyle(
                    color: AppColors.darkTextSecondary,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.darkBorder.withValues(alpha: 0.5),
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.colorFifth),
                  ),
                ),
              ),
            ],
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
                final newName = nameController.text.trim();
                final newBio = bioController.text.trim();

                if (newName.isNotEmpty) {
                  ref
                      .read(profileProvider.notifier)
                      .updateProfile(name: newName, bio: newBio);
                }
                Navigator.pop(context);
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: AppColors.blue,
                      size: 28,
                    ),
                    onPressed: () {
                      profileState.whenData((user) {
                        _showEditProfileDialog(
                          context,
                          ref,
                          user.name,
                          user.bio,
                        );
                      });
                    },
                  ),
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
                                          color: AppColors.blue,
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
                        const SizedBox(height: AppSpacing.md),

                        // Name, Email, Bio
                        Center(
                          child: Column(
                            children: [
                              Text(
                                user.name,
                                style: AppTextStyles.headingLarge,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.email,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.darkTextSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (user.bio != null && user.bio!.isNotEmpty) ...[
                                const SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.xl,
                                  ),
                                  child: Text(
                                    user.bio!,
                                    style: AppTextStyles.bodyLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
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
                            const SizedBox(width: AppSpacing.md),
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
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xxl),

                        // Rewards Section
                        DefaultTabController(
                          length: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TabBar(
                                isScrollable: true,
                                tabAlignment: TabAlignment.start,
                                indicatorColor: AppColors.colorFifth,
                                labelColor: AppColors.colorFifth,
                                unselectedLabelColor:
                                    AppColors.darkTextSecondary,
                                dividerColor: Colors.transparent,
                                onTap: (index) {
                                  setState(() {
                                    _activeTabIndex = index;
                                  });
                                },
                                tabs: const [
                                  Tab(text: 'Rewards store'),
                                  Tab(text: 'Unlocked'),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.md),
                              // Conditional Rendering instead of TabBarView for dynamic height
                              if (_activeTabIndex == 0)
                                ref
                                    .watch(availableCoursesProvider)
                                    .when(
                                      data: (courses) => courses.isEmpty
                                          ? const Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 20,
                                                ),
                                                child: Text(
                                                  'No courses available',
                                                  style:
                                                      AppTextStyles.bodyMedium,
                                                ),
                                              ),
                                            )
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: courses.length,
                                              itemBuilder: (context, index) {
                                                return _buildCourseItem(
                                                  courses[index],
                                                );
                                              },
                                            ),
                                      loading: () => const Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 20,
                                          ),
                                          child: CircularProgressIndicator(
                                            color: AppColors.colorFifth,
                                          ),
                                        ),
                                      ),
                                      error: (e, _) => Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 20,
                                          ),
                                          child: Text(
                                            'Error loading courses',
                                            style: AppTextStyles.errorText,
                                          ),
                                        ),
                                      ),
                                    )
                              else
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Text(
                                      'No unlocked courses yet',
                                      style: AppTextStyles.bodyMedium,
                                    ),
                                  ),
                                ),
                            ],
                          ),
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
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.colorFifth, AppColors.colorSixth],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.stars_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Points',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                isLoading ? '...' : points.toString(),
                style: AppTextStyles.headingLarge.copyWith(color: Colors.white),
              ),
            ],
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.darkTextPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.headingLarge.copyWith(
              color: AppColors.blueLight,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.blueLight,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCourseItem(Course course) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${course.requiredPoints} ',
                        style: AppTextStyles.headingMedium.copyWith(
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'pts',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.darkTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.lock_rounded, color: AppColors.darkTextSecondary),
        ],
      ),
    );
  }
}
