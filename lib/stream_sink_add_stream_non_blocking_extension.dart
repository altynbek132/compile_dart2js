import 'dart:async';

extension StreamSinkAddStreamNonBlockingExtension<T> on StreamSink<T> {
  StreamSubscription<T> addStreamNonBlocking(Stream<T> other) {
    return other.listen(
      add,
      onError: addError,
    );
  }
}
