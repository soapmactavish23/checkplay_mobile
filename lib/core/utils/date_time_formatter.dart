extension DateTimeFormatter on DateTime {
  String convertDDMMYYYY() {
    String year = this.year.toString();
    String month = this.month < 10 ? "0${this.month}" : this.month.toString();
    String day = this.day < 10 ? "0${this.day}" : this.day.toString();
    return "$day/$month/$year";
  }

  String convertYYYYMMDD() {
    String year = this.year.toString();
    String month = this.month < 10 ? "0${this.month}" : this.month.toString();
    String day = this.day < 10 ? "0${this.day}" : this.day.toString();
    return "$year-$month-$day";
  }

  String convertToSendYYYYMMDDHHMMSS() {
    String year = this.year.toString();
    String month = this.month < 10 ? "0${this.month}" : this.month.toString();
    String day = this.day < 10 ? "0${this.day}" : this.day.toString();
    String hour = this.hour < 10 ? "0${this.hour}" : this.hour.toString();
    String minute =
        this.minute < 10 ? "0${this.minute}" : this.minute.toString();
    return "$year-$month-${day}T$hour:$minute:00";
  }

  String convertYYYYMMDDHHMMSS() {
    String year = this.year.toString();
    String month = this.month < 10 ? "0${this.month}" : this.month.toString();
    String day = this.day < 10 ? "0${this.day}" : this.day.toString();
    String hour = this.hour < 10 ? "0${this.hour}" : this.hour.toString();
    String minute =
        this.minute < 10 ? "0${this.minute}" : this.minute.toString();
    String second =
        this.second < 10 ? "0${this.second}" : this.second.toString();
    return "$day/$month/$year $hour:$minute:$second";
  }
}
