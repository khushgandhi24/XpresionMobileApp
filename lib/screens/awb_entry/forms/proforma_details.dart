import 'package:flutter/material.dart';

class ProformaDetails extends StatefulWidget {
  const ProformaDetails({super.key});

  @override
  State<ProformaDetails> createState() => _ProformaDetailsState();
}

class _ProformaDetailsState extends State<ProformaDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  TimeOfDay? selectedTime;

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
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // const Text('Bottom sheet'),
              TextFormField(
                decoration: const InputDecoration(labelText: "CSB Type"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Invoice Term"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: "GST Invoice (Choice Chip)"),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.calendar_today),
                        labelText: 'Invoice Date',
                        hintText: _selectedDate == null
                            ? 'No date chosen'
                            : _selectedDate!.toLocal().toString().split(' ')[0],
                      ),
                      readOnly: true,
                      onTap: _pickDate,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: "Commercial Invoice No."),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Department No."),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Export Reason"),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: TextFormField(
              //         decoration:
              //             const InputDecoration(labelText: "Billing Type"),
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     Expanded(
              //         child: TextFormField(
              //       decoration: const InputDecoration(labelText: "Charge Type"),
              //     )),
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //       labelText: "Shipment Value (Optional)"),
              // ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton(
                    child: const Text('Reset'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
