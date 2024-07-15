import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:intl/intl.dart';

class DateField extends StatefulWidget {
  const DateField({super.key, required this.label, this.sficon = true});

  final String label;
  final bool sficon;

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {

  final dateController = TextEditingController();

  void dateSelect() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      locale: const Locale('en', 'IN'),
      initialDate: DateTime.now(), 
      firstDate: DateTime(2023), 
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String fmtDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        dateController.text = fmtDate;
      });
    }
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: dateController,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 12,
            ),
            keyboardType: TextInputType.number,
            cursorColor: Theme.of(context).colorScheme.tertiary,
            decoration: InputDecoration(
              
              labelText: widget.label,
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12
              ),
              hintText: 'Enter ${widget.label}',
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              contentPadding: const EdgeInsets.all(16),
              suffixIcon: (widget.sficon) ? Icon(
                Icons.search_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              ) : null
            ),
          )
        ),

        IconButton(onPressed: () => dateSelect(), icon: const Icon(Symbols.calendar_today_rounded, fill: 1, size: 36,)),
      ],
    );
  }
}