import 'package:flutter/material.dart';
import 'package:mvvm_flutter/presentation/choose_pattern_screen.dart';
import 'package:mvvm_flutter/presentation/provider_screen.dart';
import 'package:mvvm_flutter/presentation/stream_builder_screen.dart';

class Routes {
  static const String choosePatter = "/choosePattern";
  static const String providerPatter = "/providerPattern";
  static const String streamPatter = "/streamPattern";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.choosePatter:
        return MaterialPageRoute(builder: (_) => ChoosePatterScreen());
      case Routes.providerPatter:
        return MaterialPageRoute(builder: (_) => ProviderScreen());
      case Routes.streamPatter:
        return MaterialPageRoute(builder: (_) => StreamBuilderScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text("Not Found"),
        ),
        body: Center(child: Text("Not found")),
      ),
    );
  }
}
