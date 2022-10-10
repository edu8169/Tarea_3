part of 'books_bloc.dart';

abstract class BooksEvent {
  const BooksEvent();

  @override
  List<Object> get props => [];
}

class BooksSearchedEvent extends BooksEvent {
  final String titleSearched;

  BooksSearchedEvent({required this.titleSearched});
}
