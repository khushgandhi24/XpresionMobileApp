import 'package:flutter/material.dart';
import 'package:xprapp/shared/styled_text.dart';
import 'package:xprapp/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://d1p54jp4j06wmy.cloudfront.net',
  ),
);

class DRSTile extends StatefulWidget {
  const DRSTile({super.key});

  @override
  State<DRSTile> createState() => _DRSTileState();
}

class _DRSTileState extends State<DRSTile> {
  bool isLoading = false;
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: lightColorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border:
                Border.all(color: lightColorScheme.outlineVariant, width: 2)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  children: [StyledText('Date:'), StyledText('12/12/2024')],
                ),
                SizedBox(
                  height: 16,
                ),
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    StyledText('DRS No.:'),
                    StyledText('BOM/BOM/2024/24')
                  ],
                )
              ],
            ),
            Column(
              children: [
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    StyledText('Field Executive'),
                    StyledText('Rajesh Rajani')
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Wrap(
                  direction: Axis.vertical,
                  children: [StyledText('Area'), StyledText('Mahavir Nagar')],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
