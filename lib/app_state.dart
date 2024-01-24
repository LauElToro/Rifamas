import 'package:flutter/material.dart';
import 'ff/request_manager.dart';
import '/backend/backend.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ff/ff_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      if (prefs.containsKey('ff_jwtuser')) {
        try {
          _jwtuser = jsonDecode(prefs.getString('ff_jwtuser') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _loggedIn = prefs.getBool('ff_loggedIn') ?? _loggedIn;
    });
    _safeInit(() {
      _favorites =
          prefs.getStringList('ff_favorites')?.map(int.parse).toList() ??
              _favorites;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _search = '';
  String get search => _search;
  set search(String _value) {
    _search = _value;
  }

  dynamic _jwtuser;
  dynamic get jwtuser => _jwtuser;
  set jwtuser(dynamic _value) {
    _jwtuser = _value;
    prefs.setString('ff_jwtuser', jsonEncode(_value));
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  set loggedIn(bool _value) {
    _loggedIn = _value;
    prefs.setBool('ff_loggedIn', _value);
  }

  String _maximoCuotas = '1';
  String get maximoCuotas => _maximoCuotas;
  set maximoCuotas(String _value) {
    _maximoCuotas = _value;
  }

  String _maximoSorteos = '1';
  String get maximoSorteos => _maximoSorteos;
  set maximoSorteos(String _value) {
    _maximoSorteos = _value;
  }

  String _nombreRegalo = '';
  String get nombreRegalo => _nombreRegalo;
  set nombreRegalo(String _value) {
    _nombreRegalo = _value;
  }

  String _fechaSorteo = '';
  String get fechaSorteo => _fechaSorteo;
  set fechaSorteo(String _value) {
    _fechaSorteo = _value;
  }

  String _descripcionRegalo = '';
  String get descripcionRegalo => _descripcionRegalo;
  set descripcionRegalo(String _value) {
    _descripcionRegalo = _value;
  }

  String _tituloMembresia = '';
  String get tituloMembresia => _tituloMembresia;
  set tituloMembresia(String _value) {
    _tituloMembresia = _value;
  }

  String _descripcionMembresia = '';
  String get descripcionMembresia => _descripcionMembresia;
  set descripcionMembresia(String _value) {
    _descripcionMembresia = _value;
  }

  int _idMembresy = 0;
  int get idMembresy => _idMembresy;
  set idMembresy(int _value) {
    _idMembresy = _value;
  }

  String _urlMemebresia = '';
  String get urlMemebresia => _urlMemebresia;
  set urlMemebresia(String _value) {
    _urlMemebresia = _value;
  }

  String _currentBalance = '0,0';
  String get currentBalance => _currentBalance;
  set currentBalance(String _value) {
    _currentBalance = _value;
  }

  List<int> _favorites = [];
  List<int> get favorites => _favorites;
  set favorites(List<int> _value) {
    _favorites = _value;
    prefs.setStringList(
        'ff_favorites', _value.map((x) => x.toString()).toList());
  }

  void addToFavorites(int _value) {
    _favorites.add(_value);
    prefs.setStringList(
        'ff_favorites', _favorites.map((x) => x.toString()).toList());
  }

  void removeFromFavorites(int _value) {
    _favorites.remove(_value);
    prefs.setStringList(
        'ff_favorites', _favorites.map((x) => x.toString()).toList());
  }

  void removeAtIndexFromFavorites(int _index) {
    _favorites.removeAt(_index);
    prefs.setStringList(
        'ff_favorites', _favorites.map((x) => x.toString()).toList());
  }

  void updateFavoritesAtIndex(
    int _index,
    int Function(int) updateFn,
  ) {
    _favorites[_index] = updateFn(_favorites[_index]);
    prefs.setStringList(
        'ff_favorites', _favorites.map((x) => x.toString()).toList());
  }

  void insertAtIndexInFavorites(int _index, int _value) {
    _favorites.insert(_index, _value);
    prefs.setStringList(
        'ff_favorites', _favorites.map((x) => x.toString()).toList());
  }

  String _numberOfTickets = '';
  String get numberOfTickets => _numberOfTickets;
  set numberOfTickets(String _value) {
    _numberOfTickets = _value;
  }

  List<int> _ticketsSelected = [];
  List<int> get ticketsSelected => _ticketsSelected;
  set ticketsSelected(List<int> _value) {
    _ticketsSelected = _value;
  }

  void addToTicketsSelected(int _value) {
    _ticketsSelected.add(_value);
  }

  void removeFromTicketsSelected(int _value) {
    _ticketsSelected.remove(_value);
  }

  void removeAtIndexFromTicketsSelected(int _index) {
    _ticketsSelected.removeAt(_index);
  }

  void updateTicketsSelectedAtIndex(
    int _index,
    int Function(int) updateFn,
  ) {
    _ticketsSelected[_index] = updateFn(_ticketsSelected[_index]);
  }

  void insertAtIndexInTicketsSelected(int _index, int _value) {
    _ticketsSelected.insert(_index, _value);
  }

  List<int> ticketsPicked = [];
  void addPickedTicket(int item) {
    ticketsPicked.add(item);
  }

  void clearPickedTicket() {
    ticketsPicked = [];
  }

  final _membershipCacheManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> membershipCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _membershipCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearMembershipCacheCache() => _membershipCacheManager.clear();
  void clearMembershipCacheCacheKey(String? uniqueKey) =>
      _membershipCacheManager.clearRequest(uniqueKey);

  final _categoriesCacheManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> categoriesCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _categoriesCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCategoriesCacheCache() => _categoriesCacheManager.clear();
  void clearCategoriesCacheCacheKey(String? uniqueKey) =>
      _categoriesCacheManager.clearRequest(uniqueKey);
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
