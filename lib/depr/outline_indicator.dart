// import 'package:flutter/material.dart';

// class OutlineIndicator extends Decoration {

//   const OutlineIndicator({
//     this.color = Colors.white,
//     this.radius = const Radius.circular(24),
//   });

//   final Color color;
//   final Radius radius;

//   @override
//   BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    
//     return _OutlinePainter(
//       color: color,
//       radius: radius,
//       onChange: onChanged,
//     );

//   }

// }

// class _OutlinePainter extends BoxPainter {
//   _OutlinePainter({
//     required this.color,
//     required this.radius,
//     VoidCallback? onChange,
//   })  : _paint = Paint()
//           ..style = PaintingStyle.fill
//           ..color = color,
//         super(onChange);
//   final Color color;
//   final Radius radius;
//   final Paint _paint;
// @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
//     assert(configuration.size != null);
//     var rect = offset & configuration.size!;
//     var rrect = RRect.fromRectAndRadius(rect, radius);
//     canvas.drawRRect(rrect, _paint);
//   }
// }