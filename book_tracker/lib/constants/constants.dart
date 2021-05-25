import 'dart:ui';

const kBlackColor = Color(0xFF393939);
const kLightBlackColor = Color(0xFF8F8F8F);
const kIconColor = Color(0xFFF48A37);
const kProgressIndicator = Color(0xFFBE7066);
const kButtonColor = Color(0xFFBE7066);

const kLightPurple = Color(0xBA68C8d4);

final kShadowColor = Color(0xFFD3D3D3).withOpacity(.84);

double parseDouble(dynamic value) {
  try {
    if (value is int) {
      return double.parse(value.toString());
    } else if (value is double) {
      return value;
    } else {
      return 0.0;
    }
  } catch (e) {
    return null;
  }
}
