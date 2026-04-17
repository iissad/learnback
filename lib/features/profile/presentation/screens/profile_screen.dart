import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/features/profile/presentation/providers/profile_provider.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/icons/logo.png', width: 40, height: 40),
                  const Text('Profile', style: AppTextStyles.headingMedium),
                  const Icon(Icons.more_vert, color: Colors.white),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Avatar
            profileState.when(
              data: (user) {
                final avatar = user.avatar == ""
                    ? 'avatar5.png'
                    : user.avatar; // Fallback to avatar5.png
                return Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.darkBgSecondary,
                        backgroundImage: AssetImage('assets/avatars/$avatar'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _showAvatarPicker(context, ref, avatar!),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColors.colorFifth,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: AppColors.darkBgPrimary,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
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
          ],
        ),
      ),
    );
  }
}
