import 'package:flutter/material.dart';

class ErrorOrEmptyWidget extends StatelessWidget {
  final String message;
  final String? content;
  final VoidCallback? callBack;
  const ErrorOrEmptyWidget({
    Key? key,
    this.message = "Không có dữ liệu",
    this.content,
    this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: callBack,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 50,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            if (content != null)
              Text(
                content!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
