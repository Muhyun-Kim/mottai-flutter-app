import 'package:mottai_flutter_app/controllers/bottom_navigation_bar/bottom_navigation_bar_state.dart';
import 'package:state_notifier/state_notifier.dart';

class BottomNavigationBarController extends StateNotifier<BottomNavigationBarState>
    with LocatorMixin {
  BottomNavigationBarController() : super(BottomNavigationBarState(currentIndex: 0));

  /// 表示中の BottomNavigationBar を更新する。
  void changeTab(int index) {
    state = state.copyWith(currentIndex: index);
  }
}
