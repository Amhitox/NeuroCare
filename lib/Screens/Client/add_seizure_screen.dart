import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/seizure_provider.dart';
import '../../utils/constants/colors.dart';

class AddSeizureScreen extends ConsumerStatefulWidget {
  const AddSeizureScreen({super.key});

  @override
  ConsumerState<AddSeizureScreen> createState() => _AddSeizureScreenState();
}

class _AddSeizureScreenState extends ConsumerState<AddSeizureScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedType = 'Tonic-Clonic';
  int _durationMinutes = 1;
  final List<String> _selectedTriggers = [];
  final _notesController = TextEditingController();
  final List<String> _selectedSymptoms = [];
  bool _wasAlerted = false;

  final List<String> _seizureTypes = [
    'Tonic-Clonic',
    'Absence',
    'Focal',
    'Myoclonic',
    'Atonic',
    'Other'
  ];

  final List<String> _commonTriggers = [
    'Stress',
    'Lack of Sleep',
    'Missed Medication',
    'Flashing Lights',
    'Illness',
    'Alcohol',
    'Dehydration',
    'Other'
  ];

  final List<String> _commonSymptoms = [
    'Aura',
    'Confusion',
    'Headache',
    'Fatigue',
    'Muscle Pain',
    'Memory Loss',
    'Nausea',
    'Other'
  ];

  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDate = pickedDate;
          _selectedTime = pickedTime;
        });
      }
    }
  }

  void _saveSeizure() {
    if (_formKey.currentState!.validate()) {
      final dateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      ref.read(seizureProvider.notifier).addSeizure(
            dateTime,
            _selectedType,
            Duration(minutes: _durationMinutes),
            _selectedTriggers,
            notes: _notesController.text,
            symptoms: _selectedSymptoms,
            wasAlerted: _wasAlerted,
          );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Record Seizure',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Date and Time'),
              ListTile(
                onTap: _selectDateTime,
                leading: const Icon(Icons.calendar_today),
                title: Text(
                  '${_selectedDate.toString().split(' ')[0]} ${_selectedTime.format(context)}',
                  style: GoogleFonts.poppins(),
                ),
                tileColor: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Seizure Type'),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _seizureTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Duration (minutes)'),
              Slider(
                value: _durationMinutes.toDouble(),
                min: 1,
                max: 30,
                divisions: 29,
                label: '$_durationMinutes min',
                onChanged: (value) {
                  setState(() {
                    _durationMinutes = value.round();
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Triggers'),
              Wrap(
                spacing: 8,
                children: _commonTriggers.map((trigger) {
                  final isSelected = _selectedTriggers.contains(trigger);
                  return FilterChip(
                    label: Text(trigger),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedTriggers.add(trigger);
                        } else {
                          _selectedTriggers.remove(trigger);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Symptoms'),
              Wrap(
                spacing: 8,
                children: _commonSymptoms.map((symptom) {
                  final isSelected = _selectedSymptoms.contains(symptom);
                  return FilterChip(
                    label: Text(symptom),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedSymptoms.add(symptom);
                        } else {
                          _selectedSymptoms.remove(symptom);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Notes'),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Add any additional notes...',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: Text(
                  'Emergency Contacts Alerted',
                  style: GoogleFonts.poppins(),
                ),
                value: _wasAlerted,
                onChanged: (value) {
                  setState(() {
                    _wasAlerted = value;
                  });
                },
                tileColor: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveSeizure,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Save Record',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).textTheme.titleLarge?.color,
        ),
      ),
    );
  }
}
