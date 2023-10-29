import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class GetTransaction {
  User? user = FirebaseAuth.instance.currentUser;
  final ref = FirebaseDatabase.instance.ref();
  late String userId;



  Future<List<dynamic>> getDataRep() async {
    if (user != null) {
      userId = user!.uid;
      print(" the user id id : $userId");
    }

    final snapshot = await ref.child('$userId/expenses').get();
    if (snapshot.exists) {
      print("Getting data from firebase...! ");
      print('');

      if (snapshot.value != null) {
        List<dynamic> dataList = [];

        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          dataList.add(value);
        });
        // expenseList.assignAll(dataList
        //     .where((entry) => entry['category'] == 'expense')
        //     .map((entry) => entry['amount']));
        //
        // incomeList.assignAll(dataList
        //     .where((entry) => entry['category'] == 'income')
        //     .map((entry) => entry['amount']));

        return dataList;
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load posts');
    }
  }
}



//   void getData() async {
//     if (user != null) {
//       userId = user!.uid;
//       print(" the user id id : $userId");
//     }
//
//
//     final snapshot = await ref.child('$userId/expenses').get();
//     if (snapshot.exists) {
//       print("Getting data from firebase...! ");
//       print('');
//       print(snapshot.value);
//     } else {
//       print('No data available.');
//     }
//   }
// }