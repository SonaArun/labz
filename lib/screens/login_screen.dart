import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  bool obscureText = true;
  ValueNotifier<bool> showInvalidMsg = ValueNotifier(false);

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    // Please use email: test@yopmail.com password: test@123 for login
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){},
        icon: const Icon(Icons.arrow_back_ios, color: Color.fromARGB(255,137,139,140)),
      ),),
      body: FutureBuilder(
        // initialize firebase
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color.fromARGB(255,244,249,250),
            margin: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Form(
                    key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(63),
                                color: const Color.fromARGB(255,244,249,250)
                              ),
                              child: Image.asset(
                                'assets/images/login_image.jpg',
                                height: 60, width: 60,
                              ),
                            ),
                          ),
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text('Log in', 
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255,46,46,46)),),
                            ),
                          ),
                          // Show invalid credntial message when credentails are wrong
                          ValueListenableBuilder(
                            valueListenable: showInvalidMsg,
                            builder: (context, state, child) {
                              return showInvalidMsg.value ? 
                              const Center(
                                child: Padding(padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text('Invalid credentials', 
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color.fromARGB(255,46,46,46)),),
                              )
                              ):const Center();
                            }
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text('Email', 
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromARGB(255,46,46,46)),),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 244,249,250),
                              borderRadius: BorderRadius.circular(16)),
                              //Email text field
                            child: TextFormField(
                              focusNode: emailFocus,
                              controller: emailController,
                                cursorColor: emailFocus.hasFocus? const Color.fromARGB(255, 236,82,82): const Color.fromARGB(255,137,139,140),
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(color: Colors.red),
                                prefixIcon: const Icon(Icons.email_outlined),
                                prefixIconColor: emailFocus.hasFocus? const Color.fromARGB(255, 236,82,82): const Color.fromARGB(255,137,139,140),
                                border: InputBorder.none,
                                hintText: 'Email',
                                hintStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color.fromARGB(255,137,139,140)),),
                              onFieldSubmitted: (value) {
                                
                              },
                              validator: (value) {
                                if(value == null){
                                  return 'Please enter your username';
                                }
                                else if (value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text('Password', 
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromARGB(255,46,46,46)),),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 244,249,250),
                              borderRadius: BorderRadius.circular(16)),
                              // Password text field
                            child: TextFormField(
                              focusNode: passwordFocus,
                              controller: passwordController,
                              obscureText: obscureText,
                                cursorColor: passwordFocus.hasFocus? const Color.fromARGB(255, 236,82,82): const Color.fromARGB(255,137,139,140),
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(color: Colors.red),
                                suffixIconColor: passwordFocus.hasFocus?const Color.fromARGB(255,137,139,140):const Color.fromARGB(255,137,139,140),
                                prefixIcon: const Icon(Icons.lock_outline_rounded),
                                prefixIconColor: passwordFocus.hasFocus? const Color.fromARGB(255, 236,82,82): const Color.fromARGB(255,137,139,140),
                                suffixIcon: IconButton(icon: obscureText ? const Icon(Icons.visibility_off_outlined): const Icon(Icons.visibility_outlined), 
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                  },),
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color.fromARGB(255,137,139,140)),),
                              onFieldSubmitted: (value) {
                                
                              },
                              validator: (value) {
                                if(value == null){
                                  return 'Please enter your password';
                                }
                                else if (value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                          // Forgot password
                          InkWell(
                            onTap: (){},
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: const Text('Forget Password?',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color.fromARGB(255,137,139,140)),),
                            ),
                          ),
                          // Login button
                          ElevatedButton(onPressed: () async {
                            // On submit of form validate and if fields are not empty move forward
                            if (_formKey.currentState!.validate()) {
                              // call login method
                              User? user = await login(email: emailController.text, password: passwordController.text);
                              if(user !=null){
                                emailController.text ='';
                                passwordController.text ='';
                                // navigating to home screen
                            Navigator.pushNamed(
                                      context,
                                      '/home',
                                    );
                              } else{
                                // if credentails are wrong make show invalid message flag true
                                showInvalidMsg.value = true;
                              }
                            
                            }
                          }, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 236,82,82),
                            shadowColor: Colors.transparent
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Center(
                              child: Text('Log In', 
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),),
                            ),
                          ))
                      ]),
                    ),
                  ),
                  // Show sign up for new user
                  Center(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(
                      text: 'Do not have an account? ',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color.fromARGB(255,137,139,140)),
                    ),
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromARGB(255,46,46,46))
                    ),
                  ],
                ),
              )),
                ],
              ),
            ),
          );
          } else{
            return(const Center(child: CircularProgressIndicator(),));
          }
        }
      )
      );
  }

  // Initialize firebase app
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebase = await Firebase.initializeApp();
    return firebase;
  }

  // Login method
  static Future<User?> login({required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      // Check credentials are valid or not
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    }catch(e){
      return user;
    }
    return user;
  }
}
