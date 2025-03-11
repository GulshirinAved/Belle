import 'package:belle/src/utils/src/mixins/handling_error_mixin.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../core/core.dart';
import '../../../state_manager.dart';

part 'base_controller.g.dart';

class BaseController<T> = _BaseController<T> with _$BaseController;

abstract class _BaseController<T> with Store, HandlingErrorMixin {
  final StateManager stateManager = StateManager();

  final offsetPaginationBoundary = 0.8;

  @observable
  T? data;

  @observable
  ObservableList<T> items = ObservableList<T>();

  @computed
  bool get isEmpty => stateManager.isSuccess && items.isEmpty;

  @action
  Future<void> loadInitialListData(
    Future<ListResponse<T>> Function({int? size, int? number}) fetch, {
    int size = 10,
  }) async {
    stateManager.resetPagination();

    await stateManager.execute(
      onSuccess: () {},
      () async {
        final response =
            await fetch(size: size, number: stateManager.currentPage);
        items.clear();
        if (response.data != null) {
          items.addAll(response.data!);
          // stateManager.hasMore =
          //     response.data!.isNotEmpty && response.data!.length >= size;
          stateManager.currentPage++;
        }
        return response;
      },
      onError: handleError,
      // onSuccess: handleSuccess,
    );
  }

  @action
  Future<void> loadMoreListData(
    Future<ListResponse<T>> Function({int? size, int? number}) fetch, {
    int size = 10,
  }) async {
    if (stateManager.isPaginationLoading || stateManager.hasMore == false) {
      return;
    }

    await stateManager.executePagination((page) async {
      final response = await fetch(size: size, number: page);
      if (response.data != null) {
        items.addAll(response.data!);
        stateManager.hasMore =
            response.data!.isNotEmpty && response.data!.length >= size;
      }
    }, onError: (String) {});
  }

  @action
  void clearData() {
    stateManager.resetPagination();
    items.clear();
    data = null;
  }

  @action
  void setData(T newData) {
    data = newData;
  }

  @action
  Future<void> fetchData(Future<ObjectResponse<T>> Function() fetch) async {
    stateManager.reset();

    final result = await stateManager.execute(
      () async {
        final response = await fetch();
        return response.data;
      },
      onError: handleError, onSuccess: () {},
      // onSuccess: handleSuccess,
    );

    if (result != null) {
      data = result;
    }
  }

  @action
  Future<void> postData<R>(
    Future<ObjectResponse<R>> Function() post, {
    String? successMessage,
  }) async {
    stateManager.reset();

    final result = await stateManager.execute(
      () async {
        final response = await post();
        return response;
      },
      onError: handleError,
      onSuccess: () => handleSuccess(successMessage),
    );

    if (result?.data == null) {
      return;
    }
    // if(result == ObjectResponse<R>) {
    data = (result as ObjectResponse<T>).data;
    // }
  }

  @action
  Future<R?> deleteData<R>(
    Future<ObjectResponse<R>> Function() delete, {
    String? successMessage,
  }) async {
    stateManager.reset();

    final result = await stateManager.execute(
      () async {
        final response = await delete();
        return response.data;
      },
      onError: handleError,
      onSuccess: () => handleSuccess(successMessage),
    );

    return result;
  }

  @action
  Future<R?> updateData<R>(
    Future<ObjectResponse<R>> Function() update, {
    String? successMessage,
  }) async {
    stateManager.reset();

    final result = await stateManager.execute(
      () async {
        final response = await update();
        return response.data;
      },
      onError: handleError,
      onSuccess: () => handleSuccess(successMessage),
    );

    return result;
  }
}
