import 'package:flutter/widgets.dart';
import 'package:alquranalkareem/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../model/ayat.dart';
import '../tafseer_data_client.dart';

List<Ayat>? ayaListNotFut;

class TranslateRepository {
  TafseerDataBaseClient? _client;
  BuildContext context;
  TranslateRepository(this.context) {
    _client = TafseerDataBaseClient.instance;
  }
  List<Ayat>? ayaListNotFut;
  String? tableName;


  Future<List<Ayat>> getPageTranslate(int pageNum) async {
    if (ayaListNotFut == null) {
      print('isReloading');
      Database? database = await _client?.database;
      List<Map>? results =
          await database?.rawQuery((" SELECT * FROM ${Ayat.tableName} "
              "LEFT JOIN ${BlocProvider.of<QuranCubit>(context).tableName} "
              "ON (${BlocProvider.of<QuranCubit>(context).tableName}.aya = ${Ayat.tableName}.Verse) AND (${BlocProvider.of<QuranCubit>(context).tableName}.sura = ${Ayat.tableName}.SuraNum) "
              "WHERE PageNum = $pageNum"));
      List<Ayat> ayaList = [];
      results?.forEach((result) {
        ayaList.add(Ayat.fromMap(result));
      });

      ayaListNotFut = ayaList;
      return ayaList;
    } else {
      return ayaListNotFut!;
    }
  }

  Future<List<Ayat>> getAyahTranslate(int surahNumber) async {
    Database? database = await _client?.database;
    List<Map>? results = await database?.rawQuery(("SELECT * FROM ${Ayat.tableName} "
        "LEFT JOIN ${BlocProvider.of<QuranCubit>(context).tableName} "
        "ON (${BlocProvider.of<QuranCubit>(context).tableName}.aya = ${Ayat.tableName}.Verse) AND (${BlocProvider.of<QuranCubit>(context).tableName}.sura = ${Ayat.tableName}.SuraNum) "
        "WHERE SuraNum = $surahNumber"));
    List<Ayat> ayaList = [];
    results?.forEach((result) {
      ayaList.add(Ayat.fromMap(result));
    });
    return ayaList;
  }
}
