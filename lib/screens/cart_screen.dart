import 'package:app/blocs/bloc_manager.dart';
import 'package:app/blocs/cart_bloc.dart';
import 'package:app/data_model/data_model.dart';
import 'package:app/screens/product_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    /*return BlocProvider<CartBloc>(
      create: (context) => BlocManager.getInstance().getCartBloc(),
      child: _CartScreenStateful(),
    );*/
    return _CartScreenStateful();
  }

}

class _CartScreenStateful extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _CartScreenState();
  }

}

class _CartScreenState extends State<_CartScreenStateful> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.06,
                  left: MediaQuery.of(context).size.width * 0.04,
                  right: MediaQuery.of(context).size.width * 0.04,
                  bottom: MediaQuery.of(context).size.width * 0.04,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: MediaQuery.of(context).size.width * 0.07,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "My Cart",
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: "QuicksandBold",
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (BuildContext context, CartState cartState) {
                      if(cartState.cartItems != null && cartState.cartItems.length > 0) {
                        return ListView.builder(
                          itemBuilder: (context, position) {
                            return _buildDrugItem(cartState.cartItems[position]);
                          },
                          itemCount: cartState.cartItems.length,
                        );
                      } else {
                        return Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "No items in cart",
                            style: TextStyle(
                              color: Colors.black87,
                              fontFamily: "QuicksandBold",
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        );
                      }

                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.04,
                  bottom: MediaQuery.of(context).size.width * 0.04,
                  left: MediaQuery.of(context).size.width * 0.04,
                  right: MediaQuery.of(context).size.width * 0.04,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
                  color: Colors.red,
                ),
                child: InkWell(
                  onTap: () {

                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: Text(
                      "CHECK OUT",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "QuicksandBold",
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrugItem(ProductDm product) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.width * 0.02,
        bottom: MediaQuery.of(context).size.width * 0.02,
      ),
      child: InkWell(
        onTap: () {
          BlocManager.getInstance().getCartBloc().currentState.selectedProduct = product;
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductInfoScreen()));
        },
        child: Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.03,
            left: MediaQuery.of(context).size.width * 0.04,
            right: MediaQuery.of(context).size.width * 0.04,
            bottom: MediaQuery.of(context).size.width * 0.03,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey[200],
                    width: 2,
                  )
                ),
               child: _buildImage(product.imageUrl),
              ),
              Expanded(
                child: Container(
                  alignment: AlignmentDirectional.topStart,
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.02,
                        ),
                        child: Text(
                          "${product.name}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: "QuicksandBold",
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                          ),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "${product.dosage}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "QuicksandSemiBold",
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                          ),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.04,
                        ),
                        child: Text(
                          "₹ ${product.amount}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: "QuicksandBold",
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          if(product.cartCount > 0) {
                            product.cartCount--;
                            _refreshCartCount(product);
                          }
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.08,
                        height: MediaQuery.of(context).size.width * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.02)),
                          color: Colors.red,
                        ),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),

                    Container(
                      alignment: AlignmentDirectional.center,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.02,
                        bottom: MediaQuery.of(context).size.width * 0.02,
                      ),
                      child: Text(
                        "${product.cartCount}",
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
                          product.cartCount++;
                          _refreshCartCount(product);
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.08,
                        height: MediaQuery.of(context).size.width * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.02)),
                          color: Colors.red,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        imageUrl,
        height: MediaQuery.of(context).size.width * 0.25,
        width: MediaQuery.of(context).size.width * 0.25,
        fit: BoxFit.fill,
      ),
    );
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