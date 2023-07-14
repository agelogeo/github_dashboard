part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState({required this.recentSearches});

  final List<String> recentSearches;

  @override
  List<Object> get props => [];

  SearchState copyWith({List<String>? recentSearches});
}

class SearchIdle extends SearchState {
  const SearchIdle({required super.recentSearches});

  @override
  List<Object> get props => [recentSearches];

  @override
  SearchIdle copyWith({List<String>? recentSearches}) {
    return SearchIdle(recentSearches: recentSearches ?? this.recentSearches);
  }
}

class SearchActive extends SearchState {
  const SearchActive({required super.recentSearches});

  @override
  List<Object> get props => [recentSearches];

  @override
  SearchActive copyWith({List<String>? recentSearches}) {
    return SearchActive(recentSearches: recentSearches ?? this.recentSearches);
  }
}
