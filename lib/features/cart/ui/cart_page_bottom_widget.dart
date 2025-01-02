import 'package:flutter/material.dart';
import 'package:grocery/features/cart/cart_bloc.dart';
import 'package:grocery/features/home/models/home_product_data_model.dart';

class CartPageBottomWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;
  const CartPageBottomWidget({super.key, required this.productDataModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      color: Colors.green,
      child: Row(
        children: [
          Column(
            children: [
              Text("Total Items = ",style: TextStyle(fontSize: 18),),
              Text("\$${productDataModel.price}/-"),
            ],
          ),
          Container(decoration: BoxDecoration(border: Border.symmetric(),color: Colors.blue),height: 20,width: 40,)
        ],
      ),
    );
  }
}
