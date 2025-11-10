import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../styles/styles.dart';
import '../../../utils/utils.dart';
import '../../common.dart';

class StepperWidget extends StatelessWidget {
  final int length;
  final bool isVertical;
  final num step;
  final double borderWidth;
  final double borderHeight;
  final Gap? spacer;

  const StepperWidget({super.key, this.spacer, this.length = 4, this.isVertical = false, this.step = -1, this.borderWidth = 5, this.borderHeight = 5});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isVertical ? SizerHelper.w(12) : null,
      height: isVertical ? null : SizerHelper.w(14),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
        itemCount: length,
        itemBuilder: (BuildContext context, int index) {
          if (index + 1 == length) {
            return Column(
              children: [
                stepperContainer(index),
              ],
            );
          }

          if (!isVertical) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                stepperContainer(index),
                spacer ?? Spacers.sw2,
                Container(
                  height: borderHeight,
                  width: borderWidth,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                spacer ?? Spacers.sw2,
              ],
            );
          }

          return Column(
            children: [
              stepperContainer(index),
              Container(
                height: borderHeight,
                width: borderWidth,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget stepperContainer(int position) {
    return Container(
      decoration: BoxDecoration(color: step == position ? AppColors.primaryColor : Colors.white, shape: BoxShape.circle, border: Border.all(color: AppColors.primaryColor)),
      padding: EdgeInsets.all(SizerHelper.w(3)),
      child: MediumText(
        "${position + 1}",
        color: step == position ? Colors.white : AppColors.primaryColor,
        fontSize: 19,
      ),
    );
  }
}
