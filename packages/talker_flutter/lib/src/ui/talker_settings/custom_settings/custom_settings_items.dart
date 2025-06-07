import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract interface class CustomSettingsItem<T> {
  CustomSettingsItem({required this.name, required this.value});

  final String name;
  T value;
  void onChanged(T val);

  Widget widgetBuilder(BuildContext context, T value, bool isEnabled);
}

class CustomSettingsItemBool extends CustomSettingsItem<bool> {
  CustomSettingsItemBool({
    required String name,
    required bool value,
    required Function(bool value) onChanged,
  })  : _onChanged = onChanged,
        super(name: name, value: value);

  late final Function(bool value) _onChanged;

  @override
  void onChanged(bool val) {
    _onChanged.call(val);
    value = val;
  }

  @override
  Widget widgetBuilder(
    BuildContext context,
    bool value,
    bool isEnabled,
  ) {
    return CupertinoSwitch(
      value: value,
      inactiveTrackColor: isEnabled ? Colors.red : Colors.grey,
      onChanged: onChanged,
    );
  }
}

// class CustomSettingsItemString extends CustomSettingsItem<String> {
//   final Function(String value) onChanged;

//   const CustomSettingsItemString({
//     required String name,
//     required String value,
//     required this.onChanged,
//   }) : super(name: name, value: value);

//   @override
//   Widget widgetBuilder(
//     BuildContext context,
//     String value,
//     bool isEnabled,
//   ) {
//     return StringWidgetBuilder(
//       onChanged: onChanged,
//       value: value,
//       isEnabled: isEnabled,
//     );
//   }
// }

// class StringWidgetBuilder extends StatefulWidget {
//   const StringWidgetBuilder({
//     Key? key,
//     required this.onChanged,
//     this.isEnabled = true,
//     this.value = '',
//   }) : super(key: key);

//   final Function(String value) onChanged;
//   final bool isEnabled;
//   final String value;

//   @override
//   State<StringWidgetBuilder> createState() => _StringWidgetBuilderState();
// }

// class _StringWidgetBuilderState extends State<StringWidgetBuilder> {
//   TextEditingController? _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController(text: widget.value);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints(maxWidth: 200),
//       child: CupertinoTextField(
//         controller: _controller,
//         enabled: widget.isEnabled,
//         onChanged: widget.isEnabled ? widget.onChanged : null,
//       ),
//     );
//   }
// }
