import 'package:fpdart/fpdart.dart';
import 'package:full_course/core/error/failure.dart';
import 'package:full_course/core/usecase/usecase.dart';
import 'package:full_course/features/blog/domain/entities/blog.dart';
import 'package:full_course/features/blog/domain/repositories/blog_repository.dart';

class GetAllBlogs implements UseCase<List<BlogEntity>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
