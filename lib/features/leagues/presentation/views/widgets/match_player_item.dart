import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/customs/app_logo.dart';
import 'package:pmf_admin/core/utils/customs/text_field.dart';
import 'package:pmf_admin/core/utils/helpers/validators.dart';
import 'package:pmf_admin/core/utils/models/fixture_model.dart';
import 'package:pmf_admin/core/utils/styles.dart';

class PlayerItem extends StatelessWidget {
  const PlayerItem({
    super.key,
    required this.homeController,
    required this.awayController,
    required this.fixture,
  });

  final Fixture fixture;
  final TextEditingController homeController;
  final TextEditingController awayController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            const AppLogo(height: 160),
            Row(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * .3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(),
                  ),
                  child: Center(
                    child: Text(
                      fixture.homeName,
                      style: Styles.normal16,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                MyTextField(
                  isMatchResult: true,
                  controller: homeController,
                  validator: (value) {
                    if (value == null || value.isEmpty || !isNumeric(value)) {
                      return "";
                    }
                    return null;
                  },
                  width: 50,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 50,
          child: Center(
            child: Text(
              "VS",
              style: Styles.normal20,
            ),
          ),
        ),
        Column(
          children: [
            const AppLogo(height: 160),
            Row(
              children: [
                MyTextField(
                  isMatchResult: true,
                  controller: awayController,
                  validator: (value) {
                    if (value == null || value.isEmpty || !isNumeric(value)) {
                      return "";
                    }
                    return null;
                  },
                  width: 50,
                ),
                const SizedBox(width: 4),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * .3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(),
                  ),
                  child: Center(
                    child: Text(
                      fixture.awayName,
                      style: Styles.normal16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}