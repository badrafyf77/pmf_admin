import 'package:flutter/material.dart';

import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/styles.dart';

class DashboardItem extends StatefulWidget {
  const DashboardItem({
    super.key,
    required this.title,
    required this.nmbr,
    required this.onTap,
  });

  final String title;
  final int nmbr;
  final void Function() onTap;

  @override
  State<DashboardItem> createState() => _DashboardItemState();
}

class _DashboardItemState extends State<DashboardItem> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (value) {
        setState(() {
          isHovering = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        height: 100,
        width: 270,
        decoration: BoxDecoration(
          color: isHovering ? AppColors.kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(10.0),
        duration: const Duration(milliseconds: 300),
        transform: Transform.translate(
          offset: Offset(0, isHovering ? -8 : 0),
        ).transform,
        child: Padding(
          padding: const EdgeInsets.only(left: 3),
          child: InkWell(
            onTap: widget.onTap,
            child: Row(
              children: [
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    color: isHovering ? Colors.white : AppColors.kSecondColor,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: const Icon(
                    Icons.event,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nmbr.toString(),
                      style: Styles.normal20.copyWith(
                        color: isHovering ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      widget.title,
                      style: Styles.normal12.copyWith(
                        color:
                            isHovering ? AppColors.kSecondColor : Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
