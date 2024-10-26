import 'dart:async';

import 'package:flutter/cupertino.dart';

class ReloadableAsyncSnapshot<T> extends AsyncSnapshot<T> {

  final FutureOr<T> Function() fetch;

  bool get isWaiting => super.connectionState == ConnectionState.waiting;

  factory ReloadableAsyncSnapshot.fromAsyncSnapshot(AsyncSnapshot snapshot, FutureOr<T> Function() fetch) {
    if (snapshot.hasData) {
      return ReloadableAsyncSnapshot.withData(
        fetch,
        snapshot.connectionState,
        snapshot.data!,
      );
    }
    if (snapshot.hasError) {
      return ReloadableAsyncSnapshot.withError(
        fetch,
        snapshot.connectionState,
        snapshot.error!,
        snapshot.stackTrace,
      );
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
      return ReloadableAsyncSnapshot.waiting(fetch);
    }
    return ReloadableAsyncSnapshot.nothing(fetch);
  }

  const ReloadableAsyncSnapshot.nothing(this.fetch) : super.nothing();

  const ReloadableAsyncSnapshot.waiting(this.fetch) : super.waiting();

  const ReloadableAsyncSnapshot.withData(this.fetch, ConnectionState state, T data) : super.withData(state, data);

  const ReloadableAsyncSnapshot.withError(this.fetch, ConnectionState state, Object error, [StackTrace? stackTrace])
      : super.withError(state, error, stackTrace ?? StackTrace.empty);
}
