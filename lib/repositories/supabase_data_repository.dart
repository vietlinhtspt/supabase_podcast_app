import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/base_model.dart';

class SupabaseDataRepository {
  Future createRow({
    required BaseModel data,
    required String table,
  }) async {
    return await Supabase.instance.client.from(table).insert(data.toMap());
  }

  Future<List> readRow({
    required String table,
    String? column,
    String? value,
  }) async {
    if (column != null) {
      final rows = await Supabase.instance.client
          .from(table)
          .select()
          .filter(column, 'eq', value);

      return rows as List;
    } else {
      return await Supabase.instance.client.from(table).select() as List;
    }
  }

  Future<PostgrestResponse<dynamic>> updateRow({
    required String table,
    required String id,
    required Map<dynamic, dynamic> values,
  }) async {
    return await Supabase.instance.client
        .from(table)
        .update(values)
        .eq('id', id);
  }

  Future<PostgrestResponse<dynamic>> deleteRow({
    required String table,
    required String id,
  }) async {
    return await Supabase.instance.client.from(table).delete().eq('id', id);
  }
}
