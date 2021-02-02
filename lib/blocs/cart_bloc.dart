import 'package:app/blocs/bloc_manager.dart';
import 'package:app/data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CART_EVENT {
  EMPTY, REFRESH_CART
}

class CartState {
  CART_EVENT event;
  ProductDm selectedProduct;
  List<ProductDm> cartItems;
}

class CartBloc extends Bloc<CART_EVENT, CartState> {

  CartState currentState;

  CartBloc() {
    BlocManager.getInstance().refreshCartBloc(this);
  }

  @override
  CartState get initialState {
    currentState = new CartState();
    currentState.event = CART_EVENT.EMPTY;
    currentState.cartItems = new List();
    return currentState;
  }

  @override
  Stream<CartState> mapEventToState(CART_EVENT event) async* {
    currentState.event = event;

    switch(event) {

      case CART_EVENT.EMPTY:
        break;
      case CART_EVENT.REFRESH_CART:
        break;
    }
    yield _duplicateState(currentState);
  }

  CartState _duplicateState(CartState oldState) {
    CartState newState = new CartState();
    newState.event = oldState.event;
    newState.selectedProduct = oldState.selectedProduct;
    newState.cartItems = oldState.cartItems;
    return newState;
  }

}