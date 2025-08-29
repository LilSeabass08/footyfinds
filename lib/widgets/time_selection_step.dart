import 'package:flutter/material.dart';

class TimeSelectionStep extends StatefulWidget {
  final DateTime? selectedDateTime;
  final Function(DateTime) onDateTimeSelected;

  const TimeSelectionStep({
    super.key,
    required this.selectedDateTime,
    required this.onDateTimeSelected,
  });

  @override
  State<TimeSelectionStep> createState() => _TimeSelectionStepState();
}

class _TimeSelectionStepState extends State<TimeSelectionStep> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.selectedDateTime != null) {
      _selectedDate = DateTime(
        widget.selectedDateTime!.year,
        widget.selectedDateTime!.month,
        widget.selectedDateTime!.day,
      );
      _selectedTime = TimeOfDay.fromDateTime(widget.selectedDateTime!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date selection
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Color(0xFF4CAF50)),
                    const SizedBox(width: 8),
                    const Text(
                      'Select Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectDate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      foregroundColor: Colors.black87,
                      elevation: 0,
                    ),
                    child: Text(
                      _selectedDate != null
                          ? '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}'
                          : 'Choose Date',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Time selection
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Color(0xFF4CAF50)),
                    const SizedBox(width: 8),
                    const Text(
                      'Select Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectTime,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      foregroundColor: Colors.black87,
                      elevation: 0,
                    ),
                    child: Text(
                      _selectedTime != null
                          ? _selectedTime!.format(context)
                          : 'Choose Time',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Selected date and time display
        if (_selectedDate != null && _selectedTime != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF4CAF50)),
            ),
            child: Column(
              children: [
                const Text(
                  'Selected Date & Time',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year} at ${_selectedTime!.format(context)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4CAF50),
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _updateSelectedDateTime();
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4CAF50),
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
      _updateSelectedDateTime();
    }
  }

  void _updateSelectedDateTime() {
    if (_selectedDate != null && _selectedTime != null) {
      final selectedDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      widget.onDateTimeSelected(selectedDateTime);
    }
  }
}
