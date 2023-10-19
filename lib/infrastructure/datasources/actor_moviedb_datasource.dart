import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasoruce {
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final dio = Dio(BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        queryParameters: {'api_key': Environment.apiKey}));
    final response = await dio.get('/movie/$movieId/credits');
    final castResponse = CreditsResponse.fromJson(response.data);
    return castResponse.cast.map((c) => ActorMapper.castToEntity(c)).toList();
  }
}
