import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/ui/bottom_sheets/filter_options_sheet.dart';

enum BottomSheetType {
  filter,
}

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.filter: (context, request, completer) => FilterOptionsSheet(
          request: request as SheetRequest,
          completer: completer as Function(SheetResponse),
        ),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}