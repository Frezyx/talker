import 'package:flutter/cupertino.dart';
import 'package:talker_flutter/src/ui/talker_settings/talker_settings.dart';

class CustomSettingsItemString extends CustomSettingsItem<String> {
  final Function(String value) onChanged;

  const CustomSettingsItemString({
    required String name,
    required String value,
    required this.onChanged,
  }) : super(name: name, value: value);

  @override
  Widget widgetBuilder(
    BuildContext context,
    String value,
    bool isEnabled,
  ) {
    return StringWidgetBuilder(
      onChanged: onChanged,
      value: value,
      isEnabled: isEnabled,
    );
  }
}

class StringWidgetBuilder extends StatefulWidget {
  const StringWidgetBuilder({
    Key? key,
    required this.onChanged,
    this.isEnabled = true,
    this.value = '',
  }) : super(key: key);

  final Function(String value) onChanged;
  final bool isEnabled;
  final String value;

  @override
  State<StringWidgetBuilder> createState() => _StringWidgetBuilderState();
}

class _StringWidgetBuilderState extends State<StringWidgetBuilder> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 200),
      child: CupertinoTextField(
        controller: _controller,
        enabled: widget.isEnabled,
        onChanged: widget.isEnabled ? widget.onChanged : null,
      ),
    );
  }
}
