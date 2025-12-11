import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/generated/l10n.dart';

import '../../../core/theme/animation_duration.dart';
import '../../../core/widgets/buttons/app_primary_button.dart';
import '../../../core/widgets/responsive_dialog/app_responsive_dialog.dart';
import '../provider/profile_photo_upload_provider.dart';
import '../provider/selected_profile_avatar_provider.dart';
import 'preset_avatar_item.dart';
import 'upload_image_field.dart';

class SelectProfileImageDialog extends StatefulWidget {
  const SelectProfileImageDialog({super.key});

  @override
  State<SelectProfileImageDialog> createState() => _SelectProfileImageDialogState();
}

class _SelectProfileImageDialogState extends State<SelectProfileImageDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isSaving = false;

  @override
  Widget build(BuildContext context) => AppResponsiveDialog(
    type: context.responsive(DialogType.bottomSheet, xl: DialogType.dialog),
    header: (Ionicons.person_circle, AppLocalizations.of(context).select_profile_image, null),
    primaryButton: Consumer(
      builder: (context, ref, _) {
        final selectedAvatar = ref.watch(selectedProfileAvatarNotifierProvider);
        final profilePhotoUploadState = ref.watch(profilePhotoUploadNotifierProvider);
        final profilePhotoNotifier = ref.read(profilePhotoUploadNotifierProvider.notifier);

        return AnimatedSwitcher(
          duration: AnimationDuration.pageStateTransitionMobile,
          child: AppPrimaryButton(
            isLoading: profilePhotoUploadState.whenOrNull(loading: () => true) ?? false,
            isDisabled: profilePhotoUploadState.whenOrNull(loading: () => true) ?? false,
            onPressed: () async {
              if (selectedAvatar.value2 != null) {
                String imagePath = selectedAvatar.value2!;
                if (selectedAvatar.value1 != null) {
                  imagePath = await profilePhotoNotifier.getImagePathFromLocalAsset(imagePath: selectedAvatar.value2!);
                } else {
                  imagePath = selectedAvatar.value2!;
                }
                profilePhotoNotifier.updateProfilePhoto(imagePath: imagePath);
              }
            },
            child: Text(AppLocalizations.of(context).save, style: context.bodyMedium),
          ),
        );
      },
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Consumer(
          builder: (context, ref, _) {
            final selectedAvatar = ref.watch(selectedProfileAvatarNotifierProvider);
            final notifier = ref.read(selectedProfileAvatarNotifierProvider.notifier);
            return UploadImageField(
              imageUrl: selectedAvatar.value1 != null ? null : selectedAvatar.value2,
              onChanged: (media) {
                notifier
                  ..reset()
                  ..selectRemoteAvatar(path: media);
              },
              uploadButtonText: AppLocalizations.of(context).upload_image,
            );
          },
        ),
        const SizedBox(height: 16),
        Text(AppLocalizations.of(context).or_select_avatar, style: context.titleSmall),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: Consumer(
            builder: (context, ref, _) {
              final selectedAvatar = ref.watch(selectedProfileAvatarNotifierProvider);
              final notifier = ref.read(selectedProfileAvatarNotifierProvider.notifier);
              return SingleChildScrollView(
                child: Wrap(
                  children: [
                    for (var i = 1; i <= 30; i++)
                      PresetAvatarItem(
                        index: i,
                        onPressed: (value) => notifier.selectLocalAvater(index: value.value1, path: value.value2),
                        selectedIndex: selectedAvatar.value1,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
