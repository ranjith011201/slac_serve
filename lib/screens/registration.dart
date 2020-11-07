import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../helpers/helpers.dart';
import '../providers/user.dart';
import 'package:provider/provider.dart';
import '../screens/homeFeed.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:path/path.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // final AuthService _auth = AuthService();
  final _key = GlobalKey<ScaffoldState>();

  bool loading = false;
  // final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File _image;
  var x;

  pickImageFromGallery(context) async {
    Navigator.pop(context);
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  captureImageWithCamera(context) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, maxHeight: 680, maxWidth: 970);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  takeImage(nContext) {
    return showDialog(
        context: nContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("New Post"),
            children: <Widget>[
              SimpleDialogOption(
                child: Text(
                  "Capture Image with Camera",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => captureImageWithCamera(nContext),
              ),
              SimpleDialogOption(
                child: Text(
                  "Select Image from Gallery",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => pickImageFromGallery(nContext),
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);

    Future uploadPic(BuildContext context) async {
      Reference firebaseStorageReference =
          FirebaseStorage.instance.ref().child(_image.path);

      UploadTask uploadTask = firebaseStorageReference.putFile(_image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      authProvider.imageUrl =
          (await taskSnapshot.ref.getDownloadURL()).toString();
      setState(() {
        print("Profile Picture uploaded");
        // Scaffold.of(context)
        //     .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 50),
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 60,
                            child: ClipOval(
                              child: new SizedBox(
                                width: 180,
                                height: 180,
                                child: (_image != null)
                                    ? Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        'assets/profile1.png',
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 60),
                          child: IconButton(
                            color: Colors.amber,
                            icon: Icon(Icons.camera_alt, size: 30),
                            onPressed: () {
                              takeImage(context);
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.tag_faces,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 3),
                        Expanded(
                          child: TextFormField(
                            controller: authProvider.name,
                            validator: (val) {
                              return val.isEmpty
                                  ? 'Please provide your name'
                                  : null;
                            },
                            // onChanged: (val) {
                            //   setState(() => name = val);
                            // },
                            style: TextStyle(color: Colors.amber),
                            decoration: InputDecoration(
                              hintText: "User Name",
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                              filled: true,
                              fillColor: Color(0xff161d27).withOpacity(0.9),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.amber)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.amber)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(children: <Widget>[
                      Icon(
                        Icons.alternate_email,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 3),
                      Expanded(
                        child: TextFormField(
                          controller: authProvider.email,
                          validator: (val) {
                            return RegExp(
                                        r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)")
                                    .hasMatch(val)
                                ? null
                                : "Please provide a valid Email";
                          },
                          // onChanged: (val) {
                          //   setState(() => email = val);
                          // },
                          style: TextStyle(color: Colors.amber),
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey.shade700),
                            filled: true,
                            fillColor: Color(0xff161d27).withOpacity(0.9),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.amber)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.amber)),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: 10),
                    Row(children: <Widget>[
                      Icon(
                        Icons.lock,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 3),
                      Expanded(
                        child: TextFormField(
                          controller: authProvider.password,
                          obscureText: true,
                          validator: (val) {
                            return val.isEmpty || val.length <= 6
                                ? 'Please provide a valid password with atleast 6 characters'
                                : null;
                          },
                          // onChanged: (val) {
                          //   setState(() => password = val);
                          // },
                          style: TextStyle(color: Colors.amber),
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey.shade700),
                            filled: true,
                            fillColor: Color(0xff161d27).withOpacity(0.9),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.amber)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.amber)),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 3),
                        Expanded(
                          child: TextFormField(
                            controller: authProvider.address,
                            validator: (val) {
                              return val.isEmpty
                                  ? 'Please provide your Address'
                                  : null;
                            },
                            // onChanged: (val) {
                            //   setState(() => name = val);
                            // },
                            style: TextStyle(color: Colors.amber),
                            decoration: InputDecoration(
                              hintText: "Address",
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                              filled: true,
                              fillColor: Color(0xff161d27).withOpacity(0.9),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.amber)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.amber)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.face,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 3),
                        Expanded(
                          child: TextFormField(
                            controller: authProvider.pinCode,
                            validator: (val) {
                              return val.isEmpty || val.length == 6
                                  ? 'Please provide a valid PinCode'
                                  : null;
                            },
                            // onChanged: (val) {
                            //   setState(() => name = val);
                            // },
                            style: TextStyle(color: Colors.amber),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Pin Code",
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                              filled: true,
                              fillColor: Color(0xff161d27).withOpacity(0.9),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.amber)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.amber)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 40, right: 40),
                      child: FlatButton(
                        onPressed: () async {
                          print("BTN CLICKED!!!!");
                          print("BTN CLICKED!!!!");
                          print("BTN CLICKED!!!!");
                          print("BTN CLICKED!!!!");
                          print("BTN CLICKED!!!!");
                          print("BTN CLICKED!!!!");

                          if (!await authProvider.signUp()) {
                            _key.currentState.showSnackBar(SnackBar(
                                content: Text("Resgistration failed!")));
                            return;
                          }
                          await uploadPic(context);
                          authProvider.clearController();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeFeed()),
                              ModalRoute.withName('HomeFeed'));
                          // changeScreenReplacement(context, Home());
                        },
                        color: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
