import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationSuiteScaffold extends Scaffold {
  const NavigationSuiteScaffold({
    super.key,
    required this.navigationSuiteItems,
    this.navigationRail,
    super.appBar,
    super.body,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.floatingActionButtonAnimator,
    super.persistentFooterButtons,
    super.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    super.drawer,
    super.onDrawerChanged,
    super.endDrawer,
    super.onEndDrawerChanged,
    super.bottomNavigationBar,
    super.bottomSheet,
    super.backgroundColor,
    super.resizeToAvoidBottomInset,
    super.primary = true,
    super.drawerDragStartBehavior = DragStartBehavior.start,
    super.extendBody = false,
    super.extendBodyBehindAppBar = false,
    super.drawerScrimColor,
    super.drawerEdgeDragWidth,
    super.drawerEnableOpenDragGesture = true,
    super.endDrawerEnableOpenDragGesture = true,
    super.restorationId,
  });

  final List<NavigationSuiteItem> navigationSuiteItems;

  final NavigationRail? navigationRail;

  @override
  ScaffoldState createState() => NavigationSuiteScaffoldState();
}

class NavigationSuiteScaffoldState extends ScaffoldState {
  @override
  Widget build(BuildContext context) {
    return super.build(context);
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
