part of 'transation_bloc.dart';

@immutable
abstract class TransationEvent {}

class FetchTransationEvent extends TransationEvent {}