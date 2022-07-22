import 'package:driver_app/global/global.dart';
import 'package:driver_app/splashScreen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}



class _CarInfoScreenState extends State<CarInfoScreen> {

  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController = TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();
  List<String> carTypeList = ["Uber-x", "Uber-go","Bike"];
  String? selectedCarType;

  validateCarInfo(){
    if(carColorTextEditingController.text.trim().isNotEmpty 
        && carNumberTextEditingController.text.trim().isNotEmpty 
        && carModelTextEditingController.text.trim().isNotEmpty
        && selectedCarType != null
    ){
      saveCarInfo();
    }
  }
  
  saveCarInfo(){
    Map driverCarInfoMap = {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCarType,
    };
    DatabaseReference driverRef = FirebaseDatabase.instance.ref().child("drivers");
    driverRef.child(currentFirebaseUser!.uid).child("car_details").set(driverCarInfoMap);
    
    Fluttertoast.showToast(msg: "Car Information has been saved successfully!");

    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/car_logo.jpeg"),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Car Detail",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: carModelTextEditingController,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Car Model",
                  hintText: "Car Model",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: carNumberTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Car Number",
                  hintText: "Car Number",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: carColorTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Car Color",
                  hintText: "Car Color",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              DropdownButton(
                iconSize: 26,
                hint: const Text(
                  "Please choose Car Type",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                value: selectedCarType,
                onChanged: (newValue) {
                  setState(() {
                    selectedCarType = newValue.toString();
                  });
                },
                items: carTypeList.map((car) {
                  return DropdownMenuItem(
                    child: Text(
                      car,
                    ),
                    value: car,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    validateCarInfo();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
