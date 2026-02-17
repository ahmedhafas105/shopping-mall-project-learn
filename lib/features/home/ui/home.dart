import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shaas_grocery_app/features/cart/ui/cart.dart';
import 'package:shaas_grocery_app/features/home/bloc/home_bloc.dart';
import 'package:shaas_grocery_app/features/home/ui/widgets/product_tile.dart';
import 'package:shaas_grocery_app/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Wishlist()),
          );
        } else if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cart()),
          );
        }
      },
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.blue[400]),
            ),
          );
        } else if (state is HomeLoadedSuccessState) {
          final successState = state as HomeLoadedSuccessState;
          return Scaffold(
            appBar: AppBar(
              title: Text("Shaas Grocery App"),
              backgroundColor: Colors.blue[400],
              actions: [
                IconButton(
                  onPressed: () {
                    homeBloc.add(HomeWishlistButtonNavigateEvent());
                  },
                  icon: Icon(Icons.favorite_border_rounded),
                ),
                IconButton(
                  onPressed: () {
                    homeBloc.add(HomeCartButtonNavigateEvent());
                  },
                  icon: Icon(Icons.shopping_cart_checkout_rounded),
                ),
              ],
            ),
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF141E30), Color(0xFF243B55)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                  return ProductTileWidget(
                    productDataModel: successState.products[index]
                  );
                },
              ),
            ),
          );
        } else if (state is HomeErrorState) {
          return Scaffold(body: Center(child: Text("Error - 404")));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
