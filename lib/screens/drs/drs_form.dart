import 'package:flutter/material.dart';
import 'package:xprapp/shared/awb_search.dart';
import 'package:xprapp/theme.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      surfaceTintColor: Colors.transparent,
      titlePadding: const EdgeInsets.all(0),
      title: Container(color: Theme.of(context).colorScheme.inverseSurface,
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(Icons.arrow_back_rounded, color: Colors.white,),
          Text('DRS Add/Edit', textAlign: TextAlign.center, style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary, fontSize: 16
          ),),
          const SizedBox(width: 16,),
        ],
      ),),
      content: SingleChildScrollView(
        child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.8,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  initialValue: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  enabled: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color: lightColorScheme.inverseSurface,
                        width: 2,
                      ),
                    ),
                    fillColor: lightColorScheme.surface,
                    filled: true,
                    labelStyle: TextStyle(
                      color: lightColorScheme.onSurfaceVariant,
                      fontSize: 12
                    ),
                    hintStyle: TextStyle(
                      color: lightColorScheme.secondary,
                      fontSize: 12,
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: 'DRS No.',
                  enabled: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color: lightColorScheme.inverseSurface,
                        width: 2,
                      ),
                    ),
                    fillColor: lightColorScheme.surface,
                    filled: true,
                    labelStyle: TextStyle(
                      color: lightColorScheme.onSurfaceVariant,
                      fontSize: 12
                    ),
                    hintStyle: TextStyle(
                      color: lightColorScheme.secondary,
                      fontSize: 12,
                    ),
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12,
                  ),
                  keyboardType: TextInputType.text,
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  decoration: const InputDecoration(                  
                    labelText: 'Field Executive',                  
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12,
                  ),
                  keyboardType: TextInputType.text,
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  decoration: const InputDecoration(               
                    labelText: 'Area',
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12,
                  ),
                  keyboardType: TextInputType.text,
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  decoration: const InputDecoration(
                    labelText: 'Vehicle No.',                              
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12,
                  ),
                  keyboardType: TextInputType.text,
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  decoration: const InputDecoration(
                    labelText: 'Vehicle Type',                              
                  ),
                ),
                const AWBSearch(page: 'drs'),
                const SizedBox(height: 8,),
                TextButton(onPressed: () {}, child: const Text('Add / Update')),
              ],
            ),
          ),
        ),
      ),

    );
  }
}