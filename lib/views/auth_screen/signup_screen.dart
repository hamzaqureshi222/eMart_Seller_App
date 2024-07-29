import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/auth_controller.dart';
import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:emart_seller/views/home_screen/home.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:emart_seller/views/widgets/our_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var passwordRetypeController = TextEditingController();
    var passwordVisible = false.obs;
    var passwordRetypeVisible = false.obs;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Obx(
                () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.heightBox,
                normalText(text: welcome, size: 18.0),
                20.heightBox,
                Row(
                  children: [
                    Image.asset(
                      icLogo,
                      width: 60,
                      height: 60,
                    ).box.border(color: white).rounded.padding(const EdgeInsets.all(8)).make(),
                    10.widthBox,
                    boldText(text: appname, size: 18.0),
                  ],
                ),
                40.heightBox,
                boldText(text: loginTo, size: 14.0, color: lightGrey),
                10.heightBox,
                Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        fillColor: textfieldGrey,
                        filled: true,
                        prefixIcon: Icon(Icons.person, color: purpleColor),
                        border: InputBorder.none,
                        hintText: "Enter Name",
                      ),
                    ),
                    10.heightBox,
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        fillColor: textfieldGrey,
                        filled: true,
                        prefixIcon: Icon(Icons.email, color: purpleColor),
                        border: InputBorder.none,
                        hintText: emailHint,
                      ),
                    ),
                    10.heightBox,
                    Obx(
                          () => TextFormField(
                        controller: passwordController,
                        obscureText: !passwordVisible.value,
                        decoration: InputDecoration(
                          fillColor: textfieldGrey,
                          filled: true,
                          prefixIcon: const Icon(Icons.lock, color: purpleColor),
                          border: InputBorder.none,
                          hintText: passwordHint,
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible.value ? Icons.visibility : Icons.visibility_off,
                              color: purpleColor,
                            ),
                            onPressed: () {
                              passwordVisible.value = !passwordVisible.value;
                            },
                          ),
                        ),
                      ),
                    ),
                    10.heightBox,
                    Obx(
                          () => TextFormField(
                        controller: passwordRetypeController,
                        obscureText: !passwordRetypeVisible.value,
                        decoration: InputDecoration(
                          fillColor: textfieldGrey,
                          filled: true,
                          prefixIcon: const Icon(Icons.lock, color: purpleColor),
                          border: InputBorder.none,
                          hintText: passwordHint,
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordRetypeVisible.value ? Icons.visibility : Icons.visibility_off,
                              color: purpleColor,
                            ),
                            onPressed: () {
                              passwordRetypeVisible.value = !passwordRetypeVisible.value;
                            },
                          ),
                        ),
                      ),
                    ),
                    20.heightBox,
                    SizedBox(
                      width: context.screenWidth - 100,
                      child: controller.isloading.value
                          ? const Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(purpleColor)),
                      )
                          : ourButton(
                        onPress: () async {
                          // Validate the fields
                          if (nameController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              passwordRetypeController.text.isEmpty) {
                            VxToast.show(context, msg: 'Please fill all fields');
                            return;
                          }
                          if (passwordController.text != passwordRetypeController.text) {
                            VxToast.show(context, msg: 'Passwords do not match');
                            return;
                          }

                          controller.isloading.value = true;
                          await controller.signupMethod(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context,
                          ).then((value) {
                            if (value != null) {
                              currentUser = value.user!;
                            }
                            return controller.storeUserData(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                            );
                          }).then((value) {
                            controller.isloading.value = false;
                            VxToast.show(context, msg: 'Signup Successfully');
                            Get.offAll(() => const Home());
                          }).catchError((error) {
                            controller.isloading.value = false;
                            VxToast.show(context, msg: error.toString());
                          });
                        },
                        title: 'Signup',
                      ),
                    ),
                    15.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        normalText(text: already, color: purpleColor, size: 12.0),
                        8.widthBox,
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: boldText(text: signin, color: purpleColor, size: 16.0),
                        ),
                        5.widthBox,
                      ],
                    ),
                    10.heightBox,
                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(8)).make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
