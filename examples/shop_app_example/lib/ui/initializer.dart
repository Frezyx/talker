import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class UiInitializer extends StatefulWidget {
  const UiInitializer({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  State<UiInitializer> createState() => _UiInitializerState();
}

class _UiInitializerState extends State<UiInitializer> {
  @override
  void initState() {
    GetIt.instance<Talker>().stream.listen((event) {
      if (event is TalkerException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            content: Row(
              children: [
                const Text('❕', style: TextStyle(fontSize: 30)),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Message from Talker!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(event.exception.toString()),
                  ],
                ),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
