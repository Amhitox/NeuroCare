import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neurocare/Screens/Client/add_medication_screen.dart';
import '../../utils/constants/colors.dart';

class ActiveMedicationsScreen extends StatelessWidget {
  ActiveMedicationsScreen({super.key});

  final List<Map<String, dynamic>> _medications = [
    {
      'name': 'Leviteracetam',
      'dosage': '500mg',
      'frequency': 'Twice Daily',
      'times': ['9:00 AM', '9:00 PM'],
      'nextDose': '9:00 PM',
      'pillsRemaining': 8,
      'instructions': 'Take with food',
      'color': Colors.blue,
    },
    {
      'name': 'Lamotrigine',
      'dosage': '200mg',
      'frequency': 'Once Daily',
      'times': ['10:00 AM'],
      'nextDose': '10:00 AM',
      'pillsRemaining': 30,
      'instructions': 'Take in the morning',
      'color': Colors.purple,
    },
    {
      'name': 'Valproic Acid',
      'dosage': '250mg',
      'frequency': 'Three times Daily',
      'times': ['8:00 AM', '2:00 PM', '8:00 PM'],
      'nextDose': '2:00 PM',
      'pillsRemaining': 60,
      'instructions': 'Take with meals',
      'color': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Active Medications',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddMedicationScreen()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _medications.length,
        itemBuilder: (context, index) {
          final medication = _medications[index];
          return _buildMedicationCard(context, medication);
        },
      ),
    );
  }

  Widget _buildMedicationCard(
      BuildContext context, Map<String, dynamic> medication) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: medication['color'].withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: medication['color'].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.medication,
                    color: medication['color'],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medication['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.titleLarge?.color,
                        ),
                      ),
                      Text(
                        medication['dosage'],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.color
                              ?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildPillsIndicator(context, medication['pillsRemaining']),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildInfoRow(
                  context,
                  'Frequency:',
                  medication['frequency'],
                  Icons.repeat,
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  context,
                  'Next Dose:',
                  medication['nextDose'],
                  Icons.access_time,
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  context,
                  'Instructions:',
                  medication['instructions'],
                  Icons.info_outline,
                ),
                const SizedBox(height: 12),
                _buildTimeChips(context, medication['times']),
              ],
            ),
          ),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildPillsIndicator(BuildContext context, int pillsRemaining) {
    final Color indicatorColor =
        pillsRemaining <= 10 ? Colors.red : AppColors.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: indicatorColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: indicatorColor),
      ),
      child: Text(
        '$pillsRemaining pills left',
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: indicatorColor,
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color:
              Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.titleMedium?.color,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeChips(BuildContext context, List<String> times) {
    return Wrap(
      spacing: 8,
      children: times.map((time) {
        return Chip(
          label: Text(
            time,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.primary,
            ),
          ),
          backgroundColor: AppColors.primary.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            context,
            'Edit',
            Icons.edit_outlined,
            AppColors.primary,
            () {},
          ),
          _buildActionButton(
            context,
            'Take Now',
            Icons.check_circle_outline,
            Colors.green,
            () {},
          ),
          _buildActionButton(
            context,
            'Refill',
            Icons.shopping_bag_outlined,
            Colors.orange,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color, size: 20),
      label: Text(
        label,
        style: GoogleFonts.poppins(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
