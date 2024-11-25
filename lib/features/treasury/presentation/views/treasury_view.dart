import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/customs/app_logo.dart';
import 'package:pmf_admin/core/utils/customs/header.dart';
import 'package:pmf_admin/core/utils/customs/manage_buttons.dart';
import 'package:pmf_admin/core/utils/styles.dart';

class TreasuryView extends StatelessWidget {
  const TreasuryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TreasuryList(),
    );
  }
}

class TreasuryList extends StatelessWidget {
  const TreasuryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(
          buttonTitle: "Add Trophie",
          onPressedButton: () {},
          onPressedRefresh: () {},
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return const Column(
                children: [
                  TrophieItem(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class TrophieItem extends StatelessWidget {
  const TrophieItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: const AppLogo(
                  height: 180,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "Afyf Badreddine",
                            style: Styles.normal20.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "World Cup",
                            style: Styles.normal16,
                          ),
                        ],
                      ),
                    ),
                    EditButton(
                      onPressed: () {},
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
