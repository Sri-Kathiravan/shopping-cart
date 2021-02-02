import 'package:app/blocs/bloc_manager.dart';
import 'package:app/blocs/cart_bloc.dart';
import 'package:app/data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductInfoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return _ProductInfoScreenStateful();
  }

}

class _ProductInfoScreenStateful extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ProductInfoScreenState();
  }

}

class _ProductInfoScreenState extends State<_ProductInfoScreenStateful> {

  ProductDm _selectedProduct;

  @override
  void initState() {
    super.initState();
    _selectedProduct = BlocManager.getInstance().getCartBloc().currentState.selectedProduct;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[200],
                      width: 2
                    )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.center,
                        child: Image.network(
                          "${_selectedProduct.imageUrl}",
                          fit: BoxFit.fill,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.04,
                          left: MediaQuery.of(context).size.width * 0.04,
                        ),
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10000)),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: MediaQuery.of(context).size.width * 0.07,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.04,
                        left: MediaQuery.of(context).size.width * 0.04,
                        right: MediaQuery.of(context).size.width * 0.04,
                        bottom: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              "${_selectedProduct.name}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black87,
                                fontFamily: "QuicksandBold",
                                fontSize: MediaQuery.of(context).size.width * 0.06,
                              ),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.02,
                            ),
                            child: Text(
                              "${_selectedProduct.dosage}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "QuicksandBold",
                                fontSize: MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ),

                          Container(
                            alignment: AlignmentDirectional.topStart,
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.05,
                            ),
                            child: Text(
                              "Ingredients:",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: "QuicksandBold",
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ),

                          Container(
                            alignment: AlignmentDirectional.topStart,
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.02,
                            ),
                            child: Text(
                              "${_selectedProduct.ingredients}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "QuicksandSemiBold",
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ),

                          Container(
                            alignment: AlignmentDirectional.topStart,
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.05,
                            ),
                            child: Text(
                              "Description:",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: "QuicksandBold",
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ),

                          Container(
                            alignment: AlignmentDirectional.topStart,
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.02,
                            ),
                            child: Text(
                              "${_selectedProduct.description}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "QuicksandSemiBold",
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ),

                          Container(
                            alignment: AlignmentDirectional.topStart,
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.08,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                InkWell(
                                  onTap: () {
                                    if(_selectedProduct.cartCount > 0) {
                                      setState(() {
                                        _selectedProduct.cartCount--;
                                        if(_selectedProduct.cartCount == 0) {
                                          _removeItemFromCart(_selectedProduct);
                                        }
                                      });
                                    }
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width * 0.1,
                                      height: MediaQuery.of(context).size.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.02)),
                                      color: Colors.red,
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width * 0.08,
                                    ),
                                  ),
                                ),

                                Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * 0.04,
                                    right: MediaQuery.of(context).size.width * 0.04,
                                  ),
                                  child: Text(
                                    "${_selectedProduct.cartCount}",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: "QuicksandBold",
                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                    ),
                                  ),
                                ),

                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if(_selectedProduct.cartCount == 0) {
                                        _selectedProduct.cartCount++;
                                        BlocManager.getInstance().getCartBloc().currentState.cartItems.add(_selectedProduct);
                                        BlocManager.getInstance().getCartBloc().add(CART_EVENT.REFRESH_CART);
                                      } else {
                                        _selectedProduct.cartCount++;
                                        _refreshCartCount(_selectedProduct);
                                      }

                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.02)),
                                      color: Colors.red,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width * 0.08,
                                    ),
                                  ),
                                ),

                                Expanded(child: Container()),

                                Container(
                                  alignment: AlignmentDirectional.topStart,
                                  margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * 0.02,
                                  ),
                                  child: Text(
                                    "₹ ${_selectedProduct.amount}",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: "QuicksandBold",
                                      fontSize: MediaQuery.of(context).size.width * 0.06,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  void _removeItemFromCart(ProductDm product) {
    List<ProductDm> tmpItems = BlocManager.getInstance().getCartBloc().currentState.cartItems;
    for(int i = 0; i < tmpItems.length; i++) {
      if(tmpItems[i].id == product.id) {
        tmpItems.removeAt(i);
        break;
      }
    }
    BlocManager.getInstance().getCartBloc().currentState.cartItems = tmpItems;
    BlocManager.getInstance().getCartBloc().add(CART_EVENT.REFRESH_CART);
  }

  void _refreshCartCount(ProductDm product) {
    List<ProductDm> tmpItems = BlocManager
        .getInstance()
        .getCartBloc()
        .currentState
        .cartItems;
    for (int i = 0; i < tmpItems.length; i++) {
      if (tmpItems[i].id == product.id) {
        tmpItems[i] = product;
        break;
      }
    }
    BlocManager.getInstance().getCartBloc().currentState.cartItems = tmpItems;
    BlocManager.getInstance().getCartBloc().add(CART_EVENT.REFRESH_CART);
  }

}