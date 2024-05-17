import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_style.dart';

class DateTimeWidget extends ConsumerWidget {
const DateTimeWidget({
Key? key,
required this.titleText,
required this.valueText,
required this.iconSelection,
required this.onTap,
}) : super(key: key);

final String titleText;
final String valueText;
final IconData iconSelection;
final VoidCallback onTap;


@override
Widget build(BuildContext context, WidgetRef ref) {
return Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
titleText,
style: AppStyle.headingOne,
),
SizedBox(height: 8),
Ink(
padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
child: InkWell(
onTap: onTap, // Invoke the onTap callback
child: Row(
children: [
Icon(iconSelection),
SizedBox(width: 8),
Text(valueText),
],
),
),
),
],
),
);
}
}
