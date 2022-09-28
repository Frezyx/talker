import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Signature for build custom [TalkerError]
/// messages in showing [Snackbar]
typedef TalkerErrorBuilder = Widget Function(
  BuildContext context,
  TalkerError data,
);

/// Signature for build custom [TalkerException]
/// messages in showing [Snackbar]
typedef TalkerExceptionBuilder = Widget Function(
  BuildContext context,
  TalkerException data,
);

/// Signature for build custom [TalkerException]
/// messages in showing [Snackbar]
typedef TalkerDataBuilder = Widget Function(
  BuildContext context,
  TalkerDataInterface data,
);
