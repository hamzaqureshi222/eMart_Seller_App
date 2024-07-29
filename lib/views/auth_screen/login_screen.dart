import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/auth_controller.dart';
import 'package:emart_seller/views/auth_screen/signup_screen.dart';
import 'package:emart_seller/views/home_screen/home.dart';
import 'package:emart_seller/views/home_screen/home_screen.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:emart_seller/views/widgets/our_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var passwordVisible = false.obs;

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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: normalText(text: forgotPassword, color: purpleColor, size: 10.0),
                      ),
                    ),
                    20.heightBox,
                    SizedBox(
                      width: context.screenWidth - 100,
                      child: controller.isloading.value
                          ? const Center(
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(purpleColor)),
                      )
                          : ourButton(
                        onPress: () async {
                          controller.isloading(true);
                          await controller.loginMethod(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text,
                          ).then((value) {
                            if (value != null) {
                              currentUser = value.user!;
                              controller.isloading(false);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const HomeScreen()),
                              );
                              VxToast.show(context, msg: "Logged in");
                              Get.offAll(const Home());
                            } else {
                              controller.isloading(false);
                            }
                          });
                        },
                        title: login,
                      ),
                    ),
                    20.heightBox,
                    SizedBox(
                      width: context.screenWidth - 100,
                      child: ourButton(
                        onPress: () {
                          Get.to(const SignupScreen());
                        },
                        title: 'Sign up',
                      ),
                    ),
                    10.heightBox,
                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(8)).make(),
                const Spacer(),
                Center(
                  child: normalText(text: credit, size: 14.0, color: lightGrey),
                ),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
