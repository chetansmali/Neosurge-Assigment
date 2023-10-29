import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosurge_finance/src/presentation/bloc/transaction_bloc/transation_bloc.dart';
import 'package:neosurge_finance/src/presentation/widgets/app_bar.dart';

class TransationScreen extends StatefulWidget {
  const TransationScreen({super.key});
  static String id = 'TransationScreen';

  @override
  State<TransationScreen> createState() => _TransationScreenState();
}

class _TransationScreenState extends State<TransationScreen> {

  @override
  Widget build(BuildContext context) {

   // final itemBloc =BlocProvider.of<TransationBloc>(context);
   // itemBloc.add(FetchTransationEvent());

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(name: 'Transaction',),

        body: BlocBuilder<TransationBloc,TransationState>(
          builder: (context,state){
            if(state is TransactionLoding){
              return CircularProgressIndicator();
            }else if(state is TransactionLoded){
              final data = state.details;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context,index){
                  final res = data[index];
                  int d = res['amount'];
                  final String dataNow = '* $d';
                  return Padding(
                    padding: const EdgeInsets.only(top: 10,right: 10,left: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      tileColor: Colors.grey,
                      title: Text(dataNow),
                      subtitle: Text(res['description']),
                      leading: Text(res['category']),
                      trailing: Text(res['date']),
                    ),
                  );
                },
              );
            }else if(state is TransactionError){
              return Center(child: Text(state.error),
              );
            }else{
              return Center(child: Text('Press the refresh button'),);
            }
          },
        ),
      ),
    );
  }
}
