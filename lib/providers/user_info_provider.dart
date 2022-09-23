import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_info.dart';
import '../repositories/common.dart';
import '../repositories/supabase_data_repository.dart';

class UserInfoProvider extends ChangeNotifier {
  final _table = 'user_info';
  bool _isLoading = false;
  late SupabaseClient _client;
  StreamSubscription<List<Map<String, dynamic>>>? _userInfoStream;

  UserInfo? _userInfo;
  SupabaseDataRepository? _supabaseDataRepository;

  UserInfoProvider({SupabaseDataRepository? supabaseDataRepository}) {
    if (supabaseDataRepository != null) {
      _supabaseDataRepository = supabaseDataRepository;
    } else {
      _supabaseDataRepository = SupabaseDataRepository();
    }
    _client = Supabase.instance.client;
  }

  UserInfo? get userInfo => _userInfo;
  bool get isLoading => _isLoading;

  Future subcribe() async {
    if (_client.auth.currentUser?.email != null) {
      _userInfoStream?.cancel();
      _userInfoStream = Supabase.instance.client
          .from('$_table:email=eq.${_client.auth.currentUser!.email!}')
          .stream(['*']).listen((event) {
        print('subcribe: $event');
        if (event.isNotEmpty) {
          _userInfo = UserInfo.fromMap(event.first);
          notifyListeners();
        }
      });
    }
  }

  Future<UserInfo?> getUserInfo(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    await supabaseCallAPI(context, function: () async {
      final response = await _supabaseDataRepository?.readRow(
          table: _table,
          column: 'email',
          value: _client.auth.currentUser?.email);
      if (response != null && response.isNotEmpty) {
        _userInfo = UserInfo.fromMap(response.first);
      } else {
        _userInfo = UserInfo();
      }
    });

    _isLoading = false;
    notifyListeners();

    return _userInfo;
  }

  Future<UserInfo?> createName(
    BuildContext context, {
    required String name,
  }) async {
    await supabaseCallAPI(context, function: () async {
      await _supabaseDataRepository?.createRow(
          table: _table,
          data: UserInfo(
            name: name,
            email: _client.auth.currentUser?.email,
          ));
      subcribe();
      _userInfo = await getUserInfo(context);
    });

    return _userInfo;
  }

  Future<bool> changeName(
    BuildContext context, {
    required String name,
  }) async {
    var isSuccess = false;
    await supabaseCallAPI(context, function: () async {
      await _supabaseDataRepository?.updateRow(
          table: _table,
          keyName: 'email',
          keyValue: _client.auth.currentUser!.email!,
          values: {'name': name.trim()});

      isSuccess = true;
    });

    return isSuccess;
  }

  Future<bool> changeThemeMode(BuildContext context, {bool? value}) async {
    var isSuccess = false;
    await supabaseCallAPI(context, function: () async {
      await _supabaseDataRepository?.updateRow(
          table: _table,
          keyName: 'email',
          keyValue: _client.auth.currentUser!.email!,
          values: {'is_dark_mode': value ?? !(_userInfo?.isDarkMode ?? false)});

      isSuccess = true;
    });

    return isSuccess;
  }

  Future<bool> changeLanguage(
    BuildContext context, {
    required String newLanguage,
  }) async {
    var isSuccess = false;
    await supabaseCallAPI(context, function: () async {
      await _supabaseDataRepository?.updateRow(
          table: _table,
          keyName: 'email',
          keyValue: _client.auth.currentUser!.email!,
          values: {'language': newLanguage});

      isSuccess = true;
    });

    return isSuccess;
  }
}
