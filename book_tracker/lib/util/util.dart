import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDate(Timestamp timestamp) {
  return DateFormat.yMMMd().format(timestamp.toDate());
}
