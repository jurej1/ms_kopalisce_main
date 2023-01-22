import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_kopalisce_main/home/home.dart';

import '../../authentication/authentication.dart';

class InfoView extends StatelessWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     ElevatedButton(
      //       onPressed: () {
      //         BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogoutRequested());
      //       },
      //       child: const Text('LogOut'),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const WaterTemperatureDisplayer(),
            const SizedBox(height: 30),
            const OpenTimeDisplayer(),
            const SizedBox(height: 30),
            const AdditionalInfoDisplayer(),
          ],
        ),
      ),
      bottomNavigationBar: const HomeViewSelector(),
    );
  }
}
