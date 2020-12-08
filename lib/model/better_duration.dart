extension DurationString on Duration{
  String betterToString() {
    String properDuration = '';
    int hours = this.inHours;
    int minutes = this.inMinutes - (60 * hours);

    if (hours == 0 && minutes == 0) {
      return 'No set time';
    }

    if (hours != 0) {
      properDuration += '$hours hr ';
    }
    if (minutes != 0) {
      properDuration += '$minutes min';
    }

    return properDuration.trim();
  }
}