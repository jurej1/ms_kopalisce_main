import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_repository/info_repository.dart';

import '../home.dart';

class AdditionalInfoDisplayer extends StatelessWidget {
  const AdditionalInfoDisplayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdditionalInfoBloc, AdditionalInfoState>(
      builder: (context, state) {
        if (state is AdditionalInfoLoading) {
          return BlocBuilder<OpenTimeBloc, OpenTimeState>(
            builder: (context, state) {
              if (state is OpenTimeLoading) {
                return Container();
              } else {
                return const LinearProgressIndicator();
              }
            },
          );
        } else if (state is AdditionalInfoLoadSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ostale Informacije',
                style: Theme.of(context).textTheme.titleLarge,
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
    final style = Theme.of(context).textTheme.bodyLarge;

    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final val = values[index];
        return Text(
          val.val,
          style: style,
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
        );
      },
      itemCount: values.length,
    );
  }
}
