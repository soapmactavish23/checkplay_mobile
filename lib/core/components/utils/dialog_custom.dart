import 'package:flutter/material.dart';

const String salvo = "Salvo com sucesso!";
const String deletado = "Deletado com sucesso!";
const String confirmacao = "Tem certeza que deseja excluir?";
const String naoSalvo = "Não foi possível salvar!";
const String naoDeletado = "Não foi possivel deletar!";
const String carregando = "Carregando...";

abstract class DialogCustom {
  static dialogError({required BuildContext context, required msg}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(
        seconds: 5,
      ),
      content: Text(msg),
      backgroundColor: Colors.red,
    ));
  }

  static dialogSuccess({required context, required msg}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          seconds: 5,
        ),
        content: Text(msg),
        backgroundColor: Colors.green,
      ),
    );
  }

  static dialogLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: const Row(
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('Carregando...'),
                )
              ],
            ),
          );
        });
  }

  static dialogComponent(
      {required BuildContext context,
      required String title,
      required Widget content,
      required VoidCallback onPressed}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              title,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            content: content,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: onPressed,
                child: const Text(
                  "Confirmar",
                  style: TextStyle(color: Colors.green),
                ),
              )
            ],
          );
        });
  }

  static dialogDetails(
      {required BuildContext context,
      required String title,
      required Widget content}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Text(
              title,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            content: content,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Fechar",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        });
  }

  static dialogConfirm(
      {required BuildContext context,
      String titulo = "Atenção",
      required String msg,
      required VoidCallback onPressed}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            titulo,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          content: Text(msg),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar",
                    style: TextStyle(color: Colors.red))),
            TextButton(onPressed: onPressed, child: const Text("Confirmar"))
          ],
        );
      },
    );
  }
}
