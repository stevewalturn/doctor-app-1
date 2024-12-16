import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  String get counterLabel => 'Counter is: $_counter';

  int _counter = 0;

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showDialog(
      title: 'Information',
      description: 'This is an info dialog',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showBottomSheet(
      title: 'Notice',
      description: 'This is a notice bottom sheet',
    );
  }
}