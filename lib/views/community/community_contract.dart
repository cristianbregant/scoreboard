import 'package:scoreboard/views/_base/base_contract.dart';

abstract class CommunityViewContract extends BaseViewContract {}

abstract class CommunityViewModelContract
    extends BaseViewModelContract<CommunityState, CommunityViewContract> {}

class CommunityState extends BaseVMState {}
