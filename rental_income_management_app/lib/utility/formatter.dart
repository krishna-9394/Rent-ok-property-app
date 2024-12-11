class TFormatter {
  static String formatPhoneNumber(String phoneNumber) {
    // Assuming a 10-digit Indian phone number format: +917568814039
    if (phoneNumber.length == 10) {
      return '+91 $phoneNumber';
    } else if (phoneNumber.length == 13) {
      return '${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3)}';
    }
    // Add more custom phone number formatting logic for different formats if needed.
    return phoneNumber;
  }
}
