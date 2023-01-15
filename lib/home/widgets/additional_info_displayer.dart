import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_repository/info_repository.dart';

import '../home.dart';

class AdditionalInfoDisplayer extends StatelessWidget {
  const AdditionalInfoDisplayer({Key? key}) : super(key: key);

  static Widget providers() {
    return BlocProvider(
      create: (context) => AdditionalInfoBloc(RepositoryProvider.of<InfoRepository>(context))..add(AdditionalInfoLoadRequested()),
      child: const AdditionalInfoDisplayer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdditionalInfoBloc, AdditionalInfoState>(
      builder: (context, state) {
        if (state is AdditionalInfoLoading) {
          return const LinearProgressIndicator();
        } else if (state is AdditionalInfoLoadSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ostale Informacije',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (state.values.isEmpty) const Text('Zaenkrat ni nobenih dodatnih informacij'),
              if (state.values.isNotEmpty) _Builder(values: state.values),
            ],
          );
        } else if (state is AdditionalInfoFail) {
          return Container();
        }
        return Container();
      },
    );
  }
}

class _Builder extends StatelessWidget {
  const _Builder({
    Key? key,
    required this.values,
  }) : super(key: key);

  final List<AdditionalInfo> values;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final val = values[index];
        return Text(val.val);
      },
      separatorBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
        );
      },
      itemCount: values.length,
    );
  }
}
