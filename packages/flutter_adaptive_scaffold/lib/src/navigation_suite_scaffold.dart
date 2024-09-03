import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationSuiteScaffold extends StatelessWidget {
  const NavigationSuiteScaffold({
    super.key,
    required this.navigationSuiteItems,
    required this.child,
  });

  final List<NavigationSuiteItem> navigationSuiteItems;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

/// Wrapper for [NavigationDrawerDestination], [NavigationRailDestination] and [NavigationDestination]
class NavigationSuiteItem {
  const NavigationSuiteItem({
    this.key,
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.enabled = true,
    this.tooltip,
    this.backgroundColor,
    this.indicatorColor,
    this.indicatorShape,
    this.padding,
  });

  final Key? key;

  final String label;

  final Widget icon;

  final Widget? selectedIcon;

  final bool enabled;

  final String? tooltip;

  final Color? backgroundColor;

  final Color? indicatorColor;

  final ShapeBorder? indicatorShape;

  final EdgeInsetsGeometry? padding;
}
