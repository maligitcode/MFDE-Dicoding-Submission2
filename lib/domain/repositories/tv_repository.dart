import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/common/failure.dart';

abstract class TVRepository {
  Future<Either<Failure, List<TV>>> getNowPlayingTV();
  Future<Either<Failure, List<TV>>> getPopularTV();
  Future<Either<Failure, TVDetail>> getTVDetail(int id);
  Future<Either<Failure, List<TV>>> getTVRecommendations(int id);
  Future<Either<Failure, List<TV>>> getTopRatedTV();
  Future<Either<Failure, List<TV>>> searchTV(String query);
  Future<Either<Failure, String>> saveWatchlist(TVDetail movie);
  Future<Either<Failure, String>> removeWatchlist(TVDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TV>>> getWatchlistTV();
}
