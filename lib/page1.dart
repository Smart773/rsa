import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rsa/Util.dart';

import 'page1Controller.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    //txt controller
    // Getx controller
    Page1Controller controller = Get.put(Page1Controller());
    //form key
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information Security'),
        actions: [
          IconButton(
            onPressed: () {
              controller.controller1.value.clear();
              controller.controller2.value.clear();
              controller.controller3.value.clear();
              controller.controller4.value.clear();
              controller.controller5.value.clear();
              controller.step1.value = false;
              controller.step2.value = false;
              controller.step3.value = false;
              controller.outputOfStep1.value = "";
              controller.outputOfStep2.value = "";
              controller.outputOfStep3.value = "";
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("RSA Checker", style: TextStyle(fontSize: 30)),
              Obx(() => TextBoxRow(
                    enabled: !controller.step1.value,
                    controller1: controller.controller1.value,
                    text1: "Entere p",
                    controller2: controller.controller2.value,
                    text2: "Entere q",
                    validator1: (value) {
                      //check if p is prime or not
                      if (Util.isPrime(value)) {
                        return 'Not prime';
                      }
                      if (value == null || value.isEmpty) {
                        return 'Empty';
                      }
                      return null;
                    },
                    validator2: (value) {
                      //check if q is prime or not
                      if (Util.isPrime(value)) {
                        return 'Not prime';
                      }
                      if (value == null || value.isEmpty) {
                        return 'Empty';
                      }
                      return null;
                    },
                  )),
              Obx(() => Visibility(
                    visible: controller.outputOfStep1.isNotEmpty,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.grey[300],
                      ),
                      child: Text(controller.outputOfStep1.value),
                    ),
                  )),
              Obx(
                () => Visibility(
                  visible: !controller.step1.value,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.onPressStepOne();
                    },
                    child: const Text("Step 1"),
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.step1.value,
                  child: TextBoxRow(
                    enabled: !controller.step2.value,
                    controller1: controller.controller3.value,
                    text1: "Enter e",
                    controller2: controller.controller4.value,
                    text2: "Entere m",
                    validator1: (value) {
                      return null;
                    },
                    validator2: (value) {
                      return null;
                    },
                  ),
                ),
              ),
              Obx(() => Visibility(
                    visible: controller.outputOfStep2.isNotEmpty &&
                        controller.step1.value,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.grey[300],
                      ),
                      child: Text(controller.outputOfStep2.value),
                    ),
                  )),
              Obx(
                () => Visibility(
                  visible: controller.step1.value && !controller.step2.value,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.onPressStepTwo();
                        },
                        child: const Text("Step 2"),
                      ),
                    ],
                  ),
                ),
              ),
              //Step 3
              Obx(
                () => Visibility(
                  visible: controller.step2.value,
                  child: TextFormField(
                    controller: controller.controller5.value,
                    keyboardType: TextInputType.number,
                    //reg validate
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],

                    decoration: const InputDecoration(
                      labelText: "Enter d",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() => Visibility(
                    visible: controller.outputOfStep3.isNotEmpty &&
                        controller.step1.value &&
                        controller.step2.value,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.grey[300],
                      ),
                      child: Text(controller.outputOfStep3.value),
                    ),
                  )),
              Obx(
                () => Visibility(
                  visible: controller.step1.value &&
                      controller.step2.value &&
                      !controller.step3.value,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.onPressStepThree();
                        },
                        child: const Text("Step 3"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextBoxRow extends StatelessWidget {
  const TextBoxRow({
    super.key,
    required this.controller1,
    required this.text1,
    required this.controller2,
    required this.text2,
    required this.validator1,
    required this.validator2,
    required this.enabled,
  });

  final TextEditingController controller1;
  final String text1;
  final TextEditingController controller2;
  final String text2;
  final Function validator1;
  final Function validator2;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              enabled: enabled,
              controller: controller1,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: text1,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: TextFormField(
              enabled: enabled,
              controller: controller2,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                return null;
              },
              decoration: InputDecoration(
                labelText: text2,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
