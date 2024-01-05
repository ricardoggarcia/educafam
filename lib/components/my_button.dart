import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../pages/home_page.dart';



class MyButton extends StatelessWidget {
//  final Function()? onTap;
  final Function(String, String)? onTap;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  const MyButton({super.key, required this.onTap,required this.usernameController,
    required this.passwordController,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() async {
        try {
          onTap?.call(usernameController.text, passwordController.text);
          String username = usernameController.text;
          String password = passwordController.text;
          //List<Map<String, dynamic>> resultado = await fetchData();
          String message='0';
          String estado = '0';
          try {
            var apiUrl = "https://degecomp.com/apieducafam/index.php/$username/$password";
            var response = await http.get(Uri.parse(apiUrl));
            Map<String, dynamic> data = json.decode(response.body);
            estado = data['estado'];
            message= data['message'];
            print(estado);
          } catch (e) {
            print('Error inesperado sistema: $e');
            estado= '3';
          }
          //var resultado = await fetchData(username, password);
          var resultado = estado;

          print(resultado);
          if (resultado != "0" ) {
            String mensaje = "INGRESO EXITOSO..! $resultado aqui";
            _mostrarIngreso(context,  mensaje);
          } else {
            String mensaje = "INGRESO NO PERMITIDO..! $resultado aqui";
            _mostrarPopup(context,  mensaje);
          }
        } catch (e) {
          print('Error: $e');
        }
      },

      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
          child: Text(
            "Ingresar",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }


  //////////////////  funciones ///////////////
  void _mostrarPopup(BuildContext context , String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mensaje Sistema'),
          content: Text(mensaje),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarIngreso(BuildContext context , String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mensaje Sistema'),
          content: Text(mensaje),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()), // Cambiado a HomePage
                );
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }


//////////////////////conecta api rest //////////////////////////
  //Future<List<Map<String, dynamic>>> fetchData() async {
    Future<Object> fetchData(String username, String password) async {
    try {
         var apiUrl = "https://degecomp.com/apieducafam/index.php/$username/$password";
       //  print("apiUrl: $apiUrl");
         var response = await http.get(Uri.parse(apiUrl));
         /*List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(json.decode(response.body));*/  // par auna lista de  datos
         Map<String, dynamic> data = json.decode(response.body);
         String estado = data['estado'];
         String message= data['message'];
         print(message);
         return estado;
    } catch (e) {
         print('Error inesperado sistema: $e');
         return "";
    }

  }




}

