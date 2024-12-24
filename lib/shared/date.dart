import 'package:intl/intl.dart';

String dateToUTCSTring(DateTime dateTime) {
  final f = DateFormat('E, d MMM yyyy HH:mm:ss');
  final date = '${f.format(dateTime)} GMT';
  return date;
}
