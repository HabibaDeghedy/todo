import 'package:flutter/material.dart';

import 'shared/componants/componants.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formkey ,
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value)
                {
                  print(value);
                },
                onChanged: (value){
                  print(value);
                },
                validator: (value){
                  if(value!.isEmpty){
                    return 'email address must not be empty';
                  }
                  return null;

                },
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              defaultFormField(
                  controller: passwordController,
                  label: 'password',
                  prefix: Icons.lock,
                  suffix: isPassword? Icons.visibility_off:Icons.visibility ,
                  isPassword: isPassword,
                  suffixPressed: (){
                    setState(() {
                      isPassword =!isPassword;
                    });
                  },
                  type: TextInputType.visiblePassword,
                  validate: (value){
                    if(value!.isEmpty){
                      return 'password must not be empty';
                    }
                    return null;
                  }

              ),
              SizedBox(
                height: 20,
              ),
              defaultButton(
                text: 'login',
                width:double.infinity,
                background: Colors.blue,
                function: (){
                  if(formkey.currentState != null) {
                    formkey.currentState!.validate();
                    print(emailController.text);
                    print(passwordController.text);

                  }
                }
              ),
              SizedBox(
                height: 20,
              ),
              defaultButton(
                  text: 'register',
                  width:double.infinity,
                  background: Colors.blue,
                  function: (){
                    print(emailController.text);
                    print(passwordController.text);
                  }
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Don\t have an account?',
                  ),
                  TextButton(onPressed: (){}, child: Text(
                    'Register now',
                  ))
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
