import 'package:flutter/material.dart';
import 'package:my_app/core/constants/colors.dart';
import 'package:my_app/core/constants/text_styles.dart';
import 'package:my_app/ui/widgets/custom_button.dart';

class FilterOptionsSheet extends StatefulWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final String title;
  final Function(List<String>) onApply;

  const FilterOptionsSheet({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.title,
    required this.onApply,
  });

  @override
  State<FilterOptionsSheet> createState() => _FilterOptionsSheetState();
}

class _FilterOptionsSheetState extends State<FilterOptionsSheet> {
  late List<String> _selectedOptions;

  @override
  void initState() {
    super.initState();
    _selectedOptions = List.from(widget.selectedOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title, style: TextStyles.h3),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                final option = widget.options[index];
                final isSelected = _selectedOptions.contains(option);
                return CheckboxListTile(
                  title: Text(option, style: TextStyles.body1),
                  value: isSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _selectedOptions.add(option);
                      } else {
                        _selectedOptions.remove(option);
                      }
                    });
                  },
                  activeColor: AppColors.primary,
                  checkColor: AppColors.white,
                  contentPadding: EdgeInsets.zero,
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Clear All',
                  onPressed: () {
                    setState(() {
                      _selectedOptions.clear();
                    });
                  },
                  isOutlined: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: 'Apply',
                  onPressed: () {
                    widget.onApply(_selectedOptions);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
