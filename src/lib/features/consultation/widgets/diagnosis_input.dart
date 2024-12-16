import 'package:flutter/material.dart';
import 'package:my_app/core/constants/colors.dart';
import 'package:my_app/core/constants/text_styles.dart';
import 'package:my_app/ui/widgets/custom_text_field.dart';
import 'package:my_app/ui/widgets/custom_button.dart';

class DiagnosisInput extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  final VoidCallback? onCancel;

  const DiagnosisInput({
    super.key,
    required this.onSave,
    this.onCancel,
  });

  @override
  State<DiagnosisInput> createState() => _DiagnosisInputState();
}

class _DiagnosisInputState extends State<DiagnosisInput> {
  final _formKey = GlobalKey<FormState>();
  final _conditionController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<String> _symptoms = [];
  final List<String> _treatments = [];
  final List<String> _medications = [];
  final _notesController = TextEditingController();
  final _newItemController = TextEditingController();

  void _addToList(List<String> list, String item) {
    if (item.isNotEmpty && !list.contains(item)) {
      setState(() {
        list.add(item);
        _newItemController.clear();
      });
    }
  }

  void _removeFromList(List<String> list, String item) {
    setState(() {
      list.remove(item);
    });
  }

  Widget _buildChipsList(List<String> items, Function(String) onRemove) {
    return Wrap(
      spacing: 8,
      children: items
          .map((item) => Chip(
                label: Text(item),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () => onRemove(item),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Condition',
            controller: _conditionController,
            validator: (value) =>
                value?.isEmpty == true ? 'Please enter the condition' : null,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Description',
            controller: _descriptionController,
            maxLines: 3,
            validator: (value) =>
                value?.isEmpty == true ? 'Please enter a description' : null,
          ),
          const SizedBox(height: 16),
          Text('Symptoms', style: TextStyles.label),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _newItemController,
                  hint: 'Add symptom',
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _addToList(_symptoms, _newItemController.text),
              ),
            ],
          ),
          _buildChipsList(
              _symptoms, (item) => _removeFromList(_symptoms, item)),
          const SizedBox(height: 16),
          Text('Treatments', style: TextStyles.label),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _newItemController,
                  hint: 'Add treatment',
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () =>
                    _addToList(_treatments, _newItemController.text),
              ),
            ],
          ),
          _buildChipsList(
              _treatments, (item) => _removeFromList(_treatments, item)),
          const SizedBox(height: 16),
          Text('Medications', style: TextStyles.label),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _newItemController,
                  hint: 'Add medication',
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () =>
                    _addToList(_medications, _newItemController.text),
              ),
            ],
          ),
          _buildChipsList(
              _medications, (item) => _removeFromList(_medications, item)),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Notes',
            controller: _notesController,
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              if (widget.onCancel != null)
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    onPressed: widget.onCancel!,
                    isOutlined: true,
                  ),
                ),
              if (widget.onCancel != null) const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: 'Save Diagnosis',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSave({
                        'condition': _conditionController.text,
                        'description': _descriptionController.text,
                        'symptoms': _symptoms,
                        'treatments': _treatments,
                        'medications': _medications,
                        'notes': _notesController.text,
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _conditionController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
    _newItemController.dispose();
    super.dispose();
  }
}
