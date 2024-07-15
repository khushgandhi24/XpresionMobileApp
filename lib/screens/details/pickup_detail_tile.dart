// import 'package:flutter/material.dart';
// import 'package:xprapp/shared/alert.dart';
// import 'package:xprapp/shared/map_utils.dart';
// import 'package:xprapp/shared/styled_text.dart';
// import 'package:xprapp/theme.dart';

// class PickupDetailTile extends StatelessWidget {
//   const PickupDetailTile({super.key, required this.isHistory});

//   final bool isHistory;        

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         height: (!isHistory) ? 315 : 230,
//         decoration: BoxDecoration(
//           color: lightColorScheme.surface,
//           border: Border.all(color: lightColorScheme.outline),
//           borderRadius: BorderRadius.circular(24)
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         StyledText('Pickup /AWB No.'),
//                         StyledText('0123456789')
//                       ],
//                     ),
//                     SizedBox(height: 16,),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         StyledText('Date /Time'),
//                         StyledText('12/12/12')
//                       ],
//                     ),
//                     SizedBox(height: 16,),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         StyledText('Consignee'),
//                         StyledText('Manish Mahajan')
//                       ],
//                     ),
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const StyledText('Address'),
//                         TextButton(onPressed: () {
//                           showDialog(context: context, builder: (context) {
//                             return const XAlert(body: 'Block-A, A1 Co-operative Housing Society, 7, A 1, Apartment, Shivaji Rd, Dahanukar Wadi, Kandivali West, Mumbai, Maharashtra 400067',);
//                           });
//                         },
//                         style: const ButtonStyle(padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero)), 
//                         child: const Text('View Address', style: TextStyle(fontSize: 12),)),
//                       ],
//                     ),
//                       const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             StyledText('Instructions'),
//                             StyledText('Collect ₹2000')
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             StyledText('Area Name'),
//                             StyledText('Bandarpakhadi')
//                           ],
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             ),
//             (!isHistory) ?
//               const MapUtils(isNew: true,)
//             :
//               const Visibility(visible: false, child: SizedBox.shrink()),
//           ],
//         ),
//       ),
//     );
//   }
// }