import 'package:gap/gap.dart';

import '../../../utils/utils.dart';

class Spacers {
  Spacers._();


  static Gap get sw1 => Gap(SizerHelper.w(1));
  static Gap get sw2 => Gap(SizerHelper.w(2));
  static Gap get sw3 => Gap(SizerHelper.w(3));
  static Gap get sw4 => Gap(SizerHelper.w(4));
  static Gap get sw5 => Gap(SizerHelper.w(5));
  static Gap get sw6 => Gap(SizerHelper.w(6));
  static Gap get sw8 => Gap(SizerHelper.w(8));
  static Gap get sw10 => Gap(SizerHelper.w(10));
  static Gap get sw20 => Gap(SizerHelper.w(20));
  static Gap get sw30 => Gap(SizerHelper.w(30));

  static Gap space(num value) => Gap(SizerHelper.w(value));

  static Gap get min => Gap(SizerHelper.w(3));
  static Gap get medium => Gap(SizerHelper.w(5));
  static Gap get large => Gap(SizerHelper.w(10));
}