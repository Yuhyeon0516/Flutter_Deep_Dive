import 'package:flutter/material.dart';
import 'package:full_course/core/utils/calculate_reading_time.dart';
import 'package:full_course/features/blog/domain/entities/blog.dart';
import 'package:full_course/features/blog/presentation/pages/blog_viewer_page.dart';

class BlogCard extends StatelessWidget {
  final BlogEntity blog;
  final Color color;

  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewerPage.route(blog));
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: blog.topics
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Chip(
                          label: Text(e),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: Text(
                blog.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            Text('${calculateReadingTime(blog.content)} min'),
          ],
        ),
      ),
    );
  }
}
