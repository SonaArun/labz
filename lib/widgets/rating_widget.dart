import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;

  const StarRating({Key? key,
    required this.rating
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        5,
        (index) {
          if (index < rating) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
              size: 16,
            );
          } else {
            return Icon(
              Icons.star_border,
              color: Colors.amber.withOpacity(0.5),
              size: 16,
            );
          }
        },
      ),
    );
  }
}
