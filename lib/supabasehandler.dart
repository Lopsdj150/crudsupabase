import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class SupaBaseHandler {
  static String supaBaseURL = "https://rfpujtldzlgcqebgradl.supabase.co";
  static String supaBaseKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyODk4ODIzNywiZXhwIjoxOTQ0NTY0MjM3fQ.Rt3zJQJ0UuiuI2byhQfSzIaPN7qPIB2OEWkZEJ1ChrE";

  final client = SupabaseClient(supaBaseURL, supaBaseKey);

  addData(String taskValue, bool statusValue) {
    var response = client
        .from("todotable")
        .insert({'task': taskValue, 'status': statusValue}).execute();
    print(response);
  }

  readData() async {
    var response = await client
        .from("todotable")
        .select()
        .order('task', ascending: true)
        .execute();
    print(response);
    final dataList = response.data as List;
    return dataList;
  }

  updateData(int id, bool statusValue) async {
    var response = client
        .from("todotable")
        .update({'status': statusValue})
        .eq('id', id)
        .execute();
    print(response);
  }

  delete(int id) {
    var response = client.from('todotable').delete().eq('id', id).execute();
    print(response);
  }
}
