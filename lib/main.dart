import 'dart:core';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blind 31',
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstPage(),
    );
  }
}

//_HomePageState createState() => _HomePageState();
class FirstPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// Bottom Navigator
class _HomePageState extends State<FirstPage> {
  var _index = 0; // 페이지 인덱스 0, 1, 2

  var _pages = [
    Page1(),
    Page2(),
    // Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blind 31'),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: 100),
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text('Home'),
              onTap: () {
                print('Home is clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey,
              ),
              title: Text('Settings'),
              onTap: () {
                print('Settings is clicked');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.question_answer,
                color: Colors.grey,
              ),
              title: Text('Q&A'),
              onTap: () {
                print('Q&A is clicked');
              },
            ),
          ],
        ),
      ),

      // 바텀 네비게이션 바 주석
      body: _pages[_index],
      //     bottomNavigationBar: BottomNavigationBar(
      //       onTap: (index) {
      //         setState(() {
      //           _index = index; // 선택된 탭의 인덱스로 _index를 변경
      //         });
      //       },
      //       currentIndex: _index, // 선택된 인덱스
      //       items: <BottomNavigationBarItem>[
      //         BottomNavigationBarItem(
      //           title: Text('테마 1'),
      //           icon: Icon(Icons.home),
      //         ),
      //         BottomNavigationBarItem(
      //           title: Text('테마 2'),
      //           icon: Icon(Icons.tag),
      //         ),
      //     BottomNavigationBarItem(
      //       title: Text('테마 3'),
      //       icon: Icon(Icons.account_circle),
      //     ),
      //   ],
      // ),
    );
  }
}

class Page1 extends StatefulWidget {
  @override
  Page1_State createState() => Page1_State();
}

// ignore: camel_case_types
class Page1_State extends State<Page1> {
  int Total_touchCount = 0; // 목적 터치 숫자 (31) 카운트
  int Turn_touch = 0; // 한 턴당 터치횟수
  var isChecked = false;

  void _incrementCounter() {
    setState(() {
      if (Turn_touch >= 3) {
        // 한 턴의 터치 횟수가 3이상인 경우 Total_touch 증가 X
      } else {
        Total_touchCount++; // 터치 숫자
        Turn_touch++;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (Turn_touch <= 1) {
        // 한 턴의 터치 횟수가 1이상이어야 함.

      } else {
        Total_touchCount--; // 터치 숫자
        Turn_touch--;
      }
    });
  }

  void init_TotalCount() {
    setState(() {
      Total_touchCount = 0;
    });
  }

  void init_TurnCount() {
    setState(() {
      Turn_touch = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        // 2인 3인 토글 스위치
        // ToggleSwitch(
        //   minWidth: 70.0,
        //   cornerRadius: 20.0,
        //   activeBgColor: Colors.cyan,
        //   activeFgColor: Colors.white,
        //   inactiveBgColor: Colors.grey,
        //   inactiveFgColor: Colors.white,
        //   labels: ['2인', '3인이상'],
        //   icons: [Icons.person, Icons.accessible],
        //   onToggle: (index) {
        //     print('switched to: $index');
        //   },
        // ),

        // 이미지 버튼
        ClipOval(
          child: Container(
            width: 250.0,
            height: 250.0,
            margin: EdgeInsets.all(50.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.black),
              image: DecorationImage(
                  image: AssetImage('assets/halloween_button.png')),
              borderRadius: BorderRadius.circular(150),
              // <List> boxShadow
              boxShadow: [
                BoxShadow(color: Colors.grey, offset: Offset(5, 5)),
                BoxShadow(color: Colors.black, offset: Offset(0, 0))
              ],
            ),
            child: FlatButton(
                padding: EdgeInsets.all(1.0),
                onPressed: () {
                  _incrementCounter();

                  print(Total_touchCount);
                  print(Turn_touch);

                  // 정해진 숫자가 되면 당첨 알림창 띄움
                  if (Total_touchCount == 3) {
                    showGeneralDialog(
                        context: context,
                        pageBuilder: (context, anim1, anim2) {},
                        barrierDismissible: true,
                        barrierColor: Colors.black.withOpacity(0.4),
                        barrierLabel: '',
                        transitionBuilder: (context, anim1, anim2, child) {
                          return Transform.rotate(
                            angle: math.radians(anim1.value * 360),
                            child: Opacity(
                              opacity: anim1.value,
                              child: AlertDialog(
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                title: Text('당첨!!',),
                                content: Container(
                                  width: 300.0,
                                  height: 300.0,

                                  decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.black),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/halloween_gif.gif')),
                                    borderRadius: BorderRadius.circular(150),
                                    // <List> boxShadow

                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 300));
                    // showDialog(
                    //     context: context,
                    //     barrierDismissible: false,
                    //     builder: (BuildContext context) {
                    //       return AlertDialog(
                    //         content: SingleChildScrollView(
                    //           child: ListBody(
                    //             children: <Widget>[
                    //               Text('Alert Dialog'),
                    //               Text('당첨~~~'),
                    //             ],
                    //           ),
                    //         ),
                    //         actions: <Widget>[
                    //           FlatButton(
                    //             child: Text('OK'),
                    //             onPressed: () {
                    //               Navigator.of(context).pop();
                    //             },
                    //           ),
                    //         ],
                    //       );
                    //       transitionDuration:
                    //       Duration(milliseconds: 300);
                    //     });
                    init_TotalCount();
                    init_TurnCount();
                  }
                },
                child: null),
          ),
        ),

        Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              child: Text(
                '현재 터치횟수는 : $Turn_touch',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),

        // 감소 버튼
        Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  FloatingActionButton(
                    child: Icon(
                      Icons.do_disturb_on_rounded,
                      size: 40.0,
                    ),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _decrementCounter(); // 카운트 증가
                      print(Total_touchCount);
                      print(Turn_touch);
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    child: RaisedButton(
                      child: Text(
                        '턴 종료',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      ),
                      color: Colors.black,
                      onPressed: () {
                        // 터치를 하지않고 턴을 종료 할 경우
                        if (Turn_touch == 0) {
                          showGeneralDialog(
                              barrierColor: Colors.black.withOpacity(0.5),
                              transitionBuilder: (context, a1, a2, widget) {
                                return Transform.scale(
                                  scale: a1.value,
                                  child: Opacity(
                                    opacity: a1.value,
                                    child: AlertDialog(
                                      shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      title: Text('No touch'),
                                      content: Text('1번이상 터치 해야함!!'),
                                    ),
                                  ),
                                );
                              },
                              transitionDuration: Duration(milliseconds: 200),
                              barrierDismissible: true,
                              barrierLabel: '',
                              context: context,
                              pageBuilder:
                                  (context, animation1, animation2) {});

                          // showDialog(
                          //     context: context,
                          //     barrierDismissible: false,
                          //     builder: (BuildContext context) {
                          //       return AlertDialog(
                          //         title: Text('No touch'),
                          //         content: SingleChildScrollView(
                          //           child: ListBody(
                          //             children: <Widget>[
                          //               Text('Alert Dialog'),
                          //               Text('1번이상 터치 해야함'),
                          //             ],
                          //           ),
                          //         ),
                          //         actions: <Widget>[
                          //           FlatButton(
                          //             child: Text('OK'),
                          //             onPressed: () {
                          //               Navigator.of(context).pop();
                          //             },
                          //           ),
                          //         ],
                          //       );
                          //     });
                        } else {
                          showGeneralDialog(
                              barrierColor: Colors.black.withOpacity(0.5),
                              transitionBuilder: (context, a1, a2, widget) {
                                return Transform.scale(
                                  scale: a1.value,
                                  child: Opacity(
                                    opacity: a1.value,
                                    child: AlertDialog(
                                      shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      title: Text('턴 종료'),
                                      content: Text('턴이 종료됩니다'),
                                    ),
                                  ),
                                );
                              },
                              transitionDuration: Duration(milliseconds: 200),
                              barrierDismissible: true,
                              barrierLabel: '',
                              context: context,
                              pageBuilder:
                                  (context, animation1, animation2) {});

                          // showDialog(
                          //     context: context,
                          //     barrierDismissible: false,
                          //     builder: (BuildContext context) {
                          //       return AlertDialog(
                          //         title: Text('턴이 종료 됩니다.'),
                          //         content: SingleChildScrollView(
                          //           child: ListBody(
                          //             children: <Widget>[],
                          //           ),
                          //         ),
                          //         actions: <Widget>[
                          //           FlatButton(
                          //             child: Text('OK'),
                          //             onPressed: () {
                          //               init_TurnCount();
                          //               Navigator.of(context).pop();
                          //             },
                          //           ),
                          //         ],
                          //       );
                          //     });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class Page2 extends StatefulWidget {
  @override
  Page2_State createState() => Page2_State();
// int Total_touchCount = 0;   // 목적 터치 숫자 (31) 카운트
// int Turn_touch = 0;       // 한 턴당 터치횟수
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//
//     body: Center(
//       child: Column(
//         children: <Widget>[
//           FloatingActionButton(
//             child: Icon(Icons.add),
//             onPressed: (){
//
//               if(Turn_touch>=3){  // 한 턴의 터치 횟수가 3이상인 경우 Total_touch 증가 X
//
//               }
//               else{
//                 Total_touchCount++;     // 터치 숫자
//                 Turn_touch++;
//               }
//
//
//
//               print(Total_touchCount);
//               print(Turn_touch);
//
//               // 정해진 숫자가 되면 당첨 알림창 띄움
//               if(Total_touchCount == 20){
//                 showDialog(
//                     context: context,
//                     barrierDismissible: false,
//                     builder: (BuildContext context){
//                       return AlertDialog(
//                         title: Text('제목'),
//                         content: SingleChildScrollView(
//                           child: ListBody(
//                             children: <Widget>[
//                               Text('Alert Dialog'),
//                               Text('당첨~~~'),
//                             ],
//                           ),
//                         ),
//                         actions: <Widget>[
//                           FlatButton(
//                             child: Text('OK'),
//
//                             onPressed: (){
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                           FlatButton(
//                             child: Text('No'),
//                             onPressed: (){
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ],
//                       );
//                     }
//                 );
//                 Total_touchCount=0;
//               }
//             },
//           ),
//           RaisedButton(
//               child: Text('턴 종료'),
//               color: Colors.red,
//               onPressed: (){
//                 if(Turn_touch == 0){
//                   showDialog(
//                       context: context,
//                       barrierDismissible: false,
//                       builder: (BuildContext context){
//                         return AlertDialog(
//                           title: Text('No touch'),
//                           content: SingleChildScrollView(
//                             child: ListBody(
//                               children: <Widget>[
//                                 Text('Alert Dialog'),
//                                 Text('1번이상 터치 해야함'),
//                               ],
//                             ),
//                           ),
//                           actions: <Widget>[
//                             FlatButton(
//                               child: Text('OK'),
//
//                               onPressed: (){
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                           ],
//                         );
//                       }
//                   );
//                 }
//                 else {
//                   showDialog(
//                       context: context,
//                       barrierDismissible: false,
//                       builder: (BuildContext context){
//                         return AlertDialog(
//                           title: Text('턴이 종료 됩니다.'),
//                           content: SingleChildScrollView(
//                             child: ListBody(
//                               children: <Widget>[
//                                 // Text(''),
//                                 // Text('터치횟수는 : $Turn_touch'),
//                               ],
//                             ),
//                           ),
//                           actions: <Widget>[
//                             FlatButton(
//                               child: Text('OK'),
//
//                               onPressed: (){
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                           ],
//                         );
//                       }
//                   );
//                   Text('현재 터치횟수는 : $Turn_touch');
//                 }
//                 Turn_touch=0;   // Turn 터치횟수 초기화
//               },
//           ),
//         ]
//       ),
//     ),
//   );
// }
}

class Page2_State extends State<Page2> {
  int Total_touchCount = 0; // 목적 터치 숫자 (31) 카운트
  int Turn_touch = 0; // 한 턴당 터치횟수
  var isChecked = false;

  void _incrementCounter() {
    setState(() {
      if (Turn_touch >= 3) {
        // 한 턴의 터치 횟수가 3이상인 경우 Total_touch 증가 X
      } else {
        Total_touchCount++; // 터치 숫자
        Turn_touch++;
      }
    });
  }

  void init_TotalCount() {
    setState(() {
      Total_touchCount = 0;
    });
  }

  void init_TurnCount() {
    setState(() {
      Turn_touch = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _incrementCounter(); // 카운트 증가

              print(Total_touchCount);
              print(Turn_touch);

              // 정해진 숫자가 되면 당첨 알림창 띄움
              if (Total_touchCount == 20) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('제목'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Alert Dialog'),
                              Text('당첨~~~'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
                init_TotalCount();
              }
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.do_disturb_on_rounded),
            onPressed: () {
              _incrementCounter(); // 카운트 증가

              print(Total_touchCount);
              print(Turn_touch);

              // 정해진 숫자가 되면 당첨 알림창 띄움
              if (Total_touchCount == 20) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('제목'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Alert Dialog'),
                              Text('당첨~~~'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
                init_TotalCount();
              }
            },
          ),
          RaisedButton(
            child: Text('턴 종료'),
            color: Colors.black,
            onPressed: () {
              if (Turn_touch == 0) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('No touch'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Alert Dialog'),
                              Text('1번이상 터치 해야함'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              } else {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('턴이 종료 됩니다.'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () {
                              init_TurnCount();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              }
            },
          ),
          // Text('현재 터치횟수는 : $Turn_touch'),
          Text(
            '현재 터치횟수는 :',
          ),
          Text(
            '$Turn_touch',
          ),

          Switch(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value;
                });
              })
        ]),
      ),
    );
  }
}

// 테마 3개발 보류

// class Page3 extends StatefulWidget {
//   @override
//   Page3_State createState() => Page3_State();
// // int Total_touchCount = 0;   // 목적 터치 숫자 (31) 카운트
// // int Turn_touch = 0;       // 한 턴당 터치횟수
// //
// // @override
// // Widget build(BuildContext context) {
// //   return Scaffold(
// //
// //     body: Center(
// //       child: Column(
// //         children: <Widget>[
// //           FloatingActionButton(
// //             child: Icon(Icons.add),
// //             onPressed: (){
// //
// //               if(Turn_touch>=3){  // 한 턴의 터치 횟수가 3이상인 경우 Total_touch 증가 X
// //
// //               }
// //               else{
// //                 Total_touchCount++;     // 터치 숫자
// //                 Turn_touch++;
// //               }
// //
// //
// //
// //               print(Total_touchCount);
// //               print(Turn_touch);
// //
// //               // 정해진 숫자가 되면 당첨 알림창 띄움
// //               if(Total_touchCount == 20){
// //                 showDialog(
// //                     context: context,
// //                     barrierDismissible: false,
// //                     builder: (BuildContext context){
// //                       return AlertDialog(
// //                         title: Text('제목'),
// //                         content: SingleChildScrollView(
// //                           child: ListBody(
// //                             children: <Widget>[
// //                               Text('Alert Dialog'),
// //                               Text('당첨~~~'),
// //                             ],
// //                           ),
// //                         ),
// //                         actions: <Widget>[
// //                           FlatButton(
// //                             child: Text('OK'),
// //
// //                             onPressed: (){
// //                               Navigator.of(context).pop();
// //                             },
// //                           ),
// //                           FlatButton(
// //                             child: Text('No'),
// //                             onPressed: (){
// //                               Navigator.of(context).pop();
// //                             },
// //                           ),
// //                         ],
// //                       );
// //                     }
// //                 );
// //                 Total_touchCount=0;
// //               }
// //             },
// //           ),
// //           RaisedButton(
// //               child: Text('턴 종료'),
// //               color: Colors.red,
// //               onPressed: (){
// //                 if(Turn_touch == 0){
// //                   showDialog(
// //                       context: context,
// //                       barrierDismissible: false,
// //                       builder: (BuildContext context){
// //                         return AlertDialog(
// //                           title: Text('No touch'),
// //                           content: SingleChildScrollView(
// //                             child: ListBody(
// //                               children: <Widget>[
// //                                 Text('Alert Dialog'),
// //                                 Text('1번이상 터치 해야함'),
// //                               ],
// //                             ),
// //                           ),
// //                           actions: <Widget>[
// //                             FlatButton(
// //                               child: Text('OK'),
// //
// //                               onPressed: (){
// //                                 Navigator.of(context).pop();
// //                               },
// //                             ),
// //                           ],
// //                         );
// //                       }
// //                   );
// //                 }
// //                 else {
// //                   showDialog(
// //                       context: context,
// //                       barrierDismissible: false,
// //                       builder: (BuildContext context){
// //                         return AlertDialog(
// //                           title: Text('턴이 종료 됩니다.'),
// //                           content: SingleChildScrollView(
// //                             child: ListBody(
// //                               children: <Widget>[
// //                                 // Text(''),
// //                                 // Text('터치횟수는 : $Turn_touch'),
// //                               ],
// //                             ),
// //                           ),
// //                           actions: <Widget>[
// //                             FlatButton(
// //                               child: Text('OK'),
// //
// //                               onPressed: (){
// //                                 Navigator.of(context).pop();
// //                               },
// //                             ),
// //                           ],
// //                         );
// //                       }
// //                   );
// //                   Text('현재 터치횟수는 : $Turn_touch');
// //                 }
// //                 Turn_touch=0;   // Turn 터치횟수 초기화
// //               },
// //           ),
// //         ]
// //       ),
// //     ),
// //   );
// // }
// }
//
// class Page3_State extends State<Page3> {
//   int Total_touchCount = 0; // 목적 터치 숫자 (31) 카운트
//   int Turn_touch = 0; // 한 턴당 터치횟수
//   var isChecked = false;
//
//   void _incrementCounter() {
//     setState(() {
//       if (Turn_touch >= 3) {
//         // 한 턴의 터치 횟수가 3이상인 경우 Total_touch 증가 X
//       } else {
//         Total_touchCount++; // 터치 숫자
//         Turn_touch++;
//       }
//     });
//   }
//
//   void init_TotalCount() {
//     setState(() {
//       Total_touchCount = 0;
//     });
//   }
//   void init_TurnCount() {
//     setState(() {
//       Turn_touch = 0;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(children: <Widget>[
//           FloatingActionButton(
//             child: Icon(Icons.add),
//             onPressed: () {
//               _incrementCounter();
//               // 함수로 변환
//               // if (Turn_touch >= 3) {
//               //   // 한 턴의 터치 횟수가 3이상인 경우 Total_touch 증가 X
//               //
//               // } else {
//               //   Total_touchCount++; // 터치 숫자
//               //   Turn_touch++;
//               // }
//
//               print(Total_touchCount);
//               print(Turn_touch);
//
//               // 정해진 숫자가 되면 당첨 알림창 띄움
//               if (Total_touchCount == 20) {
//                 showDialog(
//                     context: context,
//                     barrierDismissible: false,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text('제목'),
//                         content: SingleChildScrollView(
//                           child: ListBody(
//                             children: <Widget>[
//                               Text('Alert Dialog'),
//                               Text('당첨~~~'),
//                             ],
//                           ),
//                         ),
//                         actions: <Widget>[
//                           FlatButton(
//                             child: Text('OK'),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                           FlatButton(
//                             child: Text('No'),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ],
//                       );
//                     });
//                 init_TotalCount();
//               }
//             },
//           ),
//           RaisedButton(
//             child: Text('턴 종료'),
//             color: Colors.red,
//             onPressed: () {
//               if (Turn_touch == 0) {
//                 showDialog(
//                     context: context,
//                     barrierDismissible: false,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text('No touch'),
//                         content: SingleChildScrollView(
//                           child: ListBody(
//                             children: <Widget>[
//                               Text('Alert Dialog'),
//                               Text('1번이상 터치 해야함'),
//                             ],
//                           ),
//                         ),
//                         actions: <Widget>[
//                           FlatButton(
//                             child: Text('OK'),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ],
//                       );
//                     });
//               } else {
//                 showDialog(
//                     context: context,
//                     barrierDismissible: false,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text('턴이 종료 됩니다.'),
//                         content: SingleChildScrollView(
//                           child: ListBody(
//                             children: <Widget>[
//                             ],
//                           ),
//                         ),
//                         actions: <Widget>[
//                           FlatButton(
//                             child: Text('OK'),
//                             onPressed: () {
//                               init_TurnCount();
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ],
//                       );
//                     });
//               }
//
//             },
//           ),
//           // Text('현재 터치횟수는 : $Turn_touch'),
//           Text(
//             '현재 터치횟수는 :',
//           ),
//           Text(
//             '$Turn_touch',
//           ),
//
//           Switch(
//               value: isChecked,
//               onChanged: (value) {
//                 setState(() {
//                   isChecked = value;
//                 });
//               })
//         ]),
//       ),
//     );
//   }
// }
