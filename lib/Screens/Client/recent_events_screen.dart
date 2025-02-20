import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants/colors.dart';

class RecentEventsScreen extends StatelessWidget {
  RecentEventsScreen({super.key});

  final List<Map<String, dynamic>> _ntEvents = [
    {
      'date': '2024-03-15',
      'time': '14:30',
      'duration': '2m 30s',
      'type': 'Focal Aware',
      'triggers': ['Stress', 'Lack of Sleep'],
      'symptoms': ['Confusion', 'Dizziness'],
      'location': 'Home',
      'notes': 'Occurred after a stressful meeting',
      'severity': 'Moderate',
    },
    {
      'date': '2024-03-12',
      'time': '09:15',
      'duration': '1m 45s',
      'type': 'Absence',
      'triggers': ['Missed Medication'],
      'symptoms': ['Brief Loss of Awareness'],
      'location': 'Office',
      'notes': 'Missed morning medication',
      'severity': 'Mild',
    },
    {
      'date': '2024-03-08',
      'time': '20:45',
      'duration': '3m 15s',
      'type': 'Tonic-Clonic',
      'triggers': ['Flashing Lights', 'Fatigue'],
      'symptoms': ['Muscle Stiffness', 'Confusion'],
      'location': 'Home',
      'notes': 'Watching TV with bright scenes',
      'severity': 'Severe',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recent Events',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _ntEvents.length,
        itemBuilder: (context, index) {
          final event = _ntEvents[index];
          return _buildEventCard(context, event);
        },
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Map<String, dynamic> event) {
    Color severityColor;
    switch (event['severity'].toLowerCase()) {
      case 'mild':
        severityColor = Colors.green;
        break;
      case 'moderate':
        severityColor = Colors.orange;
        break;
      case 'severe':
        severityColor = Colors.red;
        break;
      default:
        severityColor = Colors.grey;
    }

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
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.emergency,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['type'],
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${event['date']} at ${event['time']}',
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: severityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: severityColor),
                  ),
                  child: Text(
                    event['severity'],
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: severityColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildInfoRow(
                    context, 'Duration:', event['duration'], Icons.timer),
                const SizedBox(height: 8),
                _buildInfoRow(context, 'Location:', event['location'],
                    Icons.location_on_outlined),
                const SizedBox(height: 12),
                _buildTagSection(context, 'Triggers:', event['triggers']),
                const SizedBox(height: 12),
                _buildTagSection(context, 'Symptoms:', event['symptoms']),
                if (event['notes'].isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildNotesSection(context, event['notes']),
                ],
              ],
            ),
          ),
          Container(
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
                  'Share',
                  Icons.share_outlined,
                  Colors.blue,
                  () {},
                ),
                _buildActionButton(
                  context,
                  'Delete',
                  Icons.delete_outline,
                  Colors.red,
                  () {},
                ),
              ],
            ),
          ),
        ],
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

  Widget _buildTagSection(
      BuildContext context, String title, List<String> tags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tag,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.primary,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNotesSection(BuildContext context, String notes) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.note_outlined,
            size: 20,
            color:
                Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              notes,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
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
