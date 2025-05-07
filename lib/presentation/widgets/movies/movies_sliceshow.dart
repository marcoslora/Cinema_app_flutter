import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';

class MoviesSliceShow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSliceShow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        itemCount: movies.length,
        viewportFraction: 0.8,
        pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
              activeColor: color.primary,
              color: color.secondary,
            )),
        scale: 0.9,
        autoplay: true,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10),
        ),
      ],
    );
    return Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: DecoratedBox(
            decoration: decoration,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.backdropPath,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2));
                  }
                  return GestureDetector(
                    onTap: () {
                      context.push('/movie/${movie.id}');
                    },
                    child: FadeIn(child: child),
                  );
                }, fit: BoxFit.cover, width: double.infinity))));
  }
}
