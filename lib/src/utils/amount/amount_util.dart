class AmountUtil {
  static String withCurrency(num amount, String devise) => "${formatAmount(amount)} $devise";

  static String formatAmount(num amount) {
    //max 2 decimals
    amount = double.parse(amount.toStringAsFixed(2));
    final amountString = amount.toString();

    final chars = amountString.split('.');
    final charters = chars[0].split('');
    String newString = '';
    for (int i = charters.length - 1; i >= 0; i--) {
      if ((charters.length - 1 - i) % 3 == 0 && i != charters.length - 1){
        newString = " $newString";
      }
      newString = charters[i] + newString;
    }

    try {
      int decimal = int.parse(chars[1]);
      if (decimal > 0) newString = "$newString.${chars[1]}";
    } catch (e) {}

    return newString;
  }
}
