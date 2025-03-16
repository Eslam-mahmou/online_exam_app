import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/presentation/layout/manager/layout_cubit/layout_state.dart';
import 'package:online_exam_app/presentation/layout/pages/explorePage/explore_page_view.dart';

import '../../pages/profilePage/profile_tab.dart';
import '../../pages/result/result_screen.dart';

class LayoutViewModel extends Cubit<LayoutState> {
  LayoutViewModel() : super(InitialLayoutState());
  int currentIndex = 0;
  List<Widget> tabs = [
    const ExplorePageView(),
    const ResultScreen(),
    ProfileTab(),
  ];

  void doIntent(LayoutIntent layoutIntent) {
    switch (layoutIntent) {
      case ChangeTabIntent():
        _changeTab(layoutIntent.index);
    }
  }

  void _changeTab(int index) {
    emit(InitialLayoutState());
    currentIndex = index;
    emit(ChangeTabState());
  }
}

sealed class LayoutIntent {}

class ChangeTabIntent extends LayoutIntent {
  final int index;

  ChangeTabIntent(this.index);
}
