import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movieapp/providers/database_helper.dart';
import 'Home.dart';
class EditMovieItem extends StatefulWidget {
  final MovieItem item;
  EditMovieItem(this.item);
  @override
  _EditMovieItemState createState() => _EditMovieItemState();
}

class _EditMovieItemState extends State<EditMovieItem> {
  String name = '';
  String releaseDate = '';
  int rating = 3;
  String description = '';
  String _base64;
  File imageFile;
  final ImagePicker _picker = ImagePicker();
  Future getImage() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    imageFile = File(await ImagePicker().getImage(source: ImageSource.gallery).then((pickedFile) => pickedFile.path));
    print(imageFile);
    setState(() {
    });
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    name = widget.item.name;
    releaseDate = widget.item.releaseDate;
    rating = widget.item.rating;
    description = widget.item.description;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text("Edit Movie",
                style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(223,27,71, 0.8),
                    fontSize: 26.0
                ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text("Please fill in the details",
                style: GoogleFonts.raleway(
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 16.0
                ),),
            ),
            SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top:10,left: 15,right: 15),
                        child: TextFormField(
                          onChanged: (val){
                            setState(() {
                              name = val;
                            });
                          },
                          validator: (val){
                            if(val.isEmpty){
                              return 'Enter Movie Name';
                            }
                            else{
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(239,238,243, 0.8),
                            hintText: 'Enter Movie Name',
                            labelText: 'Movie Name',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        child: TextFormField(
                          onChanged: (val){
                            setState(() {
                              releaseDate = val;
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(239,238,243, 0.8),
                            hintText: 'Enter Release Year',
                            labelText: 'Release Year',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      SizedBox(height: 5,),
                      Container(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 3,
                          maxLines: 10,
                          onChanged: (val){
                            setState(() {
                              description = val;
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(239,238,243, 0.8),
                            hintText: 'Enter Description',
                            labelText: 'Description',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text("Enter Rating",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontSize: 17.0
                          ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20.0,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text("Select Image Poster",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontSize: 17.0
                          ),),
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){
                          getImage();
                          print(imageFile);
                        },
                        child: Container(
                          child: Center(
                            child: imageFile == null ? Container(
                              child: Center(child: Text('Select Image',style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black45,
                                  fontSize: 17.0
                              ),)),
                            ) : Container(height:300,child: Image.file(imageFile)),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Center(
                        child: Container(
                          height: 50.0,
                          child: RaisedButton(
                            onPressed: () async {
                              print(name);
                              final bytes = File(imageFile.path).readAsBytesSync();
                              _base64 = base64Encode(bytes);
                              int i = await DatabaseHelper.instance.insert({
                                DatabaseHelper.image : _base64,
                                DatabaseHelper.name : name,
                                DatabaseHelper.rating: rating,
                                DatabaseHelper.releaseDate : releaseDate,
                                DatabaseHelper.description : description
                              });
                              print('The inserted id is $i');
                              // await DatabaseHelper.instance.delete(2);
                              List<Map<String,dynamic>> queryRows = await DatabaseHelper.instance.queryAll();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [Color.fromRGBO(223,27,71, 0.8), Color.fromRGBO(206,11,56, 1)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Container(
                                constraints: BoxConstraints(maxWidth: 280.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Save Movie",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}