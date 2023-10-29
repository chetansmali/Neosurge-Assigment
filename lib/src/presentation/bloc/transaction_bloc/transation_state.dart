part of 'transation_bloc.dart';

@immutable
abstract class TransationState {}

class TransactionInitial extends TransationState {}

class TransactionLoding extends TransationState {}

class TransactionLoded extends TransationState {
  final List<dynamic> details;
  TransactionLoded(this.details);
}

class TransactionError extends TransationState {
  final String error;

  TransactionError(this.error);
}
