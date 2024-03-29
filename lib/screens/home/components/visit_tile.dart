import 'package:flutter/material.dart';
import 'package:meioambientemobile/components/horizontal_spacer_box.dart';
import 'package:meioambientemobile/components/vertical_spacer_box.dart';
import 'package:meioambientemobile/constants/style/constants.dart';
import 'package:meioambientemobile/core/util/custom_date_formater.dart';

class VisitTile extends StatelessWidget {
  final String title;
  final int id;
  // ignore: non_constant_identifier_names
  final String visitDate;
  final String? completedDate;
  final String empresa;
  final VoidCallback onTap;
  final String business;
  final String tipo;

  final String street;
  final String number;
  const VisitTile(
      {Key? key,
      required this.title,
      required this.visitDate,
      this.completedDate,
      required this.empresa,
      required this.onTap,
      required this.business,
      required this.tipo,
      required this.street,
      required this.number,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.23,
        decoration: BoxDecoration(
            color: completedDate == null ? kDetailColor : kCompletedColor,
            borderRadius: BorderRadius.circular(kSmallHeight)),
        padding: const EdgeInsets.all(kMediumtHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.description,
                  color: Colors.white,
                ),
                const HorizontalSpacerBox(size: SpacerSize.tiny),
                Text(tipo.toUpperCase() + ' #$id', style: kText),
                const Spacer(),
              ],
            ),
            const VerticalSpacerBox(size: SpacerSize.small),
            Text(
              street + ' $number',
              style: kSubtitleTextStyle,
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(
                  Icons.event,
                  color: Colors.white,
                  size: 16,
                ),
                const HorizontalSpacerBox(size: SpacerSize.tiny),
                Text(
                  'Data: ' +
                      CustomDateFormater.dateTimeWithHourToString(
                          CustomDateFormater.stringToDateTime(visitDate)),
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            completedDate == null
                ? const SizedBox()
                : Row(
                    children: const [
                      Text(
                        'Visita concluída',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        Icons.check,
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
