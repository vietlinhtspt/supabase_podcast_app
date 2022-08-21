import 'package:flutter/material.dart';

import '../models/podcast_model.dart';
import '../repositories/common.dart';
import '../repositories/supabase_data_repository.dart';

class PodcastProvider extends ChangeNotifier {
  final _table = 'podcast_info';
  bool _isLoading = false;
  SupabaseDataRepository? _supabaseDataRepository;

  final _podcasts = <PodcastModel>[];

  bool get isLoading => _isLoading;
  List<PodcastModel> get podcast => _podcasts;

  PodcastProvider({SupabaseDataRepository? supabaseDataRepository}) {
    if (supabaseDataRepository != null) {
      _supabaseDataRepository = supabaseDataRepository;
    } else {
      _supabaseDataRepository = SupabaseDataRepository();
    }
  }

  Future<List<PodcastModel>> fetch(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    await supabaseCallAPI(context, function: () async {
      final response = await _supabaseDataRepository?.readRow(table: _table);
      if (response != null && response.isNotEmpty) {
        _podcasts.clear();
        _podcasts.addAll(response.map((e) => PodcastModel.fromMap(e)));
      }
    });

    _isLoading = false;
    notifyListeners();
    return podcast;
  }

  Future<List<PodcastModel>> search(
    BuildContext context, {
    required String column,
    required List<String> searchingText,
  }) async {
    // await supabaseCallAPI(context, function: () async {
    // final response = await _supabaseDataRepository?.searchRow(
    //   table: _table,
    //   column: column,
    //   value: searchingText,
    // );
    // if (response != null && response.isNotEmpty) {
    //   _podcasts.clear();
    //   _podcasts.addAll(response.map((e) => PodcastModel.fromMap(e)));
    // }
    // });

    return _podcasts
        .where((element) =>
            element.title
                ?.toLowerCase()
                .contains(searchingText.first.toLowerCase()) ??
            false)
        .toList();
  }
}
