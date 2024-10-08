import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:full_course/core/theme/app_colors.dart';
import 'package:full_course/core/utils/pick_image.dart';
import 'package:full_course/features/blog/presentation/widgets/blog_editor.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              image == null
                  ? GestureDetector(
                      onTap: selectImage,
                      child: DottedBorder(
                        color: AppColors.borderColor,
                        dashPattern: const [10, 4],
                        radius: const Radius.circular(10),
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        child: const SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Select your image',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: selectImage,
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Technology',
                    'Business',
                    'Programming',
                    'Entertainment',
                  ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              if (selectedTopics.contains(e)) {
                                selectedTopics.remove(e);
                              } else {
                                selectedTopics.add(e);
                              }
                              setState(() {});
                            },
                            child: Chip(
                              label: Text(e),
                              color: selectedTopics.contains(e)
                                  ? const WidgetStatePropertyAll(
                                      AppColors.gradient1)
                                  : null,
                              side: BorderSide(
                                color: selectedTopics.contains(e)
                                    ? AppColors.gradient1
                                    : AppColors.borderColor,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlogEditor(
                controller: titleController,
                hintText: 'Blog Title',
              ),
              const SizedBox(
                height: 10,
              ),
              BlogEditor(
                controller: contentController,
                hintText: 'Blog Content',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
