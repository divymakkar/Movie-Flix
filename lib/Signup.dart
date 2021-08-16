import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/Login.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _passwordVisible = false;
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background-app-1.jpeg"),
              fit: BoxFit.cover,)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 400,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top:10,left: 15,right: 15),
                        child: TextFormField(
                          onChanged: (val){
                            setState(() {
                              email = val;
                            });
                          },
                          validator: (val){
                            if(val.isEmpty){
                              return 'Enter an email';
                            }
                            else if(!val.contains('@')){
                              return 'Enter valid email address';
                            }
                            else{
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(239,238,243, 0.8),

                            hintText: 'Enter Email Address',
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        child: TextFormField(
                          onChanged: (val){
                            setState(() {
                              password = val;
                            });
                          },
                          validator: (val){
                            if(val.length < 6){
                              return 'Password length should be greater than 6';
                            }
                            else{
                              return null;
                            }
                          },
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(239,238,243, 0.8),
                            hintText: 'Enter Password',
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color.fromRGBO(223,27,71, 0.8),
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,

                            ),

                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      SizedBox(height: 30,),
                      Center(
                        child: Container(
                          height: 50.0,
                          child: RaisedButton(
                            onPressed: () {
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [Color.fromRGBO(223,27,71, 0.8), Color.fromRGBO(206,11,56, 1)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Container(
                                constraints: BoxConstraints(maxWidth: 280.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Sign Up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Container(
                          height: 50.0,
                          child: RaisedButton(
                            onPressed: () {
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Container(
                                constraints: BoxConstraints(maxWidth: 280.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    SizedBox(width: 5.0,),
                                    Image(image : AssetImage("assets/Gmail-logo.jpg")),
                                    Text(
                                      "Sign Up With Google",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: Container(
                          width: size.width * 0.8,
                          child: Row(
                            children: [
                              Expanded(child: Divider(
                                color: Colors.black45,
                                height: 1.5,
                              )),
                              SizedBox(width: 5,),
                              Text("OR",style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w400,
                              ),),
                              SizedBox(width: 5,),
                              Expanded(child: Divider(
                                color: Colors.black45,
                                height: 1.5,
                              )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Center(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already Have an Account ? ",
                                style: TextStyle(

                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color:Color.fromRGBO(223,27,71, 0.8),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
