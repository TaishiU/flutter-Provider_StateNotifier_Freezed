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
}
