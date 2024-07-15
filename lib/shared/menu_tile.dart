import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xprapp/services/awb_search_model.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    super.key,
    required this.route,
    required this.icon,
    required this.title,
    this.fill = 0,
  });

  final String route;
  final IconData icon;
  final String title;
  final double fill;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Provider.of<SearchModel>(context, listen: false).reset();
              Navigator.pushNamed(context, route);
              // Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => route,
              //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
              //     const begin = Offset(0.0, 1.0);
              //     const end = Offset.zero;
              //     const curve = Curves.ease;

              //     var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              //     return SlideTransition(
              //       position: animation.drive(tween),
              //       child: child,
              //     );
              //   },
              // ));
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: (ModalRoute.of(context)!.settings.name == route) ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.inverseSurface,
                  width: 4,
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon,
                      color: (ModalRoute.of(context)!.settings.name == route) ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.secondary,
                      size: 28,
                      fill: (ModalRoute.of(context)!.settings.name == route) ? 1 : fill,
                    ),
                    Text(title, textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: (ModalRoute.of(context)!.settings.name == route) ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.normal,
                      )
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}