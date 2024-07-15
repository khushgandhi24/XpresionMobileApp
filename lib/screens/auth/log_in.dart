// Imports for State Management, Secure Storage, HTTPS requests, widgets & data model
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:xprapp/services/awb_search_model.dart';
import 'package:xprapp/screens/auth/client_model.dart';

// Dio dio = Dio(
//   BaseOptions(baseUrl: 'https://d1p54jp4j06wmy.cloudfront.net/',
//   )
// );

// Page Data
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

// Page State
class _LogInState extends State<LogIn> {
  final storage = const FlutterSecureStorage();

  // Global Keys for DrawerMenu & Log In Form
  final GlobalKey<_LogInState> globalKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for Form TextFields
  final clientIDController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  // Show/Hide Password
  bool showPass = false;
  void toggle() {
    setState(() {
      showPass = !showPass;
    });
  }

  // Auto login on page load
  String currentStatus = 'false';
  Future getStatus() async {
    final val = await storage.read(key: "keepLoggedIn");
    setState(() {
      if (val != '') {
        currentStatus = val ?? 'false';
      }
    });
  }

  // Get Permissions
  // Future<void> requestPermissions() async {
  //   final locationPermission = Permission.location;
  //   final cameraPermission = Permission.camera;
  //   final phonePermission = Permission.phone;
  //   final smsPermission = Permission.sms;
  //   final galleryPermission = Permission.photos;
  //   final storagePermission = Permission.storage;

  //   if (await locationPermission.isDenied) {
  //     await locationPermission.request();
  //   }
  // }

  @override
  void initState() {
    // Auto login if allowed
    getStatus();
    Future.delayed(const Duration(milliseconds: 500), () {
      Provider.of<SearchModel>(context, listen: false)
          .autoLogIn(context, currentStatus);
    });
    super.initState();
  }

  // void checkLogIn(String uID, String accToken) async {
  //   if (await Provider.of<SearchModel>(context, listen: false).checkIsConnected() && accToken.isNotEmpty) {
  //     final res = await Dio().get('https://d1p54jp4j06wmy.cloudfront.net/users/$uID', options: Options(headers: {"Authorization": "Bearer $accToken"}));
  //     debugPrint(res.statusCode.toString());
  //   }
  // }

  // Email validation regex
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

  // On submit loading indicator logic
  bool isLoading = false;
  void showLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  // Login API
  void logIn(BuildContext context) async {
    // Show loading indicator once submit is clicked
    showLoading();

    // Grab form textfield trimmed values from controllers
    String clientID = clientIDController.text.trim();
    String email = emailController.text.trim();
    String pass = passController.text.trim();

    // Check if device is connected to internet before making the API Call
    Future.delayed(const Duration(milliseconds: 500));
    if (await Provider.of<SearchModel>(context, listen: false)
        .checkIsConnected()) {
      try {
        // Post request
        final res = await Dio()
            .post('https://d1p54jp4j06wmy.cloudfront.net/login', data: {
          "logintype": "Client",
          "clientid": clientID,
          "email": email,
          "password": pass,
        });

        // Mapping api call data to client object model
        Client client = Client.fromJson(res.data);

        // Check if api call is valid
        if (client.data.isNotEmpty) {
          // Context guard in async function
          if (!context.mounted) return;

          // Storing token values, userID & auto login preference
          Provider.of<SearchModel>(context, listen: false).getTokens(
              client.accesstoken,
              client.refreshtoken,
              client.data.first.id.toString(),
              'true');

          // Storing username for DrawerMenu
          final userList = client.data.map((e) => e.username).toList();
          Provider.of<SearchModel>(context, listen: false)
              .storeUsername(userList.first);

          // if (!context.mounted) return;
          // showDialog(context: context, builder: (context){
          //   return Padding(
          //     padding: const EdgeInsets.fromLTRB(180, 392, 180, 392),
          //     child: CircularProgressIndicator(
          //       value: null,
          //       color: lightColorScheme.tertiaryContainer,
          //     ),
          //   );
          // });

          // Navigate to home screen
          Navigator.pushNamed(context, '/mapHome');
        }
      } catch (e) {
        // Show dialog if api call returns an error
        debugPrint('Error: $e');
        if (!context.mounted) return;
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Invalid login credentials'),
                content: const Text('Please try again'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Close'),
                  ),
                ],
                actionsAlignment: MainAxisAlignment.center,
              );
            });
      }
    } else {
      // Show dialog if device is not connected to the internet
      if (!context.mounted) return;
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text(
                'Not Connected to Internet',
                textAlign: TextAlign.center,
              ),
              content: const Text('Please connect and try again'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Close'),
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          });
    }

    // Stop loading indicator
    showLoading();
  }

  // Clearing the controllers to deallocate memory
  @override
  void dispose() {
    clientIDController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  // Page Layout & UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            PopScope(
                canPop: false,
                onPopInvoked: (didPop) {
                  if (didPop) {
                    return;
                  }
                  return;
                },
                child: const SizedBox.shrink()),
            Image.asset(
              'assets/images/logos/Xpr_Color.png',
              width: 260,
              height: 120,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.contain,
                    alignment: const AlignmentDirectional(0, -1),
                    image:
                        Image.asset('assets/images/illustrations/login_bg.png')
                            .image,
                  )),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 192,
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.625,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.surface,
                                Theme.of(context).colorScheme.primaryContainer,
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
                                    controller: clientIDController,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 12,
                                    ),
                                    keyboardType: TextInputType.text,
                                    cursorColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    decoration: const InputDecoration(
                                      labelText: 'Client ID',
                                      hintText: 'Enter Client ID...',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Client ID';
                                      }
                                      return null;
                                    },
                                  ),
                                  // 2
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  TextFormField(
                                    controller: emailController,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 12,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      hintText: 'Enter Email ID...',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an email ID';
                                      }
                                      return validateEmail(value);
                                    },
                                  ),
                                  // 3
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  TextFormField(
                                    controller: passController,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 12,
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: !showPass,
                                    cursorColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    decoration: InputDecoration(
                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: IconButton(
                                          onPressed: () {
                                            toggle();
                                          },
                                          icon: !showPass
                                              ? const Icon(
                                                  Symbols
                                                      .visibility_off_rounded,
                                                  size: 32,
                                                )
                                              : const Icon(
                                                  Symbols.visibility_rounded,
                                                  size: 32,
                                                ),
                                        ),
                                      ),
                                      labelText: 'Password',
                                      hintText: 'Enter the Password...',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the password';
                                      }
                                      return null;
                                    },
                                  ),
                                  // Forgot Pass
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(-1, 0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/cloud');
                                            },
                                            child: Text(
                                              'Xpresion Cloud',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(1, 0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/forgotPass');
                                            },
                                            child: Text(
                                              'Forgot Password?',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Submit
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                        padding: const MaterialStatePropertyAll<
                                                EdgeInsetsGeometry>(
                                            EdgeInsets.fromLTRB(
                                                28, 18, 28, 18)),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          logIn(context);
                                        }
                                      },
                                      child: (!isLoading)
                                          ? Text(
                                              'Sign In',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                  fontSize: 16),
                                            )
                                          : const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 20, 0),
                                              child: CircularProgressIndicator(
                                                value: null,
                                                color: Colors.white,
                                              ),
                                            )),
                                  const SizedBox(
                                    height: 36,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
            )
          ],
        ),
      ),
    );
  }
}
