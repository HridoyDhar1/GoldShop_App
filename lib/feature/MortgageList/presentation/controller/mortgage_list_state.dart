import 'package:equatable/equatable.dart';
import '../../data/model/mortgage_model.dart';

abstract class MortgageListState extends Equatable {
  @override
  List<Object> get props => [];
}

class MortgageListInitial extends MortgageListState {}

class MortgageListLoading extends MortgageListState {}

class MortgageListLoaded extends MortgageListState {
  final List<MortgageModel> mortgages;

  MortgageListLoaded(this.mortgages);

  @override
  List<Object> get props => [mortgages];
}

class MortgageListError extends MortgageListState {
  final String message;

  MortgageListError(this.message);

  @override
  List<Object> get props => [message];
}
