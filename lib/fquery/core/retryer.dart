import 'package:fquery/fquery/core/online_manager.dart';
import 'package:fquery/fquery/core/query.dart';

bool canFetch(QueryNetworkMode? networkMode) {
  bool isNetworkModeOnline =
      (networkMode ?? QueryNetworkMode.online) == QueryNetworkMode.online;

  return isNetworkModeOnline ? OnlineManager().isOnline : true;
}

class CancelOptions {
  final bool revert;
  final bool silent;

  CancelOptions({
    required this.revert,
    required this.silent,
  });
}

class CancelledError {
  bool? revert;
  bool? silent;

  CancelledError({
    CancelOptions? options,
  }) {
    revert = options?.revert ?? false;
    silent = options?.silent ?? false;
  }
}

class Retryer<TData> {
  Future<TData> future;
  void Function(CancelOptions? cancelOptions) cancel;
  void Function() continueFn;
  void Function() cancelRetry;
  void Function() continueRetry;

  Retryer({
    required this.future,
    required this.cancel,
    required this.continueFn,
    required this.cancelRetry,
    required this.continueRetry,
  });
}