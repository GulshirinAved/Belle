// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:get_it/get_it.dart';

// import '../../../features/cart/data/repository/cart_repository.dart';

// enum CartSyncStatus { success, loading, error, unset }

// class CartProductAction {
//   final int? id;
//   int? key;
//   final int quantity;
//   final CartAction cartAction;

//   CartProductAction(this.id, this.quantity, this.cartAction);

//   factory CartProductAction.add(int id, int quantity) =>
//       CartProductAction(id, quantity, CartAction.add);

//   factory CartProductAction.update(int? id, int quantity) =>
//       CartProductAction(id, quantity, CartAction.update);

//   factory CartProductAction.remove(int? id) =>
//       CartProductAction(id, 0, CartAction.remove);
// }

// enum CartAction { add, update, remove }

// class CartSyncHelper {
//   final CartRepository _cartRepository = GetIt.instance<CartRepository>();

//   final int _timerDelayTime = 2000;
//   late Timer? _timer;
//   late Map<int, CartProductAction> _pendingProducts;
//   late Map<int, CartProductAction> _sendingProducts;
//   late List<int> _errorList;
//   bool _wasCancelled = false;

//   final Function(int)? onProductAdded;
//   final Function(CartSyncStatus)? statusUpdated;
//   final String? uuid;

//   late CartSyncStatus _cartSyncStatus;

//   CartSyncHelper(
//       {required this.onProductAdded, required this.statusUpdated, this.uuid}) {
//     _pendingProducts = {};
//     _sendingProducts = {};
//     _errorList = [];
//     _cartSyncStatus = CartSyncStatus.unset;
//   }

//   void retry() {
//     _timer?.cancel();
//     _sendProducts();
//   }

//   void _cartUpdated({bool isAdd = false}) {
//     debugPrint('Cart was updated');
//     _timer?.cancel();
//     if (isAdd) {
//       if (_sendingProducts.isEmpty && !_wasCancelled) {
//         _sendProducts();
//       }
//     } else {
//       _timer = Timer(Duration(milliseconds: _timerDelayTime), () {
//         debugPrint('Timer started to send products!');
//         if (_sendingProducts.isEmpty && !_wasCancelled) {
//           _sendProducts();
//         }
//       });
//     }
//   }

//   void addProduct(int productId, int quantity) async {
//     if (_cartSyncStatus != CartSyncStatus.loading) {
//       _updateCartSyncStatus(CartSyncStatus.loading);
//     }
//     _cartUpdated();
//     _processProductAction(productId, CartAction.add, quantity);
//   }

//   void removeProduct(int productId, {int? productKey}) async {
//     if (_cartSyncStatus != CartSyncStatus.loading) {
//       _updateCartSyncStatus(CartSyncStatus.loading);
//     }
//     _cartUpdated();
//     _processProductAction(productId, CartAction.remove, null, productKey);
//   }

//   void updateProduct(int productId, int quantity) async {
//     if (_cartSyncStatus != CartSyncStatus.loading) {
//       _updateCartSyncStatus(CartSyncStatus.loading);
//     }
//     _cartUpdated();
//     _processProductAction(productId, CartAction.update, quantity);
//   }

//   void _processProductAction(int productId, CartAction action, int? quantity,
//       [int? productKey]) {
//     if (_sendingProducts.containsKey(productId)) {
//       if (_sendingProducts[productId]?.cartAction == CartAction.add ||
//           _sendingProducts[productId]?.cartAction == CartAction.update) {
//         _pendingProducts[productId] = CartProductAction.update(
//             _sendingProducts[productId]?.id, quantity ?? 0);
//       }
//     } else {
//       _pendingProducts[productId] =
//           CartProductAction.add(productId, quantity ?? 0);
//     }
//   }

//   void _sendProducts() {
//     if (_pendingProducts.isNotEmpty) {
//       _updateCartSyncStatus(CartSyncStatus.loading);
//       _errorList.clear();
//       if (!_wasCancelled) {
//         statusUpdated!(_cartSyncStatus);
//       }
//       _sendingProducts.addAll(_pendingProducts);
//       _pendingProducts.clear();
//       _sendingProducts.forEach((productId, cartProductAction) {
//         switch (cartProductAction.cartAction) {
//           case CartAction.remove:
//             _makeRemoveProductAction(productId);
//             break;
//           case CartAction.add:
//             _makeAddProductAction(productId, cartProductAction.quantity);
//             break;
//           case CartAction.update:
//             _makeUpdateProductAction(productId, cartProductAction.quantity);
//             break;
//           default:
//             break;
//         }
//       });
//     }
//   }

//   Future<void> _makeRemoveProductAction(int productId) async {
//     try {
//       await _cartRepository.removeProductFromCart(productKey: productId);
//       _sendingProducts.remove(productId);
//       _syncStatusUpdate(CartSyncStatus.success);
//     } catch (e) {
//       _handleError(e, productId);
//     }
//   }

//   Future<void> _makeAddProductAction(int productId, int? quantity) async {
//     try {
//       int productKey = await _cartRepository.addProductToCart(
//           uuid: uuid ?? '', productId: productId, quantity: quantity);
//       if (_pendingProducts.containsKey(productId)) {
//         _pendingProducts[productId]?.key = productKey;
//       }
//       if (onProductAdded != null && !_wasCancelled) {
//         onProductAdded!(productId);
//       }
//       _sendingProducts.remove(productId);
//       _syncStatusUpdate(CartSyncStatus.success);
//     } catch (e) {
//       _handleError(e, productId);
//     }
//   }

//   Future<void> _makeUpdateProductAction(int productId, int? quantity) async {
//     try {
//       await _cartRepository.updateProductCount(
//           productKey: productId, quantity: quantity);
//       _sendingProducts.remove(productId);
//       _syncStatusUpdate(CartSyncStatus.success);
//     } catch (e) {
//       _handleError(e, productId);
//     }
//   }

//   void _syncStatusUpdate(CartSyncStatus status) {
//     _cartSyncStatus = status;
//     if (_pendingProducts.isEmpty &&
//         _sendingProducts.isEmpty &&
//         _errorList.isEmpty &&
//         _cartSyncStatus != CartSyncStatus.success) {
//       _updateCartSyncStatus(CartSyncStatus.success);
//     } else if (_errorList.isNotEmpty &&
//         _sendingProducts.isEmpty &&
//         _cartSyncStatus != CartSyncStatus.error) {
//       _updateCartSyncStatus(CartSyncStatus.error);
//     } else if (_cartSyncStatus != CartSyncStatus.loading) {
//       _updateCartSyncStatus(CartSyncStatus.loading);
//     }
//   }

//   void _handleError(dynamic e, int productId) {
//     debugPrint('Cart product action response error: $e');
//     _sendingProducts.remove(productId);
//     _errorList.add(productId);
//     _syncStatusUpdate(CartSyncStatus.error);
//     if (_pendingProducts.containsKey(productId)) {
//       if (_pendingProducts[productId]?.cartAction == CartAction.add ||
//           _pendingProducts[productId]?.cartAction == CartAction.update) {
//         _pendingProducts[productId] = CartProductAction.update(
//             productId, _pendingProducts[productId]?.quantity ?? 0);
//       }
//     } else {
//       _pendingProducts[productId] = CartProductAction.remove(productId);
//     }
//   }

//   void _updateCartSyncStatus(CartSyncStatus status) {
//     _cartSyncStatus = status;
//     if (statusUpdated != null && !_wasCancelled) {
//       statusUpdated!(_cartSyncStatus);
//     }
//     if (_pendingProducts.isEmpty &&
//         _sendingProducts.isEmpty &&
//         _errorList.isEmpty &&
//         _cartSyncStatus != CartSyncStatus.success) {
//       _cartSyncStatus = CartSyncStatus.success;
//       if (statusUpdated != null && !_wasCancelled) {
//         statusUpdated!(_cartSyncStatus);
//       }
//     } else if (_errorList.isNotEmpty &&
//         _sendingProducts.isEmpty &&
//         _cartSyncStatus != CartSyncStatus.error) {
//       _cartSyncStatus = CartSyncStatus.error;
//       if (statusUpdated != null && !_wasCancelled) {
//         statusUpdated!(_cartSyncStatus);
//       }
//     } else if (_cartSyncStatus != CartSyncStatus.loading) {
//       _cartSyncStatus = CartSyncStatus.loading;
//       if (statusUpdated != null && !_wasCancelled) {
//         statusUpdated!(_cartSyncStatus);
//       }
//     }
//   }

//   void clear() {
//     _wasCancelled = true;
//     _timer?.cancel();
//     _pendingProducts.clear();
//     _sendingProducts.clear();
//     _errorList.clear();
//   }
// }
