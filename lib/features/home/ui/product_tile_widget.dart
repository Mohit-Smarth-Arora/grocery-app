import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/Data/cart_items.dart';
import 'package:grocery/components/neu_box.dart';
import 'package:grocery/features/cart/cart_bloc.dart';
import 'package:grocery/features/home/home_bloc.dart';
import 'package:grocery/features/home/models/home_product_data_model.dart';
import 'package:grocery/features/home/ui/home_page.dart';

class ProductTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  final CartBloc cartBloc;


  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.homeBloc, required this.cartBloc});

  @override
  State<ProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {

  @override
  Widget build(BuildContext context) {
  return NeuBox(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              width: MediaQuery.of(context).size.width * 0.85,
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      IconButton(
                        onPressed: () {
                          widget.homeBloc.add(HomeProductWishlistButtonClickedEvent(clickedProduct: widget.productDataModel));

                        },
                        icon: Icon(
                          color: true ? Colors.red: Colors.black,
                          Icons.favorite,
                          size: 35,
                        ),
                      ),
                      const SizedBox(
                        width: 0,
                      ),
                      IconButton(
                        onPressed: () {
                          widget.homeBloc.add(HomeProductCartButtonClickedEvent(clickedProduct: widget.productDataModel));
                        },
                        icon: const Icon(
                          Icons.shopping_cart,
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
