import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider_statenotifier_freezed/my_page/my_page_notifier.dart';

class MyPage extends StatelessWidget {
  //const MyPage({Key? key}) : super(key: key);

  const MyPage._({Key? key}) : super(key: key);

  static Widget wrapped() {
    return MultiProvider(
      providers: [
        StateNotifierProvider<MyPageNotifier, MyPageState>(
          create: (context) => MyPageNotifier(
            context: context,
          ),
        )
      ],
      child: const MyPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<MyPageNotifier>();

    print('描画');

    return Scaffold(
      appBar: AppBar(
        title: Text('日々の体重を追加していくアプリ'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 100,
              margin: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 26,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(10, 10),
                  ),
                ],
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  /* 再描画する範囲を特定するためにBuilder()メソッドを利用 */
                  /* Builder()メソッドを利用しないと、画面全体がビルドされてしまう */
                  Builder(
                    builder: (BuildContext context) {
                      final count =
                          context.select((MyPageState state) => state.count);
                      return Container(
                        padding: EdgeInsets.only(left: 20),
                        width: 80,
                        child: Text(
                          count.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 24,
                                child: Icon(Icons.calendar_today),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '2020/10/16',
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                              child: Icon(Icons.comment),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'これは、、、やっちまった、、、',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '今日の体重を追加しよう',
            ),
            // IconButton(
            //   icon: Icon(
            //     Icons.add,
            //     color: Colors.blue,
            //   ),
            //   onPressed: () {
            //     notifier.pushButton();
            //   },
            // )
            TextButton(
              child: Text('体重が１増える'),
              onPressed: () {
                notifier.pushButton();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Text('今日の体重を入力しよう'),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14, vertical: 24),
                children: [
                  Row(
                    children: [
                      Container(
                        width: 200,
                        padding: EdgeInsets.only(left: 4),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '嘘つくなよ',
                            labelText: '今日の体重',
                          ),
                          onChanged: (value) {
                            notifier.saveWeight(value);
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Kg'),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    padding: EdgeInsets.only(left: 4),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '後悔先に立たず',
                        labelText: '懺悔の一言',
                      ),
                      onChanged: (value) {
                        notifier.saveComment(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        '登録',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // void _saveWeight(String value) {
  //   print(value);
  // }

  // void _saveComment(String value) {
  //   print(value);
  // }

}
