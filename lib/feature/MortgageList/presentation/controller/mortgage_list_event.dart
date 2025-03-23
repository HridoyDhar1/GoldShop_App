import 'package:equatable/equatable.dart';

abstract class MortgageListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMortgages extends MortgageListEvent {}

class SearchMortgages extends MortgageListEvent {
  final String query;

  SearchMortgages(this.query);

  @override
  List<Object> get props => [query];
}
