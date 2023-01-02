import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../prices.dart';

class BathroomServicesView extends StatelessWidget {
  const BathroomServicesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bathroom Services'),
      ),
      body: BlocBuilder<BathroomServicesBloc, BathroomServicesState>(
        builder: (context, state) {
          if (state is BathroomServicesLoading) {
            return const _LoadingScreen();
          } else if (state is BathroomServicesLoadFail) {
            return const _ErrorScreen();
          } else if (state is BathroomServicesLoadSuccess) {
            return BathroomServicesBuilder(loadSuccess: state);
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
