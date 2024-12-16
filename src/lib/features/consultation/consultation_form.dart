import 'package:flutter/material.dart';
import '../ui/widgets/custom_text_field.dart';

class ConsultationForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;
  
  const ConsultationForm({
    Key? key,
    required this.onSubmit,
    this.isLoading = false,
  }) : super(key: key);

  @override
  ConsultationFormState createState() => ConsultationFormState();
}

class ConsultationFormState extends State<ConsultationForm> {
  final _formKey = GlobalKey<FormState>();
  final _chiefComplaintController = TextEditingController();
  final _notesController = TextEditingController();
  List<String> _symptoms = [];
  DateTime? _followUpDate;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _chiefComplaintController,
            label: 'Chief Complaint',
            validator: (value) => value?.isEmpty == true ? 'Required' : null,
            onEditingComplete: () {
              // Handle submission
            },
          ),
          // Add other form fields...
          ElevatedButton(
            onPressed: widget.isLoading ? null : _handleSubmit,
            child: widget.isLoading 
              ? const CircularProgressIndicator()
              : const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
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
  void dispose() {
    _chiefComplaintController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}