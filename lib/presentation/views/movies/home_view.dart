import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);
    
    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppBar(),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              MoviesSlideshow(movies: moviesSlideShow),
              MovieHorizontalListView(
                movies: nowPlayingMovies,
                title: 'En cines',
                loadNextPage: () => {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()
                },
              ),
              MovieHorizontalListView(
                movies: upcomingMovies,
                title: 'Proximamente',
                loadNextPage: () => {
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage()
                },
              ),
              MovieHorizontalListView(
                movies: popularMovies,
                title: 'Populares',
                loadNextPage: () =>
                    {ref.read(popularMoviesProvider.notifier).loadNextPage()},
              ),
              MovieHorizontalListView(
                movies: topRatedMovies,
                title: 'Mejor calificadas',
                loadNextPage: () => {
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage()
                },
              ),
              const SizedBox(
                height: 10,
              )
            ],
          );
        },
        childCount: 1,
      ))
    ]);
  }
}
