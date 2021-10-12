import 'package:flutter/material.dart';
import 'package:flutter_login_r04/user.dart';
import './dbhelper.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  DbHelper dbHelper = new DbHelper();
  User user;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          constraints: BoxConstraints.expand(),
          // is used to create container full screen with filled content.
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
          ),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'Register',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    hintText: 'username',
                                    labelText: 'Username',
                                    icon: Icon(Icons.person),
                                  ),
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    hintText: 'password',
                                    labelText: 'Password',
                                    icon: Icon(Icons.lock),
                                  ),
                                  obscureText: true,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: 'email',
                                    labelText: 'Email',
                                    icon: Icon(Icons.email),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: FloatingActionButton(
                            onPressed: () {
                              //membuat objek user
                              user = new User(
                                  usernameController.text,
                                  passwordController.text,
                                  emailController.text);
                              //insert user ke tabel users pada sqlite
                              dbHelper.insertUser(user).then((count) {
                                if (count > 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Registrasi user sukses"),
                                          backgroundColor: Colors.green));
                                  Navigator.pushNamed(context, '/login');
                                }
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Registrasi user gagal, username / email sudah terdaftar"),
                                    backgroundColor: Colors.red));
                              });

                              //menampilkan data user yang diinsert
                              Future<List<Map<String, dynamic>>> listMap =
                                  dbHelper.selectUser(usernameController.text,
                                      passwordController.text);
                              listMap.then((myListMap) => {
                                    myListMap.forEach((element) {
                                      User userFeedback =
                                          new User.fromMap(element);
                                      print(element);
                                    })
                                  });
                            },
                            child: Icon(Icons.send),
                          ))
                        ])),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Back to Login')),
                ElevatedButton(
                    onPressed: () {
                      //select all user dari tabel users
                      dbHelper.selectAllUser().then((mapList) {
                        //baca satu per satu record pada mapList
                        mapList.forEach((element) {
                          print(element);
                        });
                      });
                    },
                    child: Text('Tampilkan data user'))
              ],
            ),
          ))),
    );
  }
}
