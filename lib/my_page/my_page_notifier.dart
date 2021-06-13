import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier/state_notifier.dart';

part 'my_page_notifier.freezed.dart';

@freezed
abstract class MyPageState with _$MyPageState {
  const factory MyPageState({
    @Default(0) int count,
    String? weight,
    String? comment,
    @Default([]) List<Map<String, String?>> record,
  }) = _MyPageState;
}

class MyPageNotifier extends StateNotifier<MyPageState> with LocatorMixin {
  MyPageNotifier({
    required this.context,
  }) : super(const MyPageState());

  final BuildContext context;

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  void initState() {}

  void pushButton() {
    print('ボタンが押されたよ！');
    state = state.copyWith(count: state.count + 1);
    print(state.count);
  }

  void saveWeight(String value) {
    state = state.copyWith(weight: value);
    print('体重を記録したよ！');
    print(state.weight);
  }

  void saveComment(String value) {
    state = state.copyWith(comment: value);
    print('コメントしたよ！');
    print(state.comment);
  }

  void register() {
    final dateTime = DateTime.now();
    final day = '${dateTime.year}年${dateTime.month}月${dateTime.day}日';
    /* final：再代入不可、代入される値で型を判断するため型指定の省略が可能 */
    final formRecord = {
      'weight': state.weight,
      'comment': state.comment,
      'day': day,
    };

    print(formRecord);
    /* state.record.add()ではエラーが発生するため、新規のコピー「newRecord」を作り、データをaddする */
    final newRecord = List<Map<String, String?>>.from(state.record);
    newRecord.add(formRecord);
    state = state.copyWith(record: newRecord);
    Navigator.of(context).pop();
  }
}
