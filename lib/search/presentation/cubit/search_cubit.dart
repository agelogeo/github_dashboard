import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

const maxRecentSearches = 7;

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchIdle(recentSearches: []));

  void startSearching() =>
      emit(SearchActive(recentSearches: state.recentSearches));

  void stopSearching() =>
      emit(SearchIdle(recentSearches: state.recentSearches));

  void clearSearchHistory() {
    emit(state.copyWith(recentSearches: []));
  }

  void addSearchTerm(String term) {
    final newSearches = List<String>.from(state.recentSearches);
    if (term.isNotEmpty) {
      if (newSearches.contains(term)) {
        newSearches.remove(term);
      }
      if (newSearches.length > maxRecentSearches) {
        newSearches.removeLast();
      }
      newSearches.insert(0, term);
    }
    emit(SearchIdle(recentSearches: newSearches));
  }
}
