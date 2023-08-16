// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_expenses_list_repo.dart';

class ExpensesViewModel extends GetxController {
  ApiResponse getExpensesListApiResponse = ApiResponse.initial('INITIAL');

  /// GET EXPENSES LIST
  Future<void> getExpensesList() async {
    getExpensesListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetExpenseRepo().getExpenseList();
      getExpensesListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getExpensesListApiResponse ERROR :=> $e');
      getExpensesListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
