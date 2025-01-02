import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/features/home/home_bloc.dart';
import 'package:grocery/features/cart/ui/cart_page.dart';
import 'package:grocery/features/home/models/home_product_data_model.dart';
import 'package:grocery/features/home/ui/product_tile_widget.dart';
import 'package:grocery/features/wish_list/ui/wish_list_page.dart';
import 'package:grocery/features/cart/cart_bloc.dart';

int cartItemCount = 0;
int Index = 0;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  final CartBloc cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartPage()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishListPage()));
        } else if (state is HomeProductItemWishlistedActionState) {

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Item Wishlisted")));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Item Carted")));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                elevation: 20,
                backgroundColor: Colors.grey,
                title: const Text(
                  "Grocery App",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      size: 35,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      size: 35,
                    ),
                  ),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                        cartBloc: cartBloc,
                        homeBloc: homeBloc,
                        productDataModel: successState.products[index]);
                  }),
            );

          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text(
                  "ERROR",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
