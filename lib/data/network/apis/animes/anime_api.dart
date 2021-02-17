import 'dart:async';
import 'dart:convert';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/models/anime/anime_list.dart';
import 'package:boilerplate/models/recomendation/recomendation_list.dart';

class AnimeApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  AnimeApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<AnimeList> getAnimes() async {
    try {
      final res = await _dioClient
          .get(Endpoints.getAnimes, queryParameters: {"limit": 20000});
      return AnimeList.fromJson(res["results"]);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<bool> likeAnime(int animeId) async {
    try {
      await _dioClient.post(Endpoints.likeAnime, data: {"animeId": animeId});
      return true;
    } catch (e) {
      throw e;
    }
  }

  Future<RecomendationList> querryUserRecomendations(String userId) async {
    try {
      final resp = await _dioClient
          .post(Endpoints.querryUserRecomendations, data: {"itemId": userId});
      return RecomendationList.fromJson(jsonDecode(resp)["result"]);
    } catch (e) {
      throw e;
    }
  }
}
