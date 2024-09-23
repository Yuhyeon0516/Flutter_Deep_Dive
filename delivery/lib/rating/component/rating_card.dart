import 'package:delivery/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RatingCard extends StatelessWidget {
  // NetworkImage, AssetImage
  final ImageProvider avatarImage;
  // 리뷰 이미지
  final List<Image> images;
  // 별점
  final int rating;
  final String email;
  final String content;

  const RatingCard({
    super.key,
    required this.avatarImage,
    required this.images,
    required this.rating,
    required this.email,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          avatarImage: avatarImage,
          rating: rating,
          email: email,
        ),
        const SizedBox(
          height: 8,
        ),
        _Body(
          content: content,
        ),
        const _Images(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final int rating;
  final String email;

  const _Header({
    super.key,
    required this.avatarImage,
    required this.rating,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundImage: avatarImage,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ...List.generate(
          5,
          (index) => Icon(
            index < rating ? Icons.star : Icons.star_border_outlined,
            color: PRIMARY_COLOR,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;

  const _Body({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            content,
            style: const TextStyle(
              color: BODY_TEXT_COLOR,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  const _Images({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
