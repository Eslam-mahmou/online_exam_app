import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/Utils/colors_manager.dart';

class CustomPickerImage extends StatelessWidget {
  const CustomPickerImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: ColorsManager.greyColor,
            ),
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: ColorsManager.primaryColor),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: ColorsManager.whiteColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
