import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/data/data_source/remote/display.api.dart';
import 'package:e_commerce/data/repository_impl/display.repository_impl.dart';
import 'package:e_commerce/domain/model/common/result.dart';
import 'package:e_commerce/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce/domain/repository/display.repository.dart';
import 'package:e_commerce/domain/usecase/display/display.usecase.dart';
import 'package:e_commerce/domain/usecase/display/menu/get_menus.usecase.dart';
import 'package:e_commerce/presentation/main/cubit/mall_type_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDisplayRepository extends Mock implements DisplayRepository {}

class MockDisplayApi extends Mock implements DisplayApi {}

class MockGetMenusUsecase extends Mock implements GetMenusUsecase {}

void main() {
  late DisplayRepository displayRepository;
  late DisplayUsecase displayUsecase;

  setUpAll(() {
    displayRepository = DisplayRepositoryImpl(MockDisplayApi());
    displayUsecase = DisplayUsecase(displayRepository);
  });

  test('의존성 주입 성공', () => expect(displayUsecase, isNotNull));

  test('메뉴 리스트 불러오기 성공', () async {
    final res = Result.success([Menu(tabId: -1, title: '메뉴테스트')]);

    final usecase = MockGetMenusUsecase();

    when(() => usecase.mallType).thenReturn(MallType.market);
    when(() => usecase.call(displayRepository)).thenAnswer((_) async => res);

    final actual = await displayUsecase.excute(usecase: usecase);

    expect(actual, res);
  });

  test('메뉴 리스트 불러오기 실패', () async {
    const res = Result<List<Menu>>.failure(ErrorResponse(status: 'error'));

    final usecase = MockGetMenusUsecase();

    when(() => usecase.mallType).thenReturn(MallType.market);
    when(() => usecase.call(displayRepository)).thenAnswer((_) async => res);

    final actual = await displayUsecase.excute(usecase: usecase);

    expect(actual, res);
  });
}
