import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_repository/price_repository.dart';

import '../prices.dart';

class BathroomServicesView extends StatelessWidget {
  const BathroomServicesView({Key? key}) : super(key: key);

  static MaterialPageRoute route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) {
        return const BathroomServicesView();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cenik kart',
          style: TextStyle(color: Colors.blue),
        ),
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
      body: BlocBuilder<BathroomServicesBloc, BathroomServicesState>(
        builder: (context, state) {
          if (state is BathroomServicesLoading) {
            return const _LoadingScreen();
          } else if (state is BathroomServicesLoadFail) {
            return const _ErrorScreen();
          } else if (state is BathroomServicesLoadSuccess) {
            return BathroomServicesBuilder(tickets: state.tickets);
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
    return const Center(
      child: Text('Sorry there was an error when loading'),
    );
  }
}
