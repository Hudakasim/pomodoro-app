import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
          child: Text("Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w200, color: Colors.white),)
          ),
        backgroundColor: Color(0xFFC31F48),
      ),
      body:
      Padding( //0xFFC31F48
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/1.png',
              height: 100,           // Görselin yüksekliğini ayarlıyoruz
            ),
            Text("Welcom to MindTick!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            SizedBox(height: 50,),
            TextField(
                // controller: myController,
                decoration: InputDecoration(
                labelText: "User Name",
                labelStyle: TextStyle(color: Colors.pink),
                fillColor: Colors.white,
                focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: "Enter Your User Name",
                hintStyle: TextStyle(fontSize: 13)
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.pink),
                fillColor: Colors.white,
                focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: "Enter Your Password",
                hintStyle: TextStyle(fontSize: 13)
              ),
              obscureText: true,
            ),
            SizedBox(height: 50,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC31F48),
                // shape: RoundedRectangleBorder(),
                side: BorderSide(width: 1, color: Colors.grey),
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10)
              ),
              onPressed: () {Navigator.pushNamed(context, '/home');},
              child: Text("Login", style: TextStyle(fontSize: 16, color: Colors.white),)
            )
          ],
        ),
      ),


    );
  }
}
