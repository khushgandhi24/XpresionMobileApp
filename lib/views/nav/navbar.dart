import 'package:flutter/material.dart';

class NavTile extends StatelessWidget {
  const NavTile(
      {super.key, required this.text, required this.icon, this.active = false});

  final String text;
  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/custHome'),
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      ),
      child: Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: (active)
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 12,
                color: (active)
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onPrimaryContainer),
          )
        ],
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        border: Border.all(color: Colors.black, width: 2),
        //borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavTile(
              text: '   Home   ',
              icon: Icons.home_rounded,
              active: (ModalRoute.of(context)!.settings.name == '/custHome')
                  ? true
                  : false,
            ),
            const SizedBox(
                height: 32,
                child: VerticalDivider(
                  width: 4,
                  thickness: 1,
                  color: Colors.black,
                )),
            const NavTile(text: 'My Orders', icon: Icons.history_rounded),
            const SizedBox(
                height: 32,
                child: VerticalDivider(
                  width: 4,
                  thickness: 1,
                  color: Colors.black,
                )),
            const NavTile(text: 'Dashboard', icon: Icons.dashboard_rounded),
          ],
        ),
      ),
    );
  }
}
