import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class QuestionnaireScreen extends StatefulWidget {
  final String image;
  final String imageResult;

  const QuestionnaireScreen({
    Key? key,
    required this.image,
    required this.imageResult,
  }) : super(key: key);

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text('Skin Disease Questionnaire'),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: FormBuilder(
          key: _fbKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                "Please fill out the form below to help us better assess your condition.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 25),

              FormBuilderTextField(
                name: 'name',
                decoration: _inputDecoration('Full Name'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(2),
                ]),
              ),
              const SizedBox(height: 15),

              FormBuilderTextField(
                name: 'age',
                decoration: _inputDecoration('Age'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.min(0),
                ]),
              ),
              const SizedBox(height: 15),

              FormBuilderRadioGroup<String>(
                name: 'gender',
                decoration: _inputDecoration('Gender'),
                options: ['Male', 'Female', 'Other']
                    .map((gender) => FormBuilderFieldOption(value: gender))
                    .toList(),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 15),

              FormBuilderCheckboxGroup<String>(
                name: 'symptoms',
                decoration: _inputDecoration('Symptoms'),
                options: ['Itching', 'Redness', 'Rashes', 'Peeling', 'Blisters']
                    .map((symptom) => FormBuilderFieldOption(value: symptom))
                    .toList(),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please select at least one symptom';
                    }
                    return null;
                  },
                ]),
              ),
              const SizedBox(height: 15),

              FormBuilderDropdown<String>(
                name: 'familyHistory',
                decoration: _inputDecoration('Family history of skin disease?'),
                items: ['Yes', 'No']
                    .map((history) =>
                        DropdownMenuItem(value: history, child: Text(history)))
                    .toList(),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 15),

              FormBuilderTextField(
                name: 'otherConditions',
                decoration: _inputDecoration('Other skin conditions (if any)'),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_fbKey.currentState?.saveAndValidate() ?? false) {
                      final formData = _fbKey.currentState!.value;

                      Navigator.pushNamed(
                        context,
                        '/results',
                        arguments: {
                          'image': widget.image,
                          'imageResult': widget.imageResult,
                          'questionnaire': formData,
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please complete the form properly.")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Submit Assessment',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
