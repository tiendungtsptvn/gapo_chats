import 'package:base_flutter/configs/path.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderChats extends StatelessWidget {
  const HeaderChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 32,
          width: 32,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  "https://image-1.gapo.vn/icon/zoom-avatar.png",
                  errorBuilder: (context, error, stackTrace) {
                    return const Image(
                      image: AssetImage(AppPaths.defaultImage),
                      height: 32,
                      width: 32,
                      fit: BoxFit.fill,
                    );
                  },
                  height: 32,
                  width: 32,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: GPColor.workPrimary,
                    border: Border.all(width: 1, color: GPColor.bgPrimary),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Text(
            "Nguyen Thi Phuong Trang",
            overflow: TextOverflow.ellipsis,
            style: textStyle(GPTypography.body16),
            // TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            maxLines: 1,
          ),
        ),
        SizedBox(
          width: 30,
          height: 30,
          child: Stack(
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/images/icon-menu.svg",
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: GPColor.functionNegativePrimary),
                  child: Center(
                    child: Text(
                      "9",
                      style: textStyle(GPTypography.bodySmallBold)?.merge(
                        const TextStyle(
                            color: GPColor.functionAlwaysLightPrimary),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 22,
        ),
        SvgPicture.asset(
          AppPaths.iconFolder,
        ),
        const SizedBox(
          width: 22,
        ),
        SvgPicture.asset(
          AppPaths.iconGreenEdit,
        ),
      ],
    );
  }
}
