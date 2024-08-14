String getMonthName(DateTime dateTime) {
  List<String> monthNames = [
    'janv.', 'févr.', 'mars', 'avr.', 'mai', 'juin', 
    'juil.', 'août', 'sept.', 'oct.', 'nov.', 'déc.'
  ];
  int monthIndex = dateTime.month - 1;
  return monthNames[monthIndex];
}