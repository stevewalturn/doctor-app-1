import 'package:flutter/material.dart';
import 'package:my_app/core/constants/colors.dart';
import 'package:my_app/core/constants/text_styles.dart';
import 'package:my_app/ui/widgets/custom_text_field.dart';
import 'package:my_app/ui/widgets/custom_button.dart';

class ConsultationForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ConsultationForm({
    Key? key,
    required this.onSubmit,
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<ConsultationForm> createState() => _ConsultationFormState();
}

class _ConsultationFormState extends State<ConsultationForm> {
  final _formKey = GlobalKey<FormState>();
  final _chiefComplaintController = TextEditingController();
  final _notesController = TextEditingController();
  final _newSymptomController = TextEditingController();
  final List<String> _symptoms = [];
  DateTime? _followUpDate;

  void _addSymptom(String symptom) {
    if (symptom.isNotEmpty && !_symptoms.contains(symptom)) {
      setState(() {
        _symptoms.add(symptom);
        _newSymptomController.clear();
      });
    }
  }

  void _removeSymptom(String symptom) {
    setState(() {
      _symptoms.remove(symptom);
    });
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() == true) {
      widget.onSubmit({
        'chiefComplaint': _chiefComplaintController.text,
        'symptoms': _symptoms,
        'notes': _notesController.text,
        'followUpDate': _followUpDate?.toIso8601String(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Chief Complaint',
            controller: _chiefComplaintController,
            maxLines: 3,
            validator: (value) => value?.isEmpty == true
                ? 'Please enter the chief complaint'
                : null,
          ),
          const SizedBox(height: 24),
          Text('Symptoms', style: TextStyles.label),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _newSymptomController,
                  hint: 'Add symptom',
                  onChanged: (value) => _addSymptom(value),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _addSymptom(_newSymptomController.text),
              ),
            ],
          ),
          if (_symptoms.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _symptoms
                    .map((symptom) => Chip(
                          label: Text(symptom),
                          deleteIcon: const Icon(Icons.close, size: 16),
                          onDeleted: () => _removeSymptom(symptom),
                        ))
                    .toList(),
              ),
            ),
          const SizedBox(height: 24),
          CustomTextField(
            label: 'Notes',
            controller: _notesController,
            maxLines: 5,
            hint: 'Add any additional notes...',
          ),
          const SizedBox(height: 24),
          ListTile(
            title: Text(
              'Follow-up Date',
              style: TextStyles.label,
            ),
            subtitle: Text(
              _followUpDate != null
                  ? '${_followUpDate!.day}/${_followUpDate!.month}/${_followUpDate!.year}'
                  : 'Not set',
              style: TextStyles.body1,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: _selectFollowUpDate,
            ),
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'Save Consultation',
            onPressed: widget.isLoading ? null : _handleSubmit,
            isLoading: widget.isLoading,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Future<void> _selectFollowUpDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _followUpDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _followUpDate = date;
      });
    }
  }

  @override
  void dispose() {
    _chiefComplaintController.dispose();
    _notesController.dispose();
    _newSymptomController.dispose();
    super.dispose();
  }
}