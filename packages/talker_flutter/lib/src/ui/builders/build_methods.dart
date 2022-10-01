import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Signature for build custom [TalkerError]
/// messages in showing [Snackbar] or another widgets
typedef TalkerErrorBuilder = Widget Function(
  BuildContext context,
  TalkerError data,
);

/// Signature for build custom [TalkerException]
/// messages in showing [Snackbar] or another widgets
typedef TalkerExceptionBuilder = Widget Function(
  BuildContext context,
  TalkerException data,
);

/// Signature for build custom [TalkerData] widgets
typedef TalkerDataBuilder = Widget Function(
  BuildContext context,
  TalkerDataInterface data,
);
