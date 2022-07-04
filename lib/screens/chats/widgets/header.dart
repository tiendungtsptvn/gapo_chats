import 'package:flutter/material.dart';

class HeaderChats extends StatelessWidget {
  const HeaderChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            "https://image-1.gapo.vn/icon/zoom-avatar.png",
            errorBuilder: (context, error, stackTrace) {
              return const Image(
                image: AssetImage("assets/images/default_image.png"),
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
        const SizedBox(
          width: 12,
        ),
        const Expanded(
          child: Text(
            "Nguyen Thi Phuong Trang",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            maxLines: 1,
          ),
        ),
        // const Spacer(),
        const Icon(
          Icons.list,
        ),
        const SizedBox(
          width: 10,
        ),
        const Icon(
          Icons.file_copy_outlined,
        ),
        const SizedBox(
          width: 10,
        ),
        const Icon(
          Icons.edit_road,
        ),
      ],
    );
  }
}
