import 'package:app/blocs/cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocManager {

  static BlocManager _instance;
  CartBloc _cartBloc;

  static BlocManager getInstance() {
    if(_instance == null) {
      _instance = new BlocManager();
    }
    return _instance;
  }

  CartBloc getCartBloc() {
    if(_cartBloc == null) {
      _cartBloc = new CartBloc();
    }
    return _cartBloc;
  }

  void refreshCartBloc(CartBloc bloc) {
    _cartBloc = bloc;
  }

}