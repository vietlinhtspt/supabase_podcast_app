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
    String? selectOption,
    String? value,
    String? orderID,
    bool ascending = false,
  }) async {
    var query =
        Supabase.instance.client.from(table).select(selectOption ?? '*');

    if (column != null) {
      query = query.filter(column, 'eq', value);
    }

    if (orderID != null) {
      return (await query.order(orderID, ascending: ascending)) as List;
    } else {
      return (await query) as List;
    }
  }

  Future<List> searchRow({
    required String table,
    required String column,
    required List<String> value,
  }) async {
    final rows =
        await Supabase.instance.client.from(table).select().in_(column, value);

    return rows as List;
  }

  Future<dynamic> updateRow({
    required String table,
    String keyName = 'id',
    required keyValue,
    String keyName2 = 'id',
    String? keyValue2,
    required Map<dynamic, dynamic> values,
  }) async {
    var query = Supabase.instance.client
        .from(table)
        .update(values)
        .eq(keyName, keyValue);
    if (keyValue2 != null) {
      query = query.eq(keyName2, keyValue2);
    }
    return await query;
  }

  Future<PostgrestResponse<dynamic>> deleteRow({
    required String table,
    required String id,
  }) async {
    return await Supabase.instance.client.from(table).delete().eq('id', id);
  }
}
