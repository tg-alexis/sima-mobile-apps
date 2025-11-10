class GreetingUtil {
  static String greet() {
    var hour = DateTime.now().hour;
    if (hour < 18) {
      return 'Bonjour,';
    }
    return 'Bonsoir,';
  }
}
