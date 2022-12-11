import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/widgets/cards/base_card.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerDataCard extends StatelessWidget {
  const TalkerDataCard({
    Key? key,
    this.color,
    required this.data,
  }) : super(key: key);

  final Color? color;
  final TalkerDataInterface data;

  @override
  Widget build(BuildContext context) {
    final errorMessage = _errorMessage;
    final color = this.color ?? _color;
    return Stack(
      children: [
        TalkerBaseCard(
          color: color,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.displayTitle + ' | ' + data.displayTime,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(_type,
                            style: TextStyle(color: color, fontSize: 12)),
                        if (errorMessage != null)
                          Text(errorMessage,
                              style: TextStyle(color: color, fontSize: 12)),
                      ],
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.expand, color: color),
                  // )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color get _color {
    if (data is TalkerFlutterAdapterInterface) {
      return (data as TalkerFlutterAdapterInterface).color ??
          data.logLevel.color;
    }
    return data.logLevel.color;
  }

  String? get _errorMessage {
    var txt = data.exception?.toString() ?? data.exception?.toString();

    if ((txt?.isNotEmpty ?? false) && txt!.contains('Source stack:')) {
      txt = 'Data: ' + txt.split('Source stack:').first.replaceAll('\n', '');
    }
    return txt;
  }

  String get _type {
    return 'Type: ' +
        (data.exception?.runtimeType.toString() ??
            data.error?.runtimeType.toString() ??
            '');
  }
}
