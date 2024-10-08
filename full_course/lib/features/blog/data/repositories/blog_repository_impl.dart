import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:full_course/core/error/exception.dart';
import 'package:full_course/core/error/failure.dart';
import 'package:full_course/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:full_course/features/blog/data/models/blog_model.dart';
import 'package:full_course/features/blog/domain/entities/blog.dart';
import 'package:full_course/features/blog/domain/repositories/blog_repository.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.meesage));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();

      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.meesage));
    }
  }
}
