import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tarea_3/Repositorio/http.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  List<dynamic> books = [];
  BooksBloc() : super(BooksInitial()) {
    on<BooksSearchedEvent>(_searchedBook);
    // TODO: implement event handler
  }

  FutureOr<void> _searchedBook(BooksSearchedEvent event, Emitter emit) async {
    emit(BooksSearchState());
    final HttpRequests req = new HttpRequests();
    dynamic body = await req.getBook(event.titleSearched);
    if (body["totalItems"] == 0 || body == null) {
      emit(BooksNotFoundState(errorMessage: "Book not found"));
    } else {
      books = List.of(body["items"]);
      emit(BooksFoundState());
    }
  }
}
