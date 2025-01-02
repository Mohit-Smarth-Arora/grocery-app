
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/Data/cart_items.dart';
import 'package:grocery/components/neu_box.dart';
import 'package:grocery/features/cart/cart_bloc.dart';
import 'package:grocery/features/home/models/home_product_data_model.dart';
import 'package:grocery/features/home/ui/home_page.dart';
import 'package:grocery/Data/cart_items.dart';


class CartTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;

  const CartTileWidget(
      {super.key, required this.productDataModel, required this.cartBloc});

  @override
  State<CartTileWidget> createState() => _CartTileWidgetState();
}

class _CartTileWidgetState extends State<CartTileWidget> {
  @override
  Widget build(BuildContext context) {
    return NeuBox(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.productDataModel.imageUrl ?? "",
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                widget.productDataModel.name ?? "",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.9,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.productDataModel.description ?? "",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "\$${widget.productDataModel.price}/-",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      Text(
                        "Item Count: ${widget.productDataModel.quantity}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          widget.cartBloc.add(CartRemoveFromCartEvent(
                              cartProductDataModel: widget.productDataModel));
                        },
                        icon: const Icon(
                          Icons.remove_shopping_cart_outlined,
                          color: Colors.red,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
