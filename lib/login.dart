import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  String user = "";
  String senha = "";
  String txtUser = "Usuario";
  String txtSenha = "Senha";

  TextEditingController userControler = TextEditingController();
  TextEditingController senhaControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(193, 11, 45, 73),
      appBar: AppBar(
        title: const Text("Login", style: TextStyle(fontSize: 24), textAlign: TextAlign.center,),
      ),
      body: Stack(children: [
          Center(
            child: Container(
              width: 310,
              height: 310,
              decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color.fromARGB(192, 17, 67, 107),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(4, 6),
                          blurRadius: 8,
                          blurStyle: BlurStyle.normal
                        )
                      ]
                    ),
                   child: Column(children: [

                   Container(
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.all(8),
                      child: Image.asset("/img/logoCarrinho.png"),
                   ),

                   Container(
                    child: const Text("Bem-Vindo!", style: TextStyle(color: Colors.white, fontSize: 24), textAlign: TextAlign.center,),
                   ),

                   Container(
                      padding: EdgeInsets.only(left: 8, right: 8, bottom: 5, top: 8),
                      width: 350,
                      child: TextField(
                        controller: userControler,
                        decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Usuario"
                        )
                      ),
                    ),
                  
                  Container(
                    padding: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 5),
                    width: 350,
                    child: TextField(
                      controller: senhaControler,
                      obscureText: true,
                      decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Senha",
                  ),
                ),
                  ),

                Container(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text("Logar"), 
                    onPressed: () {
                        if(userControler.text == "admim" && senhaControler.text == "1234"){
                          Navigator.of(context).pushNamed("/home");
                        } else if(userControler.text != "admim" && senhaControler.text != "1234" && userControler.text != "" && senhaControler.text != ""){
                          showDialog(context: context, builder: (BuildContext context){
                            return const AlertDialog(
                              backgroundColor: Colors.green,
                                title: Text("Usuario e/ou senha incorretos", style: TextStyle(fontSize: 24),),
                            );
                          }
                          );
                        } else{
                          showDialog(context: context, builder: (BuildContext context){
                            return const AlertDialog(
                              backgroundColor: Colors.green,
                                title: Text("Preencher os campos é obrigatorio", style: TextStyle(fontSize: 24),),
                            );
                          }
                          );
                        }
                        userControler.clear();
                        senhaControler.clear();
                    },),
                ),
              ]),
            ),
          )
      ]),
    );
  }
}
