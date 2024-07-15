import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:xprapp/shared/styled_text.dart';
import 'package:xprapp/theme.dart';

class PickupDialog extends StatefulWidget {
  const PickupDialog({super.key, this.isActive = true});

  final bool isActive;

  @override
  State<PickupDialog> createState() => _PickupDialogState();
}

class _PickupDialogState extends State<PickupDialog> {

  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(32),
      contentPadding: (widget.isActive) ? const EdgeInsets.fromLTRB(24, 20, 24, 0): const EdgeInsets.fromLTRB(24, 20, 24, 20),
      surfaceTintColor: Colors.transparent,
      backgroundColor: lightColorScheme.surface,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Pickup Details', style: TextStyle(fontSize: 16),),
          IconButton(onPressed: Navigator.of(context).pop, icon: const Icon(Symbols.cancel_rounded, color: Colors.red, size: 32,))
        ],
      ),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: (widget.isActive) ? MediaQuery.sizeOf(context).height * 0.5 : MediaQuery.sizeOf(context).height * 0.2,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StyledText('Service Charges'),
                  StyledText('₹ 1000.00')
                ],
              ),
              const SizedBox(height: 8,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StyledText('Discount (Applied)'),
                  StyledText('₹ 500.00')
                ],
              ),
              const SizedBox(height: 8,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StyledText('Total'),
                  StyledText('₹ 500.00')
                ],
              ),
              const SizedBox(height: 8,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StyledText('AWB No.'),
                  StyledText('300003426')
                ],
              ),
              const SizedBox(height: 8,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StyledText('Payment Mode'),
                  StyledText('Cash')
                ],
              ),
              const SizedBox(height: 16,),
              (widget.isActive) ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextField(
                      controller: amountController,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12,
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: Theme.of(context).colorScheme.tertiary,
                      decoration: InputDecoration(
                        
                        labelText: 'Amount Collected',
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 12
                        ),
                        hintText: 'Enter collected amount...',
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
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 12,
                            ),
                            keyboardType: TextInputType.text,
                            minLines: 2,
                            maxLines: 2,
                            cursorColor: Theme.of(context).colorScheme.tertiary,
                            decoration: InputDecoration(
                              
                              labelText: 'Remarks',
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                fontSize: 12
                              ),
                              hintText: 'Describe what happened...',
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
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16,),
                    TextButton(onPressed: () {}, child: const Text('Submit'))
                        ],
                )
              :
                const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}