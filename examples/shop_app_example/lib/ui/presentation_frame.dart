import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class PresentationFrame extends StatelessWidget {
  const PresentationFrame({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb && MediaQuery.of(context).size.width > 600) {
      const MediaQueryData mediaQuery = MediaQueryData(
        size: Size(414, 896),
        padding: EdgeInsets.only(
          top: 44,
          bottom: 34,
        ),
        devicePixelRatio: 2,
      );
      return Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 2,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Builder(builder: (context) {
                    final device = MediaQuery(
                      data: mediaQuery,
                      child: Container(
                        width: mediaQuery.size.width,
                        height: mediaQuery.size.height,
                        alignment: Alignment.center,
                        child: TalkerScreen(talker: GetIt.instance<Talker>()),
                      ),
                    );
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black, width: 12)),
                      child: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(38.5),
                        child: device,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                flex: 2,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Builder(builder: (context) {
                    final device = MediaQuery(
                      data: mediaQuery,
                      child: Container(
                        width: mediaQuery.size.width,
                        height: mediaQuery.size.height,
                        alignment: Alignment.center,
                        child: child,
                      ),
                    );
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black, width: 12)),
                      child: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(38.5),
                        child: device,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(width: 20),
              const Spacer(),
            ],
          ),
        ),
      );
    }
    return child;
  }
}
