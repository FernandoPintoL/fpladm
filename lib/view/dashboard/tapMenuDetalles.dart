import 'package:flutter/material.dart';
import '../../app/models/tap_info.dart';
import '../components/responsive.dart';
import '../config/pallet.dart';
import 'tap_info_list.dart';
import 'tap_info_card.dart';

class TapMenuDetalles extends StatelessWidget {
  List<TapInfo> listTaps;
  TapMenuDetalles({required this.listTaps,super.key});

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Responsive(
      mobile: TapInfoCardGridView(
        listTaps: listTaps,
        crossAxisCount: _size.width < 650 ? 2 : 4,
        childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
      ),
      tablet: TapInfoCardGridView(listTaps: listTaps),
      desktop: TapInfoCardGridView(
        listTaps: listTaps,
        childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
      ),
    );
  }
}

class TapInfoCardGridView extends StatelessWidget {
   TapInfoCardGridView({
     required this.listTaps,
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  List<TapInfo> listTaps;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyTaps.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => TapInfoCard(info: listTaps[index]),
    );
  }
}

