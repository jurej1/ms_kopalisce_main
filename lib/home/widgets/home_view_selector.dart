import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';

class HomeViewSelector extends StatelessWidget implements PreferredSizeWidget {
  const HomeViewSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<HomeViewSelectorCubit, HomeViewSelectorState>(
      builder: (context, state) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: kBottomNavigationBarHeight,
            maxWidth: size.width,
            minHeight: kBottomNavigationBarHeight,
            minWidth: size.width,
          ),
          child: Material(
            color: Colors.blue,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: HomeViewSelectorState.values.map(
                (e) {
                  final bool isSelected = state == e;

                  final bool isHome = e.isHome;

                  Widget iconWidget = IconButton(
                    color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                    icon: Icon(e.mapStateToIcon()),
                    onPressed: () {
                      BlocProvider.of<HomeViewSelectorCubit>(context).valueUpdatedEnum(e);
                    },
                  );

                  Widget homeWidget = InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      BlocProvider.of<HomeViewSelectorCubit>(context).valueUpdatedEnum(e);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: kMinInteractiveDimension,
                      width: kMinInteractiveDimension,
                      child: InkWell(
                        child: Image.asset('assets/sobota_svica.png'),
                      ),
                    ),
                  );

                  return Transform.scale(
                    scale: isSelected ? 1.1 : 0.9,
                    child: isHome ? homeWidget : iconWidget,
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kBottomNavigationBarHeight);
}
