import 'package:scoreboard/views/_base/base_contract.dart';

abstract class ProfileViewContract extends BaseViewContract {}

abstract class ProfileViewModelContract
    extends BaseViewModelContract<ProfileState, ProfileViewContract> {}

class ProfileState extends BaseVMState {}
