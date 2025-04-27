import 'package:cinema_app/config/helpers/numbers_formats.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../domain/entities/movie.dart';

class MovieHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListView(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListView> createState() =>
      _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {
  final scrollControler = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollControler.addListener(() {
      if (widget.loadNextPage == null) return;
      if (scrollControler.position.pixels + 200 >=
          scrollControler.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(children: [
        if (widget.title != null || widget.subTitle != null)
          _Title(label: widget.title, subLabel: widget.subTitle),
        Expanded(
            child: ListView.builder(
          controller: scrollControler,
          scrollDirection: Axis.horizontal,
          itemCount: widget.movies.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return FadeInRight(child: _Slide(movie: widget.movies[index]));
          },
        ))
      ]),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyle.titleSmall,
            ),
          ),
          SizedBox(
            width: 150,
            child: Row(
              children: [
                const Icon(
                  Icons.star_half_outlined,
                  color: Colors.amber,
                ),
                const SizedBox(width: 3),
                Text(
                  movie.voteAverage.toString(),
                  style: textStyle.bodyMedium?.copyWith(color: Colors.amber),
                ),
                const Spacer(),
                Text(
                  NumbersFormats.formatNumber(movie.popularity),
                  style: textStyle.bodySmall,
                ),
              ],
            ),
          )
        ]));
  }
}

class _Title extends StatelessWidget {
  final String? label;
  final String? subLabel;
  const _Title({this.label, this.subLabel});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label ?? '',
            style: titleStyle,
          ),
          if (subLabel != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subLabel!),
            )
        ],
      ),
    );
  }
}
