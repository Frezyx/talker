enum TalkerKey {
  /// Logger level
  error('error'),
  critical('critical'),
  info('info'),
  debug('debug'),
  verbose('verbose'),
  warning('warning'),

  /// talker level
  exception('exception'),
  httpError('http-error'),
  httpRequest('http-request'),
  httpResponse('http-response'),
  blocEvent('bloc-event'),
  blocTransition('bloc-transition'),
  route('route');

  const TalkerKey(this.key);
  final String key;
}
