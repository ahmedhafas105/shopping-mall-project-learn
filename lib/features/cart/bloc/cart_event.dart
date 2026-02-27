part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class ItemRemoveFromCartEvent extends CartEvent {
  final ProductDataModel productDataModel;
  ItemRemoveFromCartEvent({required this.productDataModel});
}