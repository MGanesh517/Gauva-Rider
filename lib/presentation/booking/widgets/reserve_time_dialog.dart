import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';

import '../../../core/widgets/buttons/app_primary_button.dart';
import '../../../core/widgets/responsive_dialog/app_responsive_dialog.dart';

class ReserveTimeDialog extends StatefulWidget {
  const ReserveTimeDialog({super.key});

  @override
  State<ReserveTimeDialog> createState() => _ReserveTimeDialogState();
}

class _ReserveTimeDialogState extends State<ReserveTimeDialog> {
  DateTime selectedDate = DateTime.now().add(const Duration(minutes: 10));
  @override
  Widget build(BuildContext context) => AppResponsiveDialog(
      type: context.responsive(DialogType.bottomSheet, xl: DialogType.dialog),
      header: (
        Ionicons.calendar,
        'Reserve ride',
        'Select the exact date and time you wish your ride to be reserved',
      ),
      primaryButton: AppPrimaryButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Confirm & reserve'),
      ),
      secondaryButton: CupertinoButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel'),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: CupertinoDatePicker(
              initialDateTime: selectedDate,
              minimumDate: DateTime.now().add(const Duration(minutes: 5)),
              onDateTimeChanged: (date) {
                setState(
                  () {
                    selectedDate = date;
                  },
                );
              },
            ),
          )
        ],
      ),
    );
}
