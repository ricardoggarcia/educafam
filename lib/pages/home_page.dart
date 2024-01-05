import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:educafam/util/smart_device_box.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // padding constants
  final double horizontalPadding = 40;
  final double verticalPadding = 25;

  // list of smart devices
  List mySmartDevices = [
    // [ smartDeviceName, iconPath , powerStatus ]
    ["Alarma", "lib/images/light-bulb.png", false, "rutas"],
    ["Smart AC", "lib/images/air-conditioner.png", false,  "rutas"],
    ["Smart TV", "lib/images/smart-tv.png", false,  "rutas"],
    ["Smart Fan", "lib/images/fan.png", false,  "rutas"],
  ];

  // power button switched
  void powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
    // Muestra un SnackBar cuando el usuario cambia el estado del dispositivo
    showSnackBar(value, index);
  }


  Future<void> connectToTuyaEnciende() async {
    try {
      var apiUrl = "http://192.168.12.140:5000/tasks/enciende";
      var response = await http.get(Uri.parse(apiUrl));
      Map<String, dynamic> data = json.decode(response.body);
      String message= data['message'];
      print(message);
    } catch (e) {
      print('Error inesperado sistema: $e');
    }
  }

  Future<void> connectToTuyaApaga() async {
    try {
      var apiUrl = "http://192.168.12.140:5000/tasks/apaga";
      var response = await http.get(Uri.parse(apiUrl));
      Map<String, dynamic> data = json.decode(response.body);
      String message= data['message'];
      print(message);
    } catch (e) {
      print('Error inesperado sistema: $e');
    }
  }

  void showSnackBar(bool value, int index) {
    String mensaje ='';
    if (value) {
      connectToTuyaEnciende();
      mensaje = mySmartDevices[index][0]+" Encendido..!";
    } else {
      connectToTuyaApaga();
       mensaje = mySmartDevices[index][0]+" Apagado..!";
    }


    //String message ='${mySmartDevices[index][0]} ${value ? $mensaje : $mensaje}';
    String message =mensaje;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.person,
                    size: 25,
                    color: Colors.grey[900],
                  ),
                  Text(
                    'Ricardo García',
                    style: GoogleFonts.bebasNeue(fontSize: 20),
                  ),
                ],

              ),
            ),

            const SizedBox(height: 10),

            // welcome home
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bienvenido,",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                  ),
                ],
              ),
            ),


            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                thickness: 1,
                color: Color.fromARGB(255, 204, 204, 204),
              ),
            ),

            const SizedBox(height: 25),

            // smart devices grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                "Opciones",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // grid
            Expanded(
              child: GridView.builder(
                itemCount: 1,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                ),
                itemBuilder: (context, index) {
                  return SmartDeviceBox(
                    smartDeviceName: mySmartDevices[index][0],
                    iconPath: mySmartDevices[index][1],
                    powerOn: mySmartDevices[index][2],
                    onChanged: (value) => powerSwitchChanged(value, index),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
