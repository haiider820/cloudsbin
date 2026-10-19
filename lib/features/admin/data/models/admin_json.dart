/// Lenient JSON helper for admin payloads.
///
/// USD amounts on the admin wire may arrive as decimal strings (`"84.00"`)
/// or numbers (`84.0`); [moneyString] normalises both to a display string so
/// freezed parsing never fails on either shape.
String? moneyString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}
