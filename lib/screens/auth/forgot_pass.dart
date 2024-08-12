// Imports for Symbols, Secure Storage, HTTPS requests & data model
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  // String? validatePhone(String? value) {
  //   const pattern = r"^(?:[+0][1-9])?[0-9]{10,12}$";
  //   final regex = RegExp(pattern);

  //   return value!.isNotEmpty && !regex.hasMatch(value)
  //     ? 'Enter a valid phone number'
  //     : null;
  // }

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Symbols.arrow_back_rounded,
              size: 36,
            ),
          ),
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          bottom: true,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: const AlignmentDirectional(0, -1),
                        fit: BoxFit.contain,
                        image: Image.asset(
                                'assets/images/illustrations/forgot.png')
                            .image,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 256,
                          ),
                          Container(
                            height: MediaQuery.sizeOf(context).height * 0.625,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.surface,
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ],
                                stops: const [0, 1],
                                begin: const AlignmentDirectional(0, -1),
                                end: const AlignmentDirectional(0, 1),
                              ),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24)),
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.outline,
                                  width: 2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 18),
                              child: Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                key: _formKey,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 36,
                                    ),
                                    TextFormField(
                                      controller: emailController,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 12,
                                      ),
                                      keyboardType: TextInputType.text,
                                      cursorColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      decoration: const InputDecoration(
                                        labelText: 'Client ID',
                                        hintText: 'Enter the client ID...',
                                      ),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter the client ID';
                                        }
                                        return null;
                                      },
                                    ),
                                    // 2
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    TextFormField(
                                      controller: phoneController,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 12,
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      cursorColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      decoration: const InputDecoration(
                                        labelText: 'Email ID',
                                        hintText: 'Enter an email ID...',
                                      ),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter an email ID';
                                        }
                                        return validateEmail(value);
                                      },
                                    ),
                                    // Submit
                                    const SizedBox(
                                      height: 36,
                                    ),
                                    TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll<Color>(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                          padding: const WidgetStatePropertyAll<
                                                  EdgeInsetsGeometry>(
                                              EdgeInsets.fromLTRB(
                                                  24, 8, 24, 8)),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {}
                                        },
                                        child: Text(
                                          'Get OTP',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary),
                                        )),
                                    const SizedBox(
                                      height: 130,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Powered By',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Image.asset(
                                          'assets/images/logos/Busisoft.png',
                                          width: 120,
                                          height: 30,
                                          fit: BoxFit.cover,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
