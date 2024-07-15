// import 'package:flutter/material.dart';
// import 'package:material_symbols_icons/symbols.dart';
// import 'package:xprapp/screens/home/outline_indicator.dart';
// import 'package:xprapp/shared/xpr_drawer.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:ip_geolocation_io/ip_geolocation_io.dart';

// class MapHome extends StatefulWidget {
//   const MapHome({super.key});

//   @override
//   State<MapHome> createState() => _MapHomeState();
// }

// class _MapHomeState extends State<MapHome> with TickerProviderStateMixin {

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   List<String> choices = ['New', 'Active', 'All'];

//   late final TabController _tabController;

//   int? _value = 0;
//   bool isPickup = true;

//   String loc = '';
//   double lat = 0.0;
//   double long = 0.0;
//   final apiKey = 'e282df27e2124bcab1c3305033d63229';

//   void getLoc () async {
//     final geolocation = IpGeoLocationIO(apiKey);
//     final response = await geolocation.getUserLocation();
//     loc = response.city;
//   }

//   void changeMarker () {
//     setState(() {
//       isPickup = !isPickup;
//     });
//   }

//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   final mapController = MapController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       // App Bar
//       appBar: AppBar(
//         toolbarHeight: 76,
//         surfaceTintColor: Colors.transparent,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             scaffoldKey.currentState!.openDrawer();
//           }, 
//           icon: Icon(
//             Icons.menu_rounded,
//             color: Theme.of(context).primaryColor,
//             size: 32,
//           )
//         ),
//         title: Image.asset('assets/images/logos/Xpr_Color.png',
//             width: 140,
//             height: 70,
//             fit: BoxFit.cover,
//         ),
//       ),
//       drawer: const XprDrawer(),
//       body: Stack(
//         children: [
//           TabBarView(
//             controller: _tabController,
//             children: [

//               // Pickup Map
//               Stack(
//                 children: [
//                   FlutterMap(
//                     mapController: mapController,
//                     options: const MapOptions(
//                         initialCenter: LatLng(19.21615, 72.8186),
//                         initialZoom: 12.5,
//                         maxZoom: 22,
//                     ),
                  
//                     children: [
//                         TileLayer(
//                             urlTemplate: 'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=10362232a61149a190a1c0f366a188aa',
//                             additionalOptions: const {
//                                 'style': 'atlas',
//                                 'apiKey': '10362232a61149a190a1c0f366a188aa',
//                             },
//                             maxZoom: 22,
//                             userAgentPackageName: 'com.example.xprapp',
//                         ),
//                           const MarkerLayer(
//                             markers: [
//                               Marker(
//                                 point: LatLng(19.21615, 72.8186),
//                                 width: 80,
//                                 height: 80,
//                                 child: Icon(Symbols.location_pin_rounded, size: 32, fill: 1,),
//                               ),
//                             ],
//                           ),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: TextField(
//                                 style: TextStyle(
//                                 color: Theme.of(context).colorScheme.secondary,
//                                 fontSize: 12,
//                                 ),
//                                 keyboardType: TextInputType.number,
//                                 cursorColor: Theme.of(context).colorScheme.tertiary,
//                                 decoration: InputDecoration(
//                                   filled: true,
//                                   fillColor: Theme.of(context).colorScheme.secondaryContainer,  
//                                   labelText: 'Mobile No.',
//                                   labelStyle: TextStyle(
//                                     color: Theme.of(context).colorScheme.onSurfaceVariant,
//                                     fontSize: 12
//                                   ),
//                                   hintText: 'Enter Mobile No.',
//                                   hintStyle: TextStyle(
//                                     color: Theme.of(context).colorScheme.secondary,
//                                     fontSize: 12,
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Theme.of(context).colorScheme.outline,
//                                       width: 2,
//                                     ),
//                                     borderRadius: BorderRadius.circular(24)
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Theme.of(context).colorScheme.primary,
//                                       width: 2,
//                                     ),
//                                     borderRadius: BorderRadius.circular(24),
//                                   ),
//                                   errorBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Theme.of(context).colorScheme.error,
//                                       width: 2,
//                                     ),
//                                     borderRadius: BorderRadius.circular(24),
//                                   ),
//                                   focusedErrorBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Theme.of(context).colorScheme.error,
//                                       width: 2,
//                                     ),
//                                     borderRadius: BorderRadius.circular(24),
//                                   ),
//                                   contentPadding: const EdgeInsets.all(16),
//                                 ),
//                               ),
//                             ),
//                             IconButton(onPressed: () {}, icon: const Icon(Symbols.search_rounded, size: 32,))
//                           ],
//                         ),
//                       ),
//                       const Expanded(child: SizedBox()),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         child: Wrap(
//                           spacing: 5.0,
//                           children: List<Widget>.generate(
//                             3,
//                             (int index) {
//                               return ChoiceChip(
//                                 label: Text(choices[index]),
//                                 showCheckmark: false,
//                                 selected: _value == index,
//                                 onSelected: (bool selected) {
//                                   setState(() {
//                                     _value = selected ? index : null;
//                                   });
//                                 },
//                               );
//                             },
//                           ).toList(),
//                         ),
//                       ),
//                       //Sliver
//                       Container(
//                         width: MediaQuery.sizeOf(context).width *0.95,
//                         height: 270,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Theme.of(context).colorScheme.surface,
//                               Theme.of(context).colorScheme.secondaryContainer,
//                             ],
//                             stops: const [0, 1],
//                             begin: const AlignmentDirectional(0, -1),
//                             end: const AlignmentDirectional(0, 1)
//                           ),
//                           borderRadius: BorderRadius.circular(24)
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 16),
//                           child: ListView(
//                             children: [
//                               Container(height: 125, decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 2))),),
//                               Container(height: 125, decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 2))),),
//                               Container(height: 125, decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 2))),),
//                               Container(height: 125, decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 2))),),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),

//               // Delivery Map
//               FlutterMap(
//                 mapController: mapController,
//                 options: const MapOptions(
//                     initialCenter: LatLng(19.21615, 72.8186),
//                     initialZoom: 12.5,
//                     maxZoom: 22,
//                 ),
              
//                 children: [
//                     TileLayer(
//                         urlTemplate: 'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=10362232a61149a190a1c0f366a188aa',
//                         additionalOptions: const {
//                             'style': 'atlas',
//                             'apiKey': '10362232a61149a190a1c0f366a188aa',
//                         },
//                         maxZoom: 22,
//                         userAgentPackageName: 'com.example.xprapp',
//                     ),
//                       const MarkerLayer(
//                         markers: [
//                           Marker(
//                             point: LatLng(19.205627,72.837647),
//                             width: 80,
//                             height: 80,
//                             child: Icon(Symbols.location_pin_rounded, size: 32, fill: 1,),
//                           ),
//                         ],
//                     )
//                 ],
//               ),
              
//             ]
//           ),
//           TabBar(
//             onTap: (index) {
//               _tabController.indexIsChanging ?
//               changeMarker()
//               :
//               null;
//             },
//             overlayColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.primaryContainer),
//             dividerColor: Colors.transparent,
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             indicator: const OutlineIndicator(color: Color.fromARGB(255, 217, 226, 255)),
//             indicatorPadding: const EdgeInsets.symmetric(horizontal: 24),
//             indicatorSize: TabBarIndicatorSize.tab,
//             controller: _tabController,
//             tabs: const <Widget>[
//               Tab(
//                 text: 'Pickup',
//               ),
//               Tab(
//                 text: 'Delivery',
//               ),
//             ],
//           ),
          
//         ],
//       ),
//     );
//   }
// }

// // FlutterFlow added ClipRRect on title image (Why?) - Border Radius property was set on FlutterFlow

// // title: ClipRRect(
// //           borderRadius: BorderRadius.circular(8),
// //           child: Image.asset('assets/images/logos/Xpr_Color.png',
// //             width: 140,
// //             height: 70,
// //             fit: BoxFit.cover,
// //           ),
// //         ),

// // Column(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [

// // SliverList(
// //                         delegate: SliverChildListDelegate(
// //                           [
// //                             Container(
// //                               width: MediaQuery.sizeOf(context).width,
// //                               height: 50,
// //                               color: Theme.of(context).colorScheme.tertiaryContainer,
// //                               child: const Text('1'),
// //                             ),
// //                             Container(
// //                               width: MediaQuery.sizeOf(context).width,
// //                               height: 50,
// //                               color: Theme.of(context).colorScheme.tertiaryContainer,
// //                               child: const Text('2'),
// //                             ),
// //                             Container(
// //                               width: MediaQuery.sizeOf(context).width,
// //                               height: 50,
// //                               color: Theme.of(context).colorScheme.tertiaryContainer,
// //                               child: const Text('3'),
// //                             ),
// //                           ]
// //                         ),
// //                       ),

                  
// //                 ],
// //               ),
// //               Column(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   TextField(
// //                     style: TextStyle(
// //                                     color: Theme.of(context).colorScheme.secondary,
// //                                     fontSize: 12,
// //                                   ),
// //                                   keyboardType: TextInputType.number,
// //                                   cursorColor: Theme.of(context).colorScheme.tertiary,
// //                                   decoration: InputDecoration(
                                    
// //                                     labelText: 'Mobile No.',
// //                                     labelStyle: TextStyle(
// //                                       color: Theme.of(context).colorScheme.onSurfaceVariant,
// //                                       fontSize: 12
// //                                     ),
// //                                     hintText: 'Enter Mobile No.',
// //                                     hintStyle: TextStyle(
// //                                       color: Theme.of(context).colorScheme.secondary,
// //                                       fontSize: 12,
// //                                     ),
// //                                     enabledBorder: OutlineInputBorder(
// //                                       borderSide: BorderSide(
// //                                         color: Theme.of(context).colorScheme.outline,
// //                                         width: 2,
// //                                       ),
// //                                       borderRadius: BorderRadius.circular(24)
// //                                     ),
// //                                     focusedBorder: OutlineInputBorder(
// //                                     borderSide: BorderSide(
// //                                       color: Theme.of(context).colorScheme.primary,
// //                                       width: 2,
// //                                     ),
// //                                     borderRadius: BorderRadius.circular(24),
// //                                   ),
// //                                   errorBorder: OutlineInputBorder(
// //                                     borderSide: BorderSide(
// //                                       color: Theme.of(context).colorScheme.error,
// //                                       width: 2,
// //                                     ),
// //                                     borderRadius: BorderRadius.circular(24),
// //                                   ),
// //                                   focusedErrorBorder: OutlineInputBorder(
// //                                     borderSide: BorderSide(
// //                                       color: Theme.of(context).colorScheme.error,
// //                                       width: 2,
// //                                     ),
// //                                     borderRadius: BorderRadius.circular(24),
// //                                   ),
// //                                   contentPadding: const EdgeInsets.all(16),
// //                                   ),
// //                   ),
// //                 ],
// //               ),
            