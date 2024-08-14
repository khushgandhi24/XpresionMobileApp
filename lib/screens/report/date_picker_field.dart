import 'package:flutter/material.dart';

class DatePickerRow extends StatefulWidget {
  const DatePickerRow({super.key});

  @override
  State<DatePickerRow> createState() => _DatePickerRowState();
}

class _DatePickerRowState extends State<DatePickerRow> {
  DateTime? _selectedDate;

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Select Date',
              hintText: _selectedDate == null
                  ? 'No date chosen'
                  : _selectedDate!.toLocal().toString().split(' ')[0],
            ),
            readOnly: true,
            onTap: _pickDate,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: _pickDate,
        ),
      ],
    );
  }
}
