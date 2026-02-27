part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class ItemRemoteFromWishlistEvent extends WishlistEvent {
  final ProductDataModel productDataModel;
  ItemRemoteFromWishlistEvent({
    required this.productDataModel,
  });
}