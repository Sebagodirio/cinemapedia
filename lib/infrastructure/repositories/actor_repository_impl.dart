import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasoruce datasoruce;

  ActorRepositoryImpl(this.datasoruce);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasoruce.getActorsByMovie(movieId);
  }
}
