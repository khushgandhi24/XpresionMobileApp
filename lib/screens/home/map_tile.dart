import 'package:flutter/material.dart';
import 'package:xprapp/shared/alert.dart';
import 'package:xprapp/shared/map_utils.dart';
import 'package:xprapp/shared/styled_text.dart';
import 'package:xprapp/theme.dart';
import 'package:dart_casing/dart_casing.dart';

class MapTile extends StatelessWidget {
  const MapTile({
    super.key,
    this.tnum = "",
    this.datetime = "",
    this.person = "",
    this.address = "",
    this.area = "",
    this.instructions = "",
    this.latlng = const [1.0, 2.0],
    this.mobileno = "N/A",
    this.state = true,
    this.isHistory = false,
    this.isNew = false,
    this.index = 0,
    required this.onTap,
  });

  final String tnum;
  final String datetime;
  final String person;
  final String address;
  final String area;
  final String instructions;
  final List<double> latlng;
  final String mobileno;
  final int index;

  final bool state;
  final bool isHistory;
  final bool isNew;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          height: (!isHistory) ? 315 : 230,
          decoration: BoxDecoration(
              color: lightColorScheme.surface,
              border: Border.all(color: lightColorScheme.outline),
              borderRadius: BorderRadius.circular(24)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (state)
                              ? const StyledText('Pickup No.')
                              : const StyledText('AWB No.'),
                          StyledText(tnum)
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const StyledText('Date & Time'),
                          StyledText(datetime) //.replaceAll("T", "\n"))
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (state)
                              ? const StyledText('Shipper')
                              : const StyledText('Consignee'),
                          (person.length < 16)
                              ? StyledText(Casing.titleCase(person))
                              : StyledText(
                                  Casing.titleCase(person).substring(0, 16)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: (state)
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return XAlert(
                                    head: 'Address',
                                    body: address,
                                  );
                                });
                          },
                          style: ButtonStyle(
                            padding: const MaterialStatePropertyAll<
                                EdgeInsetsGeometry>(EdgeInsets.zero),
                            backgroundColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                            foregroundColor: MaterialStatePropertyAll(
                                lightColorScheme.primary),
                            shape: MaterialStatePropertyAll(LinearBorder.bottom(
                                side: BorderSide(
                                    color: lightColorScheme.onSurface,
                                    width: 2))),
                            elevation: const MaterialStatePropertyAll(0),
                          ),
                          child: const Text(
                            'View Address',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w900),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      (state)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return XAlert(
                                                head: 'Instructions',
                                                body: instructions);
                                          });
                                    },
                                    style: ButtonStyle(
                                      padding: const MaterialStatePropertyAll<
                                          EdgeInsetsGeometry>(EdgeInsets.zero),
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Colors.transparent),
                                      foregroundColor: MaterialStatePropertyAll(
                                          lightColorScheme.primary),
                                      shape: MaterialStatePropertyAll(
                                          LinearBorder.bottom(
                                              side: BorderSide(
                                                  color: lightColorScheme
                                                      .onSurface,
                                                  width: 2))),
                                      elevation:
                                          const MaterialStatePropertyAll(0),
                                    ),
                                    child: const Text(
                                      'View Instructions',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const StyledText('Area Name'),
                                    StyledText(Casing.titleCase(area))
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
              (!isHistory)
                  ? MapUtils(
                      isNew: isNew,
                      mobileno: mobileno,
                      latlng: latlng,
                    )
                  : const Visibility(visible: false, child: SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
