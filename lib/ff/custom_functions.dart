import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

String countParticipants(List<dynamic> metadata) {
  int count = metadata.where((item) => item['key'] == '_participant_id').length;
  return count.toString();
}

List<int> adentroInfo(List<dynamic> metadata) {
  try {
    var object = metadata.firstWhere((item) => item['key'] == 'adentro_info');
    return object["value"];
  } catch (e) {
    print('Ocurrió un error: $e');
    return [];
  }
}

String? findProductState(List<dynamic> metadata) {
  try {
    var object = metadata.firstWhere((item) => item['key'] == '_product_state');
    return object["value"];
  } catch (e) {
    print('Ocurrió un error: $e');
    return "N/A";
  }
}

String? filterPapeletas(
  dynamic metadata,
  int number,
) {
  String keyToFind = '_papeletas_option_$number';

  for (Map<String, dynamic> map in metadata) {
    if (map['key'] == keyToFind) {
      return map['value'];
    }
  }

  return 'N/A';
}

String maxParticipants(List<dynamic> metadata) {
  try {
    var object = metadata.firstWhere((item) => item['key'] == '_max_tickets');
    return object["value"].toString();
  } catch (e) {
    print('Ocurrió un error: $e');
    return "0";
  }
}

String productType(List<dynamic> metadata) {
  try {
    var object = metadata.firstWhere((item) => item['key'] == 'product_type');
    return object["value"].toString();
  } catch (e) {
    print('Ocurrió un error: $e');
    return "0";
  }
}

String totalViews(List<dynamic> metadata) {
  try {
    var object =
        metadata.firstWhere((item) => item['key'] == '_total_views_count');
    return object["value"].toString();
  } catch (e) {
    print('Ocurrió un error: $e');
    return "0";
  }
}

double? pocentParticipants(
  int? participants,
  String? maxParticipants,
) {
  // teniendo dos variables, participants y maxParticipants que es un string, obtiene rel potcentaje
  if (participants != null && maxParticipants != null) {
    double percentage = (participants / int.parse(maxParticipants));
    return percentage;
  } else {
    return 0;
  }
}

String? rifaType(List<dynamic> metadata) {
  try {
    var object = metadata.firstWhere((item) => item['key'] == '_tipo_rifa_1');
    return object["value"];
  } catch (e) {
    print('Ocurrió un error: $e');
    return "N/A";
  }
}

List<int> numberOfPapeletas(String length) {
  // genera una lista de objetos segun un valor pasado por parametro de un int
// The prompt is not clear on what exactly the function should do, so I will assume that it should generate a list of objects based on a given integer value.

  int value = int.parse(length); // example value
  List<int> myList = [];

  for (int i = 0; i < value; i++) {
    myList.add(i);
  }

  return myList;
}

double pricePerTicket(
  int price,
  String cant,
) {
  try {
    if (price != null) {
      return price / int.parse(cant);
    } else {
      return 0;
    }
  } catch (e) {
    return 0;
  }
}
