import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_test_project/snapshot/ReloadableAsyncSnapshot.dart';

ReloadableAsyncSnapshot<T> useListenableFuture<T>(
  Future<T> Function() futureBuilder, {
  bool withInitialRun = true,
  List<Listenable> changeNotifiers = const [],
  List<Object?> dependencies = const [],
  FutureOr Function(T data)? onSuccess,
  Function? onError,
}) {

  final ValueNotifier<bool> isFirstRunState = useState(true);
  final ValueNotifier<Future<T>?> futureState = useState(null);

  Future<T> runnable() {
    isFirstRunState.value = false;
    final future = futureBuilder();
    futureState.value = future;
    if (onError != null) {
      future.catchError(onError);
    }
    if (onSuccess != null) {
      future.then(onSuccess);
    }
    return future;
  }

  useEffect(() {
    if (isFirstRunState.value) {
      return null;
    }
    for (var notifier in changeNotifiers) {
      notifier.addListener(runnable);
    }
    return () {
      for (var notifier in changeNotifiers) {
        notifier.removeListener(runnable);
      }
    };
  }, [isFirstRunState.value]);

  useEffect(() {
    if (withInitialRun || !isFirstRunState.value) {
      runnable();
    }
    return;
  }, dependencies);

  final snapshot = useFuture(futureState.value);

  return ReloadableAsyncSnapshot.fromAsyncSnapshot(snapshot, runnable);
}
