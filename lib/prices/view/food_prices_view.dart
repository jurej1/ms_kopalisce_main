import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../prices.dart';

class FoodPricesView extends StatelessWidget {
  const FoodPricesView({Key? key}) : super(key: key);

  static MaterialPageRoute route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) {
        return const FoodPricesView();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.blue,
        ),
      ),
      body: BlocBuilder<FoodPricesListBloc, FoodPricesListState>(
        builder: (context, state) {
          if (state is FoodPricesListLoading) {
            return const _LoadingScreen();
          } else if (state is FoodPricesListFail) {
            return const _ErrorScreen();
          } else if (state is FoodPricesListLoadSucess) {
            return FoodPricesListBuilder(items: state.items);
          }
          return Container();
        },
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Sorry But there was an error'));
  }
}
