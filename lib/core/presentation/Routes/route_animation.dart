import 'package:flutter/cupertino.dart';

///This class control the route animation of the app each function have it own behaviour
class RouteAnimation {
  ///Navigate from bottom of screen to the top with transition of time
  Route animationFromBottomToTop({required Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(
        milliseconds: 100,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        ///start point of the screen
        const begin = Offset(0.0, 1.0);

        ///end point of the screen
        const end = Offset(0.0, 0.0);

        ///animation of creating the screen
        const curve = Curves.easeInOut;

        ///animation control
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  ///Navigate from center right of screen to the center left with transition of time
  Route animationFromCenterRightToCenterLeft({required Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(
        milliseconds: 100,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        ///start point of the screen
        const begin = Offset(1.0, 0.0);

        ///end point of the screen
        const end = Offset(0.0, 0.0);

        ///animation of creating the screen
        const curve = Curves.easeInOut;

        ///animation control
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  ///Navigate from bottom left to the top right with transition of time
  Route animationBottomLeftToTopRight({required Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(
        milliseconds: 100,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        ///start point of the screen
        const begin = Offset(1.0, 1.0);

        ///end point of the screen
        const end = Offset(0.0, 0.0);

        ///animation of creating the screen
        const curve = Curves.easeInOut;

        ///animation control
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
