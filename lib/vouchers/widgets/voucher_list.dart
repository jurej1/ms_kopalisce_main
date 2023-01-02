import 'package:coupon_repository/coupon_repository.dart';
import 'package:flutter/material.dart';

class VoucherList extends StatefulWidget {
  const VoucherList({
    Key? key,
    required this.isOnBottom,
    required this.vouchers,
  }) : super(key: key);

  final VoidCallback isOnBottom;
  final List<VoucherUser> vouchers;

  @override
  State<VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListView.separated(
      controller: _scrollController,
      padding: EdgeInsets.only(top: size.height * 0.15),
      itemCount: 20,
      separatorBuilder: (context, index) {
        return Container(height: 20);
      },
      itemBuilder: (context, index) {
        return Container(
          color: Colors.red,
          height: 40,
          width: double.infinity,
        );
      },
    );
  }

  void _onScroll() {
    if (_isBottom) widget.isOnBottom;
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
