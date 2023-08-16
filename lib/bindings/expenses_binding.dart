import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/expenses_viewmodel.dart';

class ExpensesListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ExpensesViewModel>(ExpensesViewModel(),
        tag: ExpensesViewModel().toString(),permanent: true);
  }
}
