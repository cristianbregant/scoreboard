// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_state.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget(this.state, {super.key});

  final BaseState state;

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}
