import 'package:app/blocs/bloc_manager.dart';
import 'package:app/blocs/cart_bloc.dart';
import 'package:app/data_model/data_model.dart';
import 'package:app/helpers/ui_helpers.dart';
import 'package:app/screens/cart_screen.dart';
import 'package:app/screens/product_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    /*return BlocProvider<CartBloc>(
      create: (context) => BlocManager.getInstance().getCartBloc(),
      child: _HomeScreenStateful(),
    );*/
    return _HomeScreenStateful();
  }

}

class _HomeScreenStateful extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }

}

class _HomeScreenState extends State<_HomeScreenStateful> {

  List<ProductDm> _products;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {

    print("Home build called");
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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Expanded(
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "Drug List",
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: "QuicksandBold",
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if(BlocManager.getInstance().getCartBloc().currentState.cartItems != null
                            && BlocManager.getInstance().getCartBloc().currentState.cartItems.length > 0) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                        } else {
                          getToast("No items in cart...");
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: AlignmentDirectional.center,
                              child: Icon(
                                Icons.shopping_cart,
                                size: MediaQuery.of(context).size.width * 0.07,
                                color: Colors.black45,
                              ),
                            ),
                            BlocBuilder<CartBloc, CartState>(
                              builder: (BuildContext context, CartState cartState) {
                                print('Home Screen - Cart - ${cartState.cartItems.length}');
                                if(cartState.cartItems != null && cartState.cartItems.length > 0) {
                                  return Container(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: Container(
                                      alignment: AlignmentDirectional.center,
                                      width: MediaQuery.of(context).size.width * 0.05,
                                      height: MediaQuery.of(context).size.width * 0.05,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10000)),
                                        color: Colors.red[600],
                                      ),
                                      child: Text(
                                        "${cartState.cartItems.length}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "QuicksandBold",
                                          fontSize: MediaQuery.of(context).size.width * 0.035,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }

                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return _buildDrugItem(_products[position]);
                    },
                    itemCount: _products.length,
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
          _setSelectedProduct(product);
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductInfoScreen()));
        },
        child: Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.02,
            left: MediaQuery.of(context).size.width * 0.04,
            right: MediaQuery.of(context).size.width * 0.04,
            bottom: MediaQuery.of(context).size.width * 0.02,
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
              )
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

  void initData() {
    _products = new List();
    _products.add(new ProductDm(1, "Ecosprin 75 Tablet", "Aspirin (75mg)", 26.58,
        "https://res.cloudinary.com/du8msdgbj/image/upload/l_watermark_346,w_690,h_700/a_ignore,w_690,h_700,c_pad,q_auto,f_auto/v1600081737/cropped/reowbvajejs6awykdplk.jpg",
        "Take this medicine in the dose and duration as advised by your doctor. Swallow it as a whole. Do not chew, crush or break it. Ecosprin 75 Tablet is to be taken with food.",
        "Ecosprin 75 Tablet is a non-steroidal anti-inflammatory drug (NSAID) with anti-platelet action. It works by preventing platelets from sticking together which decreases the formation of harmful blood clots. This lowers the chance of heart attack or stroke."
        , 0
    ));
    _products.add(new ProductDm(2, "Zincovit Syrup", "Bottle of 200 ml Syrup", 178.56,
        "https://res.cloudinary.com/du8msdgbj/image/upload/l_watermark_346,w_120,h_120/a_ignore,w_120,h_120,c_fit,q_auto,f_auto/v1600103585/cropped/khehjypi5qipvaqp5e8q.jpg",
        "Take Zincovit syrup as advised by your doctor or pharmacist. Do not take more than the daily recommended dose of this supplement as it may lead to side effects.",
        "It is advised to use a measuring spoon or cup to dispense the exact prescribed quantity of this syrup. Ideally, it should be taken once daily, but the frequency may differ depending upon your condition and your doctor’s recommendation."
        , 0
    ));
    _products.add(new ProductDm(3, "SBL Thuja Ointment", "Tube of 25 gm Ointment", 156,
        "https://res.cloudinary.com/du8msdgbj/image/upload/l_watermark_346,w_120,h_120/a_ignore,w_120,h_120,c_fit,q_auto,f_auto/v1608239842/cropped/k1aiut0dpkrocbstpqaj.jpg",
        "Thuja Occidentalis MT in ointment base (White Petrolatum, Paraffin and Lanoin)",
        "Apply on the affected area two times in a day or as prescribed by the physician"
        , 0
    ));
    _products.add(new ProductDm(4, "Shelcal 500 Tablet", "Aspirin", 26.58,
        "https://res.cloudinary.com/du8msdgbj/image/upload/l_watermark_346,w_120,h_120/a_ignore,w_120,h_120,c_fit,q_auto,f_auto/v1600090007/cropped/chesipqujcvcsuy1m8iw.jpg",
        "It helps in keeping your bones strong and prevents osteoporosis. Calcium is used for building and maintaining healthy bones. Our body can get calcium from one of two sources namely food/diet or bones.",
        "Take Shelcal 500 as directed by your physician. In general, it is best to take it after meals, as the source of calcium in Shelcal 500 is calcium carbonate, which is absorbed well in the presence of food."
        , 0
    ));
    _products.add(new ProductDm(5, "Neeri KFT Sugar Free Syrup", "Bottle of 200 ml Syrup", 48.62,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMV30g6RZHd3Sy5VlTG2szhz8YbxVsP1ADdw&usqp=CAU",
        "Neeri Kft Sugar-Free Syrup is a poly-herbal Ayurvedic proprietary formulation to restore normalcy in kidney functional parameters in conditions of the acute or chronic kidney functional insufficiency.",
        "The phytoconstituents in the formulation act as potent anti-oxidant, immune- modulator and nephroprotective thereby multi-mechanism tends to check further degenerative alterations and promotes restoring the functional capacity of nephrons, thus normalizes the deviated functional parameters of kidney like serum creatinine, serum urea, serum proteins etc."
        , 0
    ));
    _products.add(new ProductDm(6, "T-Bact 2% Ointment", "Tube of 15 gm Ointment", 158.58,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkoSLejuYxj10X55HLCEOOw5dp14ki80dx3g&usqp=CAU",
        "T-Bact 2% Ointment is an antibiotic medicine used to treat certain skin infections such as impetigo (red sores), recurring boils and others. It works by killing certain bacteria. This helps to improve your symptoms and cure the underlying infection.",
        "T-Bact 2% Ointment is meant for external use only. It should be applied only to the affected area of the skin as per the dosage and schedule prescribed by your doctor. In order to get the most benefit, apply it regularly and preferably at the same time each day. Do not use larger amounts or apply it more often or for a longer duration than directed. This will only increase the risk of side effects."
        , 0
    ));
    _products.add(new ProductDm(7, "Duphaston 10mg Tablet", "Strip of 10 tablets", 76.25,
        "https://res.cloudinary.com/du8msdgbj/image/upload/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/v1600144642/cropped/haqxg5er0zebfw4gkjww.png",
        "Duphaston 10mg Tablet contains progesterone, a female hormone that is important in the regulation of ovulation and menstruation. It is used to cause menstrual periods in women who have not reached menopause but are not having periods due to a lack of natural progesterone in the body.",
        "This increases the chance of a successful pregnancy. You should use the medicine as prescribed for it to be effective. You may be asked to continue with this treatment for a period after becoming pregnant."
        , 0
    ));
    _products.add(new ProductDm(8, "Cremaffin Constipation Relief Sugar Free Mixed Fruit Syrup", "Bottle of 200 ml Syrup", 125.1,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQklB2QX46kavx-kZXxUC7Sn6vL611zbG1UEA&usqp=CAU",
        "It is used to provide gentle and effective relief from constipation. It softens the stool and makes it easier to pass. It is also recommended to prevent constipation and promote healthy bowel movement. It is known to provide prompt action and can be used by adults as well as older individuals to get rid of constipation.",
        "This syrup is safe when taken as advised by your doctor. It is also recommended for use in children. It is best to take this medicine at bedtime, preferably with water and if necessary, again in the morning or as advised by the physician. However, avoid taking it in excess as that may cause certain side effects such as abdominal cramps, vomiting, and nausea.",
        0
    ));
    _products.add(new ProductDm(9, "Telma-AM Tablet Prescription requred", "Strip of 15 tablets", 65.45,
        "https://res.cloudinary.com/du8msdgbj/image/upload/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/v1600106099/cropped/ewnxn29rqnhxatqkjidl.jpg",
        "Telma-AM Tablet contains two medicines, both of which help to control high blood pressure. It lowers the blood pressure by relaxing the blood vessels and making it easier for your heart to pump blood around your body. This will reduce your risk of having a heart attack or a stroke.",
        "Before taking this medicine, let your doctor know if you have any kidney or liver problems or severe dehydration. Pregnant or breastfeeding women should also consult their doctor before taking it. While using this medicine, your blood pressure will need to be checked often and your kidney function may also need to be tested.",
        0
    ));
    _products.add(new ProductDm(10, "Carbamide Forte Probiotics 30 Billion", "Prebiotics 100mg Vegetarian Capsule", 26.58,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4lGJXsj3_oM8knSKzHxZ7awcjtLDDJL1OkQ&usqp=CAU",
        "Carbamide Forte Probiotics 30 Billion cfu + Prebiotics 100mg Vegetarian Capsule contains a total of 30 Billion CFU with 16 carefully selected probiotic strains which are most beneficial for the health of the gut,  digestion and immunity. This strength makes it one of the most effective Pre and Probiotic supplement for men and women on the market.",
        "Due to added prebiotics advantage and advanced manufacturing process, the pre probiotic capsules are shelf-stable and don't require refrigeration."
        , 0
    ));

    _products.add(new ProductDm(11, "Zerodol-SP Tablet", "Aspirin (75mg)", 26.58,
        "https://res.cloudinary.com/du8msdgbj/image/upload/l_watermark_346,w_690,h_700/a_ignore,w_690,h_700,c_pad,q_auto,f_auto/v1600081737/cropped/reowbvajejs6awykdplk.jpg",
        "Take this medicine in the dose and duration as advised by your doctor. Swallow it as a whole. Do not chew, crush or break it. Ecosprin 75 Tablet is to be taken with food.",
        "Ecosprin 75 Tablet is a non-steroidal anti-inflammatory drug (NSAID) with anti-platelet action. It works by preventing platelets from sticking together which decreases the formation of harmful blood clots. This lowers the chance of heart attack or stroke."
        , 0
    ));
    _products.add(new ProductDm(12, "Himalaya Septilin Syrup", "Bottle of 200 ml Syrup", 178.56,
        "https://res.cloudinary.com/du8msdgbj/image/upload/l_watermark_346,w_120,h_120/a_ignore,w_120,h_120,c_fit,q_auto,f_auto/v1600103585/cropped/khehjypi5qipvaqp5e8q.jpg",
        "Take Zincovit syrup as advised by your doctor or pharmacist. Do not take more than the daily recommended dose of this supplement as it may lead to side effects.",
        "It is advised to use a measuring spoon or cup to dispense the exact prescribed quantity of this syrup. Ideally, it should be taken once daily, but the frequency may differ depending upon your condition and your doctor’s recommendation."
        , 0
    ));
    _products.add(new ProductDm(13, "Tacroz Forte Ointment", "Tube of 25 gm Ointment", 156,
        "https://res.cloudinary.com/du8msdgbj/image/upload/l_watermark_346,w_120,h_120/a_ignore,w_120,h_120,c_fit,q_auto,f_auto/v1608239842/cropped/k1aiut0dpkrocbstpqaj.jpg",
        "Thuja Occidentalis MT in ointment base (White Petrolatum, Paraffin and Lanoin)",
        "Apply on the affected area two times in a day or as prescribed by the physician"
        , 0
    ));
    _products.add(new ProductDm(14, "Montek LC Tablet", "Aspirin", 26.58,
        "https://res.cloudinary.com/du8msdgbj/image/upload/l_watermark_346,w_120,h_120/a_ignore,w_120,h_120,c_fit,q_auto,f_auto/v1600090007/cropped/chesipqujcvcsuy1m8iw.jpg",
        "It helps in keeping your bones strong and prevents osteoporosis. Calcium is used for building and maintaining healthy bones. Our body can get calcium from one of two sources namely food/diet or bones.",
        "Take Shelcal 500 as directed by your physician. In general, it is best to take it after meals, as the source of calcium in Shelcal 500 is calcium carbonate, which is absorbed well in the presence of food."
        , 0
    ));
    _products.add(new ProductDm(15, "Benadryl Syrup", "Bottle of 200 ml Syrup", 48.62,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMV30g6RZHd3Sy5VlTG2szhz8YbxVsP1ADdw&usqp=CAU",
        "Neeri Kft Sugar-Free Syrup is a poly-herbal Ayurvedic proprietary formulation to restore normalcy in kidney functional parameters in conditions of the acute or chronic kidney functional insufficiency.",
        "The phytoconstituents in the formulation act as potent anti-oxidant, immune- modulator and nephroprotective thereby multi-mechanism tends to check further degenerative alterations and promotes restoring the functional capacity of nephrons, thus normalizes the deviated functional parameters of kidney like serum creatinine, serum urea, serum proteins etc."
        , 0
    ));
    _products.add(new ProductDm(16, "Zole-F Ointment", "Tube of 15 gm Ointment", 158.58,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkoSLejuYxj10X55HLCEOOw5dp14ki80dx3g&usqp=CAU",
        "T-Bact 2% Ointment is an antibiotic medicine used to treat certain skin infections such as impetigo (red sores), recurring boils and others. It works by killing certain bacteria. This helps to improve your symptoms and cure the underlying infection.",
        "T-Bact 2% Ointment is meant for external use only. It should be applied only to the affected area of the skin as per the dosage and schedule prescribed by your doctor. In order to get the most benefit, apply it regularly and preferably at the same time each day. Do not use larger amounts or apply it more often or for a longer duration than directed. This will only increase the risk of side effects."
        , 0
    ));
    _products.add(new ProductDm(17, "Augmentin 625 Duo Tablet", "Strip of 10 tablets", 76.25,
        "https://res.cloudinary.com/du8msdgbj/image/upload/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/v1600144642/cropped/haqxg5er0zebfw4gkjww.png",
        "Duphaston 10mg Tablet contains progesterone, a female hormone that is important in the regulation of ovulation and menstruation. It is used to cause menstrual periods in women who have not reached menopause but are not having periods due to a lack of natural progesterone in the body.",
        "This increases the chance of a successful pregnancy. You should use the medicine as prescribed for it to be effective. You may be asked to continue with this treatment for a period after becoming pregnant."
        , 0
    ));
    _products.add(new ProductDm(18, "Arachitol Nano Bottle Oral Solution", "Bottle of 200 ml Syrup", 125.1,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQklB2QX46kavx-kZXxUC7Sn6vL611zbG1UEA&usqp=CAU",
        "It is used to provide gentle and effective relief from constipation. It softens the stool and makes it easier to pass. It is also recommended to prevent constipation and promote healthy bowel movement. It is known to provide prompt action and can be used by adults as well as older individuals to get rid of constipation.",
        "This syrup is safe when taken as advised by your doctor. It is also recommended for use in children. It is best to take this medicine at bedtime, preferably with water and if necessary, again in the morning or as advised by the physician. However, avoid taking it in excess as that may cause certain side effects such as abdominal cramps, vomiting, and nausea.",
        0
    ));
    _products.add(new ProductDm(19, "Pantocid Tablet", "Strip of 15 tablets", 65.45,
        "https://res.cloudinary.com/du8msdgbj/image/upload/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/v1600106099/cropped/ewnxn29rqnhxatqkjidl.jpg",
        "Telma-AM Tablet contains two medicines, both of which help to control high blood pressure. It lowers the blood pressure by relaxing the blood vessels and making it easier for your heart to pump blood around your body. This will reduce your risk of having a heart attack or a stroke.",
        "Before taking this medicine, let your doctor know if you have any kidney or liver problems or severe dehydration. Pregnant or breastfeeding women should also consult their doctor before taking it. While using this medicine, your blood pressure will need to be checked often and your kidney function may also need to be tested.",
        0
    ));
    _products.add(new ProductDm(20, "Sinarest New Tablet", "Prebiotics 100mg Vegetarian Capsule", 26.58,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4lGJXsj3_oM8knSKzHxZ7awcjtLDDJL1OkQ&usqp=CAU",
        "Carbamide Forte Probiotics 30 Billion cfu + Prebiotics 100mg Vegetarian Capsule contains a total of 30 Billion CFU with 16 carefully selected probiotic strains which are most beneficial for the health of the gut,  digestion and immunity. This strength makes it one of the most effective Pre and Probiotic supplement for men and women on the market.",
        "Due to added prebiotics advantage and advanced manufacturing process, the pre probiotic capsules are shelf-stable and don't require refrigeration."
        , 0
    ));
  }

  void _setSelectedProduct(ProductDm product) {
    List<ProductDm> tmpItems = BlocManager
        .getInstance()
        .getCartBloc()
        .currentState
        .cartItems;
    bool isAlreadyExist = false;
    for (int i = 0; i < tmpItems.length; i++) {
      if (tmpItems[i].id == product.id) {
        BlocManager.getInstance().getCartBloc().currentState.selectedProduct = tmpItems[i];
        isAlreadyExist = true;
        break;
      }
    }
    if(!isAlreadyExist) {
      BlocManager.getInstance().getCartBloc().currentState.selectedProduct = product;
    }
  }

}