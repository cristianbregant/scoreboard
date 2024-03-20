import 'package:scoreboard/views/_base/base_contract.dart';

abstract class YourCompanyViewContract extends BaseViewContract {}

abstract class YourCompanyViewModelContract
    extends BaseViewModelContract<YourCompanyState, YourCompanyViewContract> {}

class YourCompanyState extends BaseVMState {}
