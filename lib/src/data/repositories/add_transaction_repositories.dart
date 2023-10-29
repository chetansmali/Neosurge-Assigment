import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class TransactionRepositories{
  final int amount;
  final String date;
  final String category;
  final String description;

  TransactionRepositories({
    required this.category,
    required this.amount,
    required this.date,
    required this.description,
  });
  User? user= FirebaseAuth.instance.currentUser;

  late String userId;

   void pushData(){
    if(user != null){
      userId = user!.uid;
    }

    DatabaseReference expenseRef = FirebaseDatabase.instance
        .reference()
        .child('$userId/expenses')
        .push();

    expenseRef.set({
      'amount': amount,
      'category': category,
      'date': date,
      'description': description,
      'timestamp': ServerValue.timestamp,
    });
  }
}