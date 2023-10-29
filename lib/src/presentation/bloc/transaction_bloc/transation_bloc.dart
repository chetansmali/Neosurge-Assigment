import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:neosurge_finance/src/data/repositories/get_transaction_repositoies.dart';
part 'transation_event.dart';
part 'transation_state.dart';

class TransationBloc extends Bloc<TransationEvent, TransationState> {
  final _repositry = GetTransaction();

  TransationBloc() : super(TransactionInitial()) {
    on<TransationEvent>(_fetchTransaction);
  }

  void _fetchTransaction(TransationEvent event,Emitter<TransationState> emit) async{
    emit(TransactionLoding());
    try{
      final item =await _repositry.getDataRep();
      emit(TransactionLoded(item));
    }
    catch(e){
      emit(TransactionError(e.toString()));
    }
  }
  void updateTotalAmount() async {
    final dataList = await _repositry.getDataRep();
    double totalExpense = 0.0;
    double totalIncome = 0.0;
    for (var entry in dataList) {
      if (entry['category'] == 'expense') {
        totalExpense += entry['amount'];
      }
    }
    for (var entry in dataList) {
      if (entry['category'] == 'income') {
        totalIncome += entry['amount'];
      }
    }
    final totalExpenseList = [totalExpense];
    final totalIncomeList = [totalIncome];
    emit(TransactionLoded(totalExpenseList));
    emit(TransactionLoded(totalIncomeList));
  }
}
