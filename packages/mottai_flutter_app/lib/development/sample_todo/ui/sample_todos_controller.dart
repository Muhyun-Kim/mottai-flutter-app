import 'package:firebase_common/firebase_common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../scaffold_messenger_controller.dart';
import '../sample_todos.dart';

final sampleTodosControllerProvider =
    Provider.autoDispose<SampleTodosController>(
  (ref) => SampleTodosController(
    sampleTodoService: ref.watch(sampleTodoServiceProvider),
    appScaffoldMessengerController:
        ref.watch(appScaffoldMessengerControllerProvider),
  ),
);

class SampleTodosController {
  const SampleTodosController({
    required SampleTodoService sampleTodoService,
    required AppScaffoldMessengerController appScaffoldMessengerController,
  })  : _sampleTodoService = sampleTodoService,
        _appScaffoldMessengerController = appScaffoldMessengerController;

  final SampleTodoService _sampleTodoService;

  final AppScaffoldMessengerController _appScaffoldMessengerController;

  /// [SampleTodo] を追加する。
  Future<void> addTodo({
    required String title,
    required String description,
    required DateTime? dueDateTime,
  }) async {
    if (title.isEmpty || description.isEmpty || dueDateTime == null) {
      _appScaffoldMessengerController.showSnackBar('入力内容を確認してください。');
      return;
    }
    await _sampleTodoService.add(
      title: title,
      description: description,
      dueDateTime: dueDateTime,
    );
    _appScaffoldMessengerController.showSnackBar('Todo を追加しました。');
  }

  /// 指定した [SampleTodo] の `isDone` をトグルする。
  Future<void> toggleCompletionStatus({
    required ReadSampleTodo readSampleTodo,
  }) =>
      _sampleTodoService.updateCompletionStatus(
        sampleTodoId: readSampleTodo.sampleTodoId,
        value: !readSampleTodo.isDone,
      );
}
