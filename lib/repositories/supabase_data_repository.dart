import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/base_model.dart';

class SupabaseDataRepository {
  Future createRow({
    required BaseModel data,
    required String table,
  }) async {
    return await Supabase.instance.client.from(table).insert(data.toMap());
  }

  Future<RealtimeSubscription> subcribe({
    required String table,
    String keyName = 'id',
    required String keyValue,
    required Function(SupabaseRealtimePayload) callback,
  }) async {
    return Supabase.instance.client
        .from('$table:$keyName=eq.$keyValue')
        .on(SupabaseEventTypes.update, callback)
        .subscribe();
  }

  Future unsubcribe({
    required RealtimeSubscription subscription,
  }) async {
    return subscription.unsubscribe();
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

  Future<List> searchRow({
    required String table,
    required String column,
    required List<String> value,
  }) async {
    final rows = await Supabase.instance.client
        .from(table)
        .select()
        .filter(column, 'cs', value);

    return rows as List;
  }

  Future<dynamic> updateRow({
    required String table,
    String keyName = 'id',
    required String keyValue,
    required Map<dynamic, dynamic> values,
  }) async {
    return await Supabase.instance.client
        .from(table)
        .update(values)
        .eq(keyName, keyValue);
  }

  Future<PostgrestResponse<dynamic>> deleteRow({
    required String table,
    required String id,
  }) async {
    return await Supabase.instance.client.from(table).delete().eq('id', id);
  }
}
