import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/search_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(SearchInitial());

  Future<void> searchUsers(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try {
      final users = await _searchRepository.searchUsers(query);
      emit(SearchSuccess(users));
    } catch (e) {
      emit(SearchFailure(e.toString()));
    }
  }
}
