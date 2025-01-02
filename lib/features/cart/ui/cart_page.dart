import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery/Data/cart_items.dart';
import 'package:grocery/features/cart/cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/features/cart/ui/cart_tile_widget.dart';
import 'package:grocery/features/home/home_bloc.dart';
import 'package:grocery/features/home/models/home_product_data_model.dart';
import 'package:grocery/features/user_detail_UI.dart';

import '../../home/ui/home_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    countTotal(cartItems);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text("Cart Page"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          if (true) {
            countTotal(cartItems);
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              countTotal(cartItems);

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: successState.cartItems.length,
                        itemBuilder: (context, index) {
                          Index = index;
                          final List<ProductDataModel> cartItemsList =
                              cartItems.toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CartTileWidget(
                                  cartBloc: cartBloc,
                                  productDataModel: cartItemsList[Index]),
                            ],
                          );
                        }),
                  ),
                  SafeArea(
                    child: Container(
                      color: Colors.tealAccent,
                      height: 75,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          const Text(
                            "Total : ",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "\$" + total.toStringAsFixed(2),
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(
                            width: 90,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UserForm()));
                            },
                            child: Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),color: Colors.blue),
                              child:const Center(
                                  child: Text(
                                "Proceed",
                                style: TextStyle(fontSize: 24),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            default:
          }
          return Container();
        },
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(total: total),
    );
  }
}
