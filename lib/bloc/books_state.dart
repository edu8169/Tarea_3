part of 'books_bloc.dart';

@immutable
abstract class BooksState {
  const BooksState();

  @override
  List<Object> get props => [];
}

class BooksInitial extends BooksState {}

class BooksSearchState extends BooksState {}

class BooksFoundState extends BooksState {}

class BooksNotFoundState extends BooksState {
  final String errorMessage;

  BooksNotFoundState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
