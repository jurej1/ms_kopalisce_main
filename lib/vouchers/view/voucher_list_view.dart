import 'package:coupon_repository/coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_kopalisce_main/vouchers/vouchers.dart';

class VoucherViewList extends StatelessWidget {
  const VoucherViewList._({Key? key}) : super(key: key);

  static Widget providers() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VoucherViewSelectorCubit(),
        ),
      ],
      child: const VoucherViewList._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: BlocBuilder<VoucherViewSelectorCubit, VoucherStatus>(
              builder: (context, state) {
                if (state == VoucherStatus.valid) {
                  return const _VoucherValidListDisplayer();
                } else if (state == VoucherStatus.expired) {
                  return const _VoucherExpiredListDisplayer();
                } else if (state == VoucherStatus.used) {
                  return const _VoucherUsedListDisplayer();
                }

                return Container();
              },
            ),
          ),
          Positioned(
            top: size.height * 0.07,
            child: const VoucherTabBar(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(VoucherWheelView.route(context));
        },
        child: const Icon(Icons.circle),
      ),
    );
  }
}

class _VoucherValidListDisplayer extends StatelessWidget {
  const _VoucherValidListDisplayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoucherValidListBloc, VoucherListState>(
      builder: (context, state) {
        if (state is VoucherListLoading) {
          return const _Loading();
        } else if (state is VoucherListSucess) {
          return VoucherList(
            vouchers: state.vouchers,
            isOnBottom: () {
              BlocProvider.of<VoucherValidListBloc>(context).add(VoucherListLoadMoreRequested());
            },
          );
        } else if (state is VoucherListEmpty) {
          return const _EmptyList();
        }
        return Container();
      },
    );
  }
}

class _VoucherUsedListDisplayer extends StatelessWidget {
  const _VoucherUsedListDisplayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoucherUsedListBloc, VoucherListState>(
      builder: (context, state) {
        if (state is VoucherListLoading) {
          return const _Loading();
        } else if (state is VoucherListSucess) {
          return VoucherList(
            vouchers: state.vouchers,
            isOnBottom: () {
              BlocProvider.of<VoucherUsedListBloc>(context).add(VoucherListLoadMoreRequested());
            },
          );
        } else if (state is VoucherListEmpty) {
          return const _EmptyList();
        }
        return Container();
      },
    );
  }
}

class _VoucherExpiredListDisplayer extends StatelessWidget {
  const _VoucherExpiredListDisplayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoucherExpiredListBloc, VoucherListState>(
      builder: (context, state) {
        if (state is VoucherListLoading) {
          return const _Loading();
        } else if (state is VoucherListSucess) {
          return VoucherList(
            vouchers: state.vouchers,
            isOnBottom: () {
              BlocProvider.of<VoucherExpiredListBloc>(context).add(VoucherListLoadMoreRequested());
            },
          );
        } else if (state is VoucherListEmpty) {
          return const _EmptyList();
        }
        return Container();
      },
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Zanekrat nimate kuponov.'),
      ),
    );
  }
}
