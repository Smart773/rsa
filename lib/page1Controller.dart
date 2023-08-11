import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Util.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Page1Controller extends GetxController {
  static Page1Controller get to => Get.find();

  final controller1 = TextEditingController().obs;
  final controller2 = TextEditingController().obs;
  final controller3 = TextEditingController().obs;
  final controller4 = TextEditingController().obs;
  final controller5 = TextEditingController().obs;

  RxBool step1 = false.obs;
  RxBool step2 = false.obs;
  RxBool step3 = false.obs;

  RxString outputOfStep1 = "".obs;
  RxString outputOfStep2 = "".obs;
  RxString outputOfStep3 = "".obs;

  // store the value of n and phi
  int n = 0;
  int phi = 0;
  int e = 0;
  int d = 0;
  int ciperText = 0;
  //Step1

  void CalculatevalueOfN() {
    int p = int.parse(controller1.value.text);
    int q = int.parse(controller2.value.text);

    n = p * q;
  }

  void CalculatevalueOfPhi() {
    int p = int.parse(controller1.value.text);
    int q = int.parse(controller2.value.text);
    phi = (p - 1) * (q - 1);
  }

  void onPressStepOne() {
    if (controller1.value.text.isEmpty || controller2.value.text.isEmpty) {
      Get.snackbar("Error", "Please enter p and q");
      return;
    }
    if (!Util.isPrime(controller1.value.text)) {
      outputOfStep1.value = "p ";
      if (!Util.isPrime(controller2.value.text)) {
        outputOfStep1.value += "and q not prime";
      } else {
        outputOfStep1.value = "is not prime";
      }
      return;
    }
    if (!Util.isPrime(controller2.value.text)) {
      outputOfStep1.value = "q is not prime";
      return;
    }
    outputOfStep1.value = "p and q are prime";
    CalculatevalueOfN();
    CalculatevalueOfPhi();
    outputOfStep1.value += "\n n = $n \n phi = $phi";
    step1.value = true;
  }

// Step2
  bool ValidateValueOfE() {
    // using extended euclidean algorithm
    e = int.parse(controller3.value.text);

    int gcd = Util.gcd(e, phi);
    if (gcd == 1) {
      // e is valid
      outputOfStep2.value = "e is valid";
      return true;
    }
    outputOfStep2.value = "e is not valid";
    return false;
  }

  void CalculateValueOfC() {
    int m = int.parse(controller4.value.text);
    ciperText = Util.modPow(m, e, n);
    outputOfStep2.value += "\n c = $ciperText";
  }

  void onPressStepTwo() {
    if (controller3.value.text.isEmpty) {
      Get.snackbar("Error", "Please enter e");
      return;
    }
    if (!ValidateValueOfE()) {
      return;
    }
    if (controller4.value.text.isEmpty) {
      Get.snackbar("Error", "Please enter m");
      return;
    }
    CalculateValueOfC();
    step2.value = true;
  }

  // Step3
  void ValidateValueOfD() {
    int d = int.parse(controller5.value.text);
    if ((e * d) % phi == 1) {
      outputOfStep3.value = "d is valid";
    } else {
      outputOfStep3.value = "d is not valid";
    }
  }

  void CalculateValueOfM() {
    int d = int.parse(controller5.value.text);
    // m2=(c**d)%n
    int m = Util.modPow(ciperText, d, n);
    outputOfStep3.value += "\n m = $m";
  }

  void onPressStepThree() {
    if (controller5.value.text.isEmpty) {
      Get.snackbar("Error", "Please enter d");
      return;
    }
    ValidateValueOfD();
    CalculateValueOfM();
    step3.value = true;
  }

  // Reset
  void reset() {
    controller1.value.clear();
    controller2.value.clear();
    controller3.value.clear();
    controller4.value.clear();
    controller5.value.clear();
    step1.value = false;
    step2.value = false;
    step3.value = false;
    outputOfStep1.value = "";
    outputOfStep2.value = "";
    outputOfStep3.value = "";
  }
}
