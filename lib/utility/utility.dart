import 'dart:convert';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoder2/geocoder2.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart' as geo;

import 'app_string.dart';


class Utility {
  static Widget progress({Color? color}) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? Colors.black,
      ),
    );
  }

  static void toast({
    required String? message,
    Color? color,
    Color? textcolor,
  }) {
    if (message != null)
      Fluttertoast.showToast(
        msg: message,
        textColor: textcolor ?? Colors.white,
        backgroundColor: color ?? Colors.green,
      );
  }

  static Future setPref({required String key, required String value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  static Future<String?> getPref({required String key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString(
      key,
    );
    return token;
  }

  // static setUser({required UserModel user, required String key}) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   final users = jsonEncode(user);
  //   pref.setString(key, users);
  // }

  // static setWhatYouNeed(int userId) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();

  //   // final users = pref.getStringList(AppString.whatYouNeedKey) ?? <String>[];
  //   if (!users.contains(userId.toString())) {
  //     pref.setStringList(
  //         AppString.whatYouNeedKey, [...users, userId.toString()]);
  //   }
  // }



  // static Future<bool> getWhatYouNeed(int userid) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();

  //   final user = pref.getStringList(AppString.whatYouNeedKey) ?? <String>[];

  //   return user.contains(userid.toString());
  // }

  // static Future<UserModel?> getUser({required String key}) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   final user = pref.getString(
  //     key,
  //   );
  //   if (user != null) {
  //     final userModel = UserModel.fromJson(jsonDecode(user));
  //     return userModel;
  //   }
  //   return null;
  // }

  static String timeStamp(String time) {
    int timestamp = (int.tryParse(time) ?? 0);
    DateTime day = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime currentDay = DateTime.now();
    if (day.day == currentDay.day &&
        day.month == currentDay.month &&
        day.year == currentDay.year) {
      String date = DateFormat.jm().format(day.toLocal());
      return date;
    } else {
      String date = DateFormat.jm().add_yMd().format(day.toLocal());
      return date;
    }
  }

  // static Future<Locale> getLangauge() async {
  //   try {
  //     SharedPreferences pref = await SharedPreferences.getInstance();
  //     final langaugeString = pref.getString(AppString.languageKey);

  //     if (langaugeString != null) {
  //       return langaugeString == 'en'
  //           ? const Locale('en', '')
  //           : const Locale('it', '');
  //     }
  //     return const Locale('en', '');
  //   } catch (e) {
  //     return const Locale('en', '');
  //   }
  // }

  static Future<void> clearPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  static Future<void> clearUserPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(AppString.userToken);
    // pref.remove(AppString.userPrefKey);
  }

  static Widget noDataWidget({required String text}) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }

  static Map<String, String> mapGenrator(
      {required List<String> list, required String key, String? key2}) {
    Map<String, String> map = {};
    for (int i = 0; i < list.length; i++) {
      if (list.isNotEmpty) {
        map['$key[$i]' + (key2 ?? '')] = list[i];
      }
    }
    return map;
  }

  // static Widget imageLoader(
  //     {required String? url,
  //     String? placeholder,
  //     required BoxFit fit,
  //     required BuildContext context,
  //     BorderRadius? borderRadius,
  //     BoxShape? shape}) {
  //   if (url == null || url.trim().isEmpty && !url.startsWith('http') && placeholder != null ) {
  //     return Container(
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //             image: AssetImage(placeholder!), scale: 2),
  //         shape: shape ?? BoxShape.circle,
  //       ),
  //     );
  //   } else {
  //     return CachedNetworkImage(
  //       imageUrl: url,
  //       imageBuilder: (context, imageProvider) => Container(
  //         decoration: BoxDecoration(
  //           shape: shape ?? BoxShape.circle,
  //           borderRadius: borderRadius ?? null,
  //           image: DecorationImage(
  //             image: imageProvider,
  //             fit: fit,
  //           ),
  //         ),
  //       ),
  //       errorWidget: (context, error, dynamic a) => Container(
  //         decoration: BoxDecoration(
  //           borderRadius: borderRadius ?? null,
  //           image: DecorationImage(
  //               image: AssetImage(placeholder!)),
  //           shape: shape ?? BoxShape.circle,
  //         ),
  //       ),
  //       placeholder: (context, url) => progress(),
  //     );
  //   }
  // }

  // Future getCurrentLocation(Function(LatLng?) oncomplte) async {
  //   await checkPermission(
  //     onSucess: () async {
  //       final isServiceEnable = await Location().serviceEnabled();
  //       if (isServiceEnable) {
  //         final position = await geo.Geolocator.getCurrentPosition();
  //         // currentLocation = LatLng(position.latitude, position.longitude);
  //         oncomplte(LatLng(position.latitude, position.longitude));
  //       } else {
  //         Location().requestService().then((value) async {
  //           if (value) {
  //             final position = await geo.Geolocator.getCurrentPosition();
  //             // currentLocation = LatLng(position.latitude, position.longitude);
  //             oncomplte(LatLng(position.latitude, position.longitude));
  //             // getRequests(isFirst: true);
  //           }
  //         });
  //       }
  //     },
  //     onDenied: () {
  //       oncomplte(null);
  //       Utility.toast(message: 'location Permission is required');
  //     },
  //     permission: Permission.location,
  //   );
  // }

  Future<void> checkPermission({
    required void Function() onSucess,
    void Function()? onDenied,
    required Permission permission,
  }) async {
    PermissionStatus permissionStatus = await permission.status;
    switch (permissionStatus) {
      case PermissionStatus.granted:
        print('-------');
        print('Permission Granted');
        print('-------');
        onSucess();

        break;

      case PermissionStatus.denied:
        print('-------');
        print('Permission Denied');
        print('-------');

        await permission.request().then((value) {
          if (value == PermissionStatus.granted) {
            onSucess();
          } else {
            if (onDenied != null) onDenied();
          }
        });
        break;

      case PermissionStatus.permanentlyDenied:
        print('--------');
        print('Permission Never Ask Again');
        print('--------');
        if (onDenied != null) onDenied();
        openAppSettings();
        break;

      // case 4 for Permission Unknown

      case PermissionStatus.limited:
        print('--------');
        print('Permission Unknown');
        print('--------');

        await permission.request().then((value) {
          if (value == PermissionStatus.granted) {
            onSucess();
          } else {
            if (onDenied != null) onDenied();
          }
        });
        break;

      // case 5 for Permission Restricted

      case PermissionStatus.restricted:
        print('--------');
        print('Permission Restricted');
        print('--------');
        if (onDenied != null) onDenied();

        openAppSettings();
        break;

      // default open setting

      default:
        await permission.request().then((value) {
          if (value == PermissionStatus.granted) {
            onSucess();
          } else {
            if (onDenied != null) onDenied();
          }
        });
    }
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  // static Future<GeoData> getGeoData({
  //   required double latitude,
  //   required double longitude,
  // }) async {
  //   final geoData = await Geocoder2.getDataFromCoordinates(
  //     googleMapApiKey: AppString.googleMapApiKey,
  //     latitude: latitude,
  //     longitude: longitude,
  //   );
  //   return geoData;
  // }

  static int? durationToMinutes({required String? time}) {
    try {
      final list = time?.split(':');
      final hour = int.tryParse(list?[0] ?? '');
      final minutes = int.tryParse(list?[1] ?? '');
      if (hour != null && minutes != null) {
        return (hour * 60) + minutes;
      }
    } catch (e) {}
    return null;
  }

  static String? minutesToDuration({required String? time}) {
    final t1 = int.tryParse(time ?? '');
    if (t1 != null) {
      final t = t1 ~/ 60;
      return "$t:${t1 - (t * 60)}";
    }
    return "Not specified";
  }

  static String? timeInBrief({required String? time}) {
    final t1 = int.tryParse(time ?? '');
    if (t1 != null && t1 > 60) {
      final t = t1 ~/ 60;
      return "$t hr ${t1 - (t * 60)} min";
    } else if (t1 != null) {
      return "$t1 min";
    }
    return "Not specified";
  }
}

class MyArc extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double _kCurveHeight = 32.0;
    final p = Path();

    p.lineTo(0, size.height - _kCurveHeight);
    p.relativeQuadraticBezierTo(
        size.width / 2, -1.9 * _kCurveHeight, size.width, 0);
    p.lineTo(size.width, 0);
    p.close();

    canvas.drawPath(p, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
