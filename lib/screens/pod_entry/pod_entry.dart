import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:xprapp/screens/auth/log_in.dart';
import 'package:xprapp/screens/home/home_model.dart';
import 'package:xprapp/screens/pod_entry/pod_popup.dart';
import 'package:xprapp/screens/pod_entry/pod_statuses.dart';
import 'package:xprapp/screens/pod_entry/preview.dart';
import 'package:xprapp/services/awb_search_model.dart';
import 'package:xprapp/shared/awb_search.dart';
import 'package:xprapp/shared/xpr_drawer.dart';
import 'package:xprapp/theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://d1p54jp4j06wmy.cloudfront.net',
  ),
);

class PODEntry extends StatefulWidget {
  const PODEntry({super.key});

  @override
  State<PODEntry> createState() => _PODEntryState();
}

class _PODEntryState extends State<PODEntry> with WidgetsBindingObserver{

  Future<void> _showCamDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return const CamPopup();
      });
  }

  final storage = const FlutterSecureStorage();

  Future<void> submit() async {
    final name = nameController.text;
    final phone = phoneController.text;
    final status = statusController.text;
    final query = Provider.of<SearchModel>(context, listen: false).query;
      if(query.isNotEmpty && await storage.read(key: 'access_token') != '') {
        debugPrint('Check');
        try {
          debugPrint('Call Starts');
          final res = await dio.post('/awb/pod', data: {
            "awbNumber": query,
            "awbId": 22,
            "transactionStatusId": 9,
            "transactionStatus": status,
            "deliveryDateTime": DateFormat("yyyy-MM-ddTHH:mm").format(DateTime.now()),
            "receiver": name,
            "remark": "",
            "telephone": int.parse(phone),
          },
          options: Options(headers: {'Authorization': 'Bearer ${await storage.read(key: 'access_token')}'})
          );
          debugPrint('Call finished');
          if (res.statusCode == 200) {
            debugPrint(res.statusMessage);
          }
        } on DioException catch (e) {
            if(e.response?.statusCode == 401) {
              debugPrint(await storage.read(key: 'access_token'));
              debugPrint(await storage.read(key: 'refresh_token'));
              debugPrint('Call starts');
              try {
                final rsp = await dio.post('/refreshtoken', data: {"refreshToken": await storage.read(key: "refresh_token")}, options: Options(headers: {'Authorization': "Bearer ${await storage.read(key: 'access_token')}"}));
                Token token = Token.fromJson(rsp.data);
                debugPrint('Call completes');
              
                if(token.success) {
                  await storage.write(key: 'access_token', value: token.accesstoken.replaceAll('Bearer', '').trim());
                  await storage.write(key: 'refresh_token', value: token.refreshtoken);
                  //debugPrint(await storage.read(key: 'access_token'));
                }
                submit();
              } on DioException catch(e) {
                if(e.response?.statusCode == 401) {
                  if (!mounted) return;
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) => const LogIn()));
                }
              }
            }
        }
      }
  }

  final _formKey = GlobalKey<FormState>();

  String? validatePhone(String? value) {
    const pattern = r"^(?:[+0][1-9])?[0-9]{10,12}$";
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
      ? ''
      : null;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  final TextEditingController statusController = TextEditingController();
  PODStatus? selectedStatus;

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return const PODPopup();
      }
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(builder: (context, value, child) =>Scaffold(
      key: scaffoldKey,
      // App Bar
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          }, 
          icon: Icon(
            Icons.menu_rounded,
            color: Theme.of(context).primaryColor,
            size: 36,
          )
        ),
        title: Image.asset('assets/images/logos/Xpr_Color.png',
            width: 140,
            height: 70,
            fit: BoxFit.cover,
        ),
      ),
      drawer: const XprDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                width: MediaQuery.sizeOf(context).width,
                //height: MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.surface,
                      Theme.of(context).colorScheme.primaryContainer,
                    ],
                    stops: const[0, 1],
                    begin: const AlignmentDirectional(0, -1),
                    end: const AlignmentDirectional(0, 1),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16,),
                    const AWBSearch(page: 'pod',),
                    const SizedBox(height: 24,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12,  vertical: 6),
                      decoration: BoxDecoration(
                        color: lightColorScheme.surface,
                        border: Border.all(width: 2, color: lightColorScheme.outline),
                        borderRadius: BorderRadius.circular(24)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Booking date', style: TextStyle(color: lightColorScheme.primary)),
                              const SizedBox(height: 8,),
                              const Text('12/04/2024', style: TextStyle(fontSize: 12),),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Consignee Name', style: TextStyle(color: lightColorScheme.primary)),
                              const SizedBox(height: 8,),
                              const Text('Manish Mahajan',style: TextStyle(fontSize: 12),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12,  vertical: 6),
                      decoration: BoxDecoration(
                        color: lightColorScheme.surface,
                        border: Border.all(width: 2, color: lightColorScheme.outline),
                        borderRadius: BorderRadius.circular(24)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Address', style: TextStyle(color: lightColorScheme.primary,),),
                          const SizedBox(height: 16,),
                          const Text('Block-A, A1 Co-operative Housing Society, 7, A 1, Apartment, Shivaji Rd, Dahanukar Wadi, Kandivali West, Mumbai, Maharashtra 400067', style: TextStyle(fontSize: 12,),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formKey,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                    controller: phoneController,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary,
                                      fontSize: 12,
                                    ),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Theme.of(context).colorScheme.tertiary,
                                    decoration: const InputDecoration(
                                      labelText: 'Mobile No.',
                                      hintText: 'Enter Mobile No.',
                                      errorStyle: TextStyle(fontSize: 0)
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return validatePhone(value);
                                    },                                    
                                    ),
                            ),
                            const SizedBox(width: 8,),
                            TextButton(onPressed: () {
                              if(_formKey.currentState!.validate()) {
                                          
                              }
                            }, 
                            style: ButtonStyle(padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 12, vertical: 6)),
                            backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
                                    foregroundColor: MaterialStatePropertyAll(lightColorScheme.onPrimaryContainer),
                                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: BorderSide(color: lightColorScheme.onPrimaryContainer, width: 2),)),
                            ),
                            child: const Text('Get OTP', style: TextStyle(fontSize: 12),)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Amount Payable:', style: TextStyle(color: lightColorScheme.onSecondaryContainer)),
                          const SizedBox(width: 16,),
                          const Text('Rs. 799/-'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24,),
                    Row(
                      children: [
                        DropdownMenu(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          initialSelection: PODStatus.undelivered,
                          controller: statusController,
                          label: const Text('Status'),
                          onSelected: (PODStatus? status) {
                            setState(() {
                              selectedStatus = status;
                            });
                          },
                          dropdownMenuEntries: PODStatus.values
                            .map<DropdownMenuEntry<PODStatus>>(
                              (PODStatus status) {
                                return DropdownMenuEntry<PODStatus>(
                                  value: status,
                                  label: status.val,
                                );
                              }
                            ).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24,),
                    (selectedStatus?.val == "Delivered") ?
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: nameController,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 12,
                                  ),
                                  keyboardType: TextInputType.text,
                                  cursorColor: Theme.of(context).colorScheme.tertiary,
                                  decoration: const InputDecoration(
                                    labelText: 'Receiver Name',
                                    hintText: 'Enter Receiver Name.',
                                  suffixIcon: Icon(
                                    Icons.search_rounded,
                                  ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Icon(Symbols.photo_camera_rounded, size: 48, color: lightColorScheme.tertiary,),
                                  TextButton(onPressed: () => _showCamDialog(), 
                                  style: ButtonStyle(backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
                                    foregroundColor: MaterialStatePropertyAll(lightColorScheme.onPrimaryContainer),
                                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: BorderSide(color: lightColorScheme.onPrimaryContainer, width: 2),)),
                                  ),
                                  child: const Text('Photo')),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Symbols.signature, size: 48, color: lightColorScheme.tertiary,),
                                  TextButton(onPressed: () => _showDialog(),
                                   style: ButtonStyle(backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
                                    foregroundColor: MaterialStatePropertyAll(lightColorScheme.onPrimaryContainer),
                                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: BorderSide(color: lightColorScheme.onPrimaryContainer, width: 2),)),
                                  ),
                                   child: const Text('Sign')),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                      :
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
                              decoration: const InputDecoration(
                                
                                labelText: 'Remarks',
                                
                                hintText: 'Describe what happened...',
                                
                              ),
                            ),
                          )
                        ],
                      ),
                     
                     const SizedBox(height: 12,),
                     Padding(
                       padding: const EdgeInsets.only(bottom: 12),
                       child: TextButton(onPressed: () async {
                        if(_formKey.currentState!.validate()) {
                          await submit();
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Entry Submitted'),
                          showCloseIcon: true,
                          padding: const EdgeInsets.all(24),
                          duration: const Duration(milliseconds: 1500),
                          backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                        ));
                        }
                        
                       }, child: const Text('Submit')),
                     ),   
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ));
  }
}