import 'package:flutter/material.dart';
import 'package:flutter_change_notify/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  final homeController = HomeController();
  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    homeController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Notify'),
      ),
      body: Stack(
        children: [
          homeController.carros.isEmpty
              ? const Center(
                  child: Text('Nenhum carro adicionado'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: homeController.carros.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                          child: Center(
                        child: Icon(Icons.local_taxi),
                      )),
                      title: Text(homeController.carros[index]),
                    );
                  }),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Row(children: [
                  Expanded(
                    child: TextFormField(
                      focusNode: _focusNode,
                      validator: (carro) {
                        if (carro!.isEmpty) {
                          return 'Digite um carro';
                        }
                        return null;
                      },
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'Digite um novo carro',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        homeController.addCarro(textController.value.text);
                        textController.text = '';
                        _focusNode.requestFocus();
                      }
                    },
                    child: const CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
