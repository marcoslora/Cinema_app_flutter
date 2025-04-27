import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(moviesSlidesShowProvider);
  final step2 = ref.watch(popularMoviesProvider);
  final step3 = ref.watch(topRatedMoviesProvider);
  final step4 = ref.watch(upComingMoviesProvider);
  if (step1.isEmpty || step2.isEmpty || step3.isEmpty || step4.isEmpty) {
    return true;
  }

  return false;
});
