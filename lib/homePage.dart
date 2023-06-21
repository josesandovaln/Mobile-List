import 'package:flutter/material.dart';

class Item {
  String nome;
  int quantidade;
  double valor;
  double valorF;

  Item({required this.nome, required this.quantidade, required this.valor, required this.valorF});
}

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<Item> items = [];

  TextEditingController nomeController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();
  TextEditingController valorController = TextEditingController();

  int selectedIndex = -1;

  void adicionarItem() {
    String nome = nomeController.text;
    int quantidade = int.tryParse(quantidadeController.text) ?? 0;
    // double valor = double.tryParse(valorController.text) ?? 0.0;

    if (nome.isNotEmpty && quantidade > 0) {
      Item newItem = Item(nome: nome, quantidade: quantidade, valor: 0, valorF: 0);
      setState(() {
        items.add(newItem);
      });
      nomeController.clear();
      quantidadeController.clear();
      valorController.clear();
    }
  }

  void editarItem(int index) {
    setState(() {
      selectedIndex = index;
      nomeController.text = items[index].nome;
      quantidadeController.text = items[index].quantidade.toString();
      valorController.text = items[index].valor.toString();
    });
     openModal(context); 
  }

  void salvarEdicao() {
    String nome = nomeController.text;
    int quantidade = int.tryParse(quantidadeController.text) ?? 0;
    // double valor = double.tryParse(valorController.text) ?? 0.0;

    if (nome.isNotEmpty && quantidade > 0) {
      Item editedItem = Item(nome: nome, quantidade: quantidade, valor: 0, valorF: 0);
      setState(() {
        items[selectedIndex] = editedItem;
        selectedIndex = -1;
      });
      nomeController.clear();
      quantidadeController.clear();
      valorController.clear();
    }
  }

  void excluirItem(int index) {
    setState(() {
      items.removeAt(index);
      if (selectedIndex == index) {
        selectedIndex = -1;
      }
    });
  }

  void openModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome do item'),
              ),
              TextField(
                controller: quantidadeController,
                decoration: InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
              ),
              // TextField(
              //   controller: valorController,
              //   decoration: InputDecoration(labelText: 'Valor'),
              //   keyboardType: TextInputType.number,
              // ),
              ElevatedButton(
                onPressed: selectedIndex == -1 ? adicionarItem : salvarEdicao,
                child: Text(selectedIndex == -1 ? 'Adicionar Item' : 'Salvar Edição'),
              ),
            ],
          ),
        );
      },
    );
  }

  void excluirTodos() {
    setState(() {
      items.clear();
    });
  }

    void adicionarValor(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double novoValor = items[index].valor;
        return AlertDialog(
          title: Text('Adicionar Valor'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              novoValor = double.tryParse(value) ?? items[index].valor;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  items[index].valor = novoValor;
                });
                Navigator.of(context).pop();
              },
              child: Text('Adicionar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(193, 11, 45, 73),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(193, 11, 45, 73),
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(35),
            height: 100,
            width: 400,
            color: Colors.green,
            child: Text("Menu Lateral", textAlign: TextAlign.center, style: TextStyle(fontSize: 24, color: Colors.white),),
          ),
          ListTile(
            iconColor: Colors.white,
            leading: Icon(Icons.delete),
            onTap: () => excluirTodos(),
            title: Text("Apagar tudo", style: TextStyle(color: Colors.white),),
            subtitle: Text("Apagar todos os itens da lista", style: TextStyle(color:Color.fromARGB(192, 255, 255, 255),),),
          ),

          ListTile(
            iconColor: Colors.white,
            leading: Icon(Icons.exit_to_app),
            onTap: () => Navigator.of(context).popAndPushNamed("/"),
            title: Text("Logalt", style: TextStyle(color: Colors.white),),
            subtitle: Text("Voltar para tela de login", style: TextStyle(color:Color.fromARGB(192, 255, 255, 255),),),
          )
        ]),
      ),
        appBar: AppBar(
          title: const Text('Lista de Itens'),
        ),
        body: Column(
          children: [
            
            Container(
              width: 100,
              height: 100,
              padding: EdgeInsets.all(8),
              child: Image.asset("/img/logoCarrinho.png"),
                   ),

            Container(
              padding: EdgeInsets.all(10),
              child: const Text("Bem-Vindo a sua lista de compras", style: TextStyle(fontSize: 20, color: Colors.white),),
            ),

            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    items[index].valorF = items[index].quantidade * items[index].valor;
                    String valorFinal = items[index].valorF.toStringAsFixed(2);
                    return Container(
                      padding: EdgeInsets.all(8),
                      width: 150,
                      height: 80,
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
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                      child: ListTile(
                        iconColor: Colors.white,
                        title: Text(items[index].nome, style: TextStyle(color: Colors.white),),
                        subtitle: Text(
                          'Quantidade: ${items[index].quantidade.toString()} | Valor-uni: R\$ ${items[index].valor.toStringAsFixed(2)} \n Valor-Tota: R\$ ${valorFinal}', style: TextStyle(color: Color.fromARGB(192, 255, 255, 255)),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => editarItem(index),
                              icon: Icon(Icons.edit),
                            ),
                            
                            IconButton(
                              onPressed: () => excluirItem(index),
                              icon: Icon(Icons.delete),
                            ),
                                  
                            IconButton(
                              onPressed: () => adicionarValor(index),
                              icon: Icon(Icons.money),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () => openModal(context),
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      );
  }
}
