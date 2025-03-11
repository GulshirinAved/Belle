import 'package:mobx/mobx.dart';

part 'state_manager.g.dart';

class StateManager = _StateManager with _$StateManager;

abstract class _StateManager with Store {
  @observable
  bool isLoading = false;

  @observable
  bool isError = false;

  @observable
  String? errorMessage;

  @observable
  bool isSuccess = false;

  @observable
  bool isPaginationLoading = false;

  @observable
  bool hasMore = true;

  @observable
  int currentPage = 1;

  @action
  Future<T?> execute<T>(
    Future<T?> Function() action, {
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    isLoading = true;
    isError = false;
    errorMessage = null;
    isSuccess = false;

    try {
      final response = await action();
      isSuccess = true;
      onSuccess.call();
      return response;
    } catch (e) {
      isError = true;
      errorMessage = e.toString();
      onError.call(errorMessage!);
      return null;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> executePagination(
    Future<void> Function(int page) action, {
    required void Function(String) onError,
  }) async {
    if (isPaginationLoading || !hasMore) return;

    isPaginationLoading = true;

    try {
      await action(currentPage);
      currentPage++;
    } catch (e) {
      errorMessage = e.toString();
      onError.call(errorMessage!);
    } finally {
      isPaginationLoading = false;
    }
  }

  @action
  void resetPagination() {
    currentPage = 1;
    hasMore = true;
  }

  @action
  void reset() {
    isLoading = false;
    isError = false;
    isSuccess = false;
    errorMessage = null;
    resetPagination();
  }
}
