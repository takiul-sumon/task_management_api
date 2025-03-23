import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_management_api/ui/utils/assets_path.dart';

class ScreanBackground extends StatelessWidget {
  const ScreanBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          width: double.maxFinite,
          height: double.maxFinite,
          AssetsPath.backgroundSvg,
          fit: BoxFit.cover,
        ),
        SafeArea(child: Center(child: child)),
      ],
    );
  }
}
