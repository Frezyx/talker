import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerLogDataContainer extends StatelessWidget {
  const TalkerLogDataContainer({
    Key? key,
    required this.data,
    required this.onTap,
    required this.options,
    required this.expanded,
  }) : super(key: key);

  final TalkerScreenTheme options;
  final TalkerDataInterface data;
  final Function() onTap;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final title = _getTitle(data);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            margin: const EdgeInsets.all(5).copyWith(bottom: 0),
            padding: const EdgeInsets.all(10).copyWith(top: 16),
            decoration: BoxDecoration(
              border: Border.all(color: _color),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        maxLines: expanded ? null : 1,
                        text: TextSpan(
                          text: 'Message  ',
                          style: TextStyle(
                            color: _color,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: _message,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // RichText(
                      //   text: TextSpan(
                      //     text: 'Time  ',
                      //     style: TextStyle(
                      //       color: _color,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //     children: [
                      //       TextSpan(
                      //         text: data.displayTime,
                      //         style: const TextStyle(
                      //           fontWeight: FontWeight.normal,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      if (data.stackTrace != null && expanded)
                        RichText(
                          text: TextSpan(
                            text: 'StackTrace  ',
                            style: TextStyle(
                              color: _color,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: data.displayStackTrace,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 26,
                  height: 26,
                  child: IconButton(
                    iconSize: 20,
                    onPressed: onTap,
                    icon: Icon(
                      Icons.copy,
                      color: _color,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 15,
            child: Container(
              transform: Matrix4.translationValues(0, -8, 0),
              color: options.backgroudColor,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              child: Text(
                title,
                style: TextStyle(
                  color: _color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: todo
  //TODO: refactor
  String get _message {
    var message = '';
    final d = data;
    if (d is FlutterTalkerDataInterface) {
      message = d.generateFlutterTextMessage();
    } else {
      message = d.generateTextMessage();
    }

    final title = data.displayTitle;
    final time = data.displayTime;

    var m = message;

    if (title.isNotEmpty && message.contains('[$title] ')) {
      m = message.replaceAll('[$title] ', '').replaceFirst(' |', '');
    }

    if (time.isNotEmpty && m.contains(' $time ')) {
      return m.replaceAll(' $time ', '').replaceFirst('|', '');
    }

    return m;
  }

  Color get _color {
    if (data is TalkerFlutterAdapterInterface) {
      return (data as TalkerFlutterAdapterInterface).color ??
          data.logLevel.color;
    }
    return data.logLevel.color;
  }

  String _getTitle(TalkerDataInterface data) => data.displayTitleWithTime;
}
