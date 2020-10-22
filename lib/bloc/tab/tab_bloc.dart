import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_notas/models/app_tab.dart';

import 'tab_event.dart';


class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.todos);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}
