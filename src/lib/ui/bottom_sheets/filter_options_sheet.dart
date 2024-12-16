import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/core/constants/colors.dart';

class FilterOptionsSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const FilterOptionsSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(request.title ?? ''),
          const SizedBox(height: 20),
          // Filter options here
          ElevatedButton(
            onPressed: () => completer(SheetResponse()),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}