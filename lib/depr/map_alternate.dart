// //import 'package:exprollable_page_view/exprollable_page_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:material_symbols_icons/symbols.dart';
// //import 'package:xprapp/screens/home/outline_indicator.dart';
// //import 'package:xprapp/shared/styled_button.dart';
// import 'package:xprapp/shared/xpr_drawer.dart';
// //import 'package:xprapp/screens/home/map_states.dart';
// import 'package:xprapp/theme.dart';
// //import 'dart:math';

// // class ExampleListView extends StatefulWidget {
// //   const ExampleListView({
// //     super.key,
// //     required this.controller,
// //     required this.page,
// //     this.padding,
// //   });

// //   final ScrollController? controller;
// //   final int page;
// //   final EdgeInsets? padding;

// //   @override
// //   State<ExampleListView> createState() => _ExampleListViewState();
// // }

// // class _ExampleListViewState extends State<ExampleListView> {
// //   final Color color = Color.fromARGB(
// //     255,
// //     Random().nextInt(155) + 100,
// //     Random().nextInt(155) + 100,
// //     Random().nextInt(155) + 100,
// //   );

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       color: color,
// //       margin: EdgeInsets.zero,
// //       shape: const RoundedRectangleBorder(),
// //       child: ListView.builder(
// //         padding: widget.padding ?? EdgeInsets.zero,
// //         controller: widget.controller,
// //         itemCount: 50,
// //         itemBuilder: (_, index) {
// //           return ListTile(
// //             onTap: () => debugPrint("onTap(index=$index, page=${widget.page})"),
// //             title: Text("Item#$index"),
// //             subtitle: Text("Page#${widget.page}"),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }



// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> with TickerProviderStateMixin{

//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final mapController = MapController();
//   // late final TabController _tabController;

//   // bool viewList = false;
//   // late String listState;

//   // bool isPOrD = true;
//   // late final ExprollablePageController controller;

//   final double maxScrollHeight = 0.5;
//   final double minScrollHeight = 0.1;

//   // late final AnimationController _animationController;
//   final dsController = DraggableScrollableController();

//   // void showListP () {
//   //   setState(() {
//   //     _tabController.index = 0;
//   //     viewList = !viewList;
//   //     if(viewList) {
//   //       listState = 'Hide';
//   //     } else {
//   //       listState = 'Show';
//   //     }
//   //   });
//   // }

//   // void showListD () {
//   //   setState(() {
//   //     _tabController.index = 1;
//   //     viewList = !viewList;
//   //     if(viewList) {
//   //       listState = 'Hide';
//   //     } else {
//   //       listState = 'Show';
//   //     }
//   //   });
//   // }

//   // void switchPOrD () {
//   //   setState(() {
//   //     isPOrD = !isPOrD;
//   //   });
//   // }

//   void animateDragOnTap(double height) {
//     // Use dragController to control the sheet positioning.
//     dsController.animateTo(
//       height,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.ease,
//     );
//   }

//   void toggleDragSheet() {
//     // Depending on the position of the sheet we can expand or
//     // contract it accordingly.
//     if (dsController.size == minScrollHeight) {
//       animateDragOnTap(maxScrollHeight);
//     } else {
//         animateDragOnTap(minScrollHeight);
//     }
//   }

//   @override
//   void initState() {
//     // controller = ExprollablePageController(
//     //   viewportConfiguration: ViewportConfiguration(
//     //     extraSnapInsets: [
//     //       const ViewportInset.fractional(0.5),
//     //     ],
//     //   ),
//     // );
//     // _animationController = AnimationController(
//     // duration: const Duration(milliseconds: 300),
//     // vsync: this,
//     // );
//     // listState = 'View';
//     // _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // controller.dispose();
//     // _tabController.dispose();
//     // _animationController.dispose();
//     dsController.dispose();
//     super.dispose();
//   }

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
//       body: SafeArea(
//         top: true,
//         bottom: true,
//         child: Stack(
//           children: [
//             FlutterMap(
//               mapController: mapController,
//               options: const MapOptions(
//                   initialCenter: LatLng(19.21615, 72.8186),
//                   initialZoom: 12.5,
//                   maxZoom: 22,
//               ),
              
//               children: [
//                 TileLayer(
//                   urlTemplate: 'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=10362232a61149a190a1c0f366a188aa',
//                     additionalOptions: const {
//                       'style': 'atlas',
//                       'apiKey': '10362232a61149a190a1c0f366a188aa',
//                     },
//                     maxZoom: 22,
//                     userAgentPackageName: 'com.example.xprapp',
//                   ),
//                   MarkerLayer(
//                     markers: [
//                       Marker(
//                         point: const LatLng(19.205627,72.837647),
//                         width: 100,
//                         height: 100,
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               toggleDragSheet();
//                             });
//                           },
//                           child: const Icon(Symbols.location_pin_rounded, size: 42, fill: 1,)
//                         ),
//                       ),
//                     ],
//                   )
//               ],
//             ),

//             // Draggable Scrollable Sheet
//             DraggableScrollableSheet(
//               controller: dsController,
//               initialChildSize: minScrollHeight,
//               minChildSize: minScrollHeight,
//               maxChildSize: maxScrollHeight,
//               snap: true,
//               snapAnimationDuration: const Duration(milliseconds: 150),
//               builder: (context, ScrollController scrollController) {

//                 dsController.addListener(() {
//                   // final newSize = dsController.size;
//                   // final scrollPosition = ((newSize - minScrollHeight)/(maxScrollHeight - minScrollHeight)).clamp(0.0, 1.0);
//                   // _animationController.animateTo(scrollPosition, duration: Duration.zero);
//                 });
//                 return Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         lightColorScheme.surface,
//                         lightColorScheme.primaryContainer
//                       ],
//                       stops: const [0, 1],
//                       begin: const AlignmentDirectional(0, -1),
//                       end: const AlignmentDirectional(0, 1) 
//                     ),
//                     borderRadius: BorderRadius.circular(24),
//                     border: Border.all(color: lightColorScheme.outline, width: 2)
//                   ),
//                   child: SingleChildScrollView(
//                     controller: scrollController,
//                     child: Builder(
//                       builder: (context) {
//                         if(dsController.size != minScrollHeight) {
//                           return TextButton(
//                             onPressed: () => toggleDragSheet(),
//                             child: const Text('View'),
//                           );
//                         }
//                         return Column(
//                           children: [
//                             ...List.generate(
//                               20,
//                               (index) => ListTile(
//                                 title: Text("Tile number: ${index + 1}"),
//                                 trailing: const Icon(Icons.arrow_forward_ios),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),

//             // Regular List
//             // Align(
//             //   alignment: const AlignmentDirectional(0, 1),
//             //   child: Column(
//             //     mainAxisSize: MainAxisSize.min,
//             //     mainAxisAlignment: MainAxisAlignment.end,
//             //     children: [
//             //       (viewList) ?
//             //         Padding(
//             //           padding: const EdgeInsets.fromLTRB(0,24,0,0),
//             //           child: Container(
//             //             width: MediaQuery.sizeOf(context).width,
//             //             height: 400,
//             //             padding: const EdgeInsets.all(16),
//             //             decoration: BoxDecoration(
//             //               color: Colors.blueGrey,
//             //               borderRadius: BorderRadius.circular(24), 
//             //             ),
//             //             child: Column(
//             //               children: [
//             //                 TabBar(
//             //                   onTap: (index) {
//             //                     _tabController.indexIsChanging ? switchPOrD() : null;
//             //                   },
//             //                   dividerColor: Colors.transparent,
//             //                   controller: _tabController,
//             //                   indicator: const OutlineIndicator(color: Color.fromARGB(255, 217, 226, 255)),
//             //                   indicatorPadding: const EdgeInsets.symmetric(horizontal: 24),
//             //                   indicatorSize: TabBarIndicatorSize.tab,
//             //                   tabs: const [
//             //                     Tab(text: 'Pickup',),
//             //                     Tab(text: 'Delivery',),
//             //                   ],
//             //                 ),
//             //               ],
//             //             ),
//             //           ),
//             //         )
//             //       :
//             //         const SizedBox()
//             //     ],
//             //   ),
//             // ),
              
//               // Expr Page View
//               // ExprollablePageView(
//               //   controller: controller,
//               //   itemCount: 3,
//               //   itemBuilder: (context, page) {
//               //     return PageGutter(
//               //       gutterWidth: 12,
//               //       child: ExampleListView(
//               //         controller: PageContentScrollController.of(context),
//               //         page: page
//               //       ),
//               //     );
//               //   }
//               // ),
//           ],
//         ),
//       ),
//     );
//   }
// }