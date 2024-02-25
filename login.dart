import 'package:flutter/material.dart';
import 'package:library_manager_project/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController searchcontroller1=new TextEditingController();
  TextEditingController searchcontroller2=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.blue.shade900,
                  height: MediaQuery.of(context).size.height/5,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: MediaQuery.of(context).size.width/10,),
                      Image.asset("assets/icon.png"),
                      SizedBox(width: MediaQuery.of(context).size.width/10,),
                      Text("LIBRARY MANAGER",style: TextStyle(fontSize: MediaQuery.of(context).size.height/10,fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue.shade800,
                            Colors.blue.shade50
                          ]
                      )
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height/10),
                      Container(
                        child: Card(
                          child: Container(
                              width: MediaQuery.of(context).size.width/5,
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              child:
                              Row(
                                children: <Widget>[
                                  Icon(Icons.person_outline_outlined, size: MediaQuery.of(context).size.height/20,),
                                  Text("  User Login",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20,fontWeight: FontWeight.w400),)
                                ],
                              ),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/10),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 5, 50, 5),
                            child: Column(
                              children: [
                                Text("Username:",style: TextStyle(fontSize: MediaQuery.of(context).size.height/25, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/20),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                          },
                                          child: Container(
                                            child: Icon(Icons.email_outlined,color: Colors.black,),
                                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: searchcontroller1,
                                            textInputAction: TextInputAction.search,
                                            onSubmitted: (value){
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Enter Username"
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/3),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/20),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 5, 60, 5),
                            child: Column(
                              children: [
                                Text("Password:",style: TextStyle(fontSize: MediaQuery.of(context).size.height/25, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/20),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                          },
                                          child: Container(
                                            child: Icon(Icons.password_outlined,color: Colors.black,),
                                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: searchcontroller2,
                                            textInputAction: TextInputAction.search,
                                            obscureText: true,
                                            onSubmitted: (value)async{
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Enter Password"
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/3),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/20),
                      ElevatedButton(
                          onPressed: (){
                            if(searchcontroller1.text.toString()=="" || searchcontroller2.text.toString()=="")
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Please fill all fields")),
                              );
                            }
                            else if(searchcontroller1.text.toString()=="user" && searchcontroller2.text.toString()!="admin")
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Wrong Password")),
                                );
                              }
                            else if(searchcontroller1.text.toString()!="user" && searchcontroller2.text.toString()=="admin")
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Invalid Username")),
                              );
                            }
                            else if(searchcontroller1.text.toString()!="user" && searchcontroller2.text.toString()!="admin")
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Invalid Username or Password")),
                              );
                            }
                            else if(searchcontroller1.text.toString()=="user" && searchcontroller2.text.toString()=="admin")
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Login Successful"),
                                )
                              );
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                            }
                          },
                          child: Text("Login")
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/5),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
