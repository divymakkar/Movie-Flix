import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/EditMovie.dart';
import 'package:movieapp/Home.dart';
class Movie extends StatefulWidget {
  final MovieItem item;
  Movie(this.item);
  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.5,
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: Container(
                          height: size.height * 0.5 - 50,
                          child: FittedBox(
                            child: Image.memory(base64Decode(widget.item.image)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                        width: size.width * 0.6,
                        height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topLeft: Radius.circular(50),
                            ),
                            boxShadow: [BoxShadow(offset: Offset(0,5),blurRadius: 50,color: Color(0xFF12153D).withOpacity(0.2),)],
                          ),
                        child: Row(
                          children: [

                            SizedBox(width: 15,),
                            Icon(Icons.star,color: Colors.amber,size: 32,),
                            SizedBox(width: 10,),
                            Text('3/5',style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 18.0
                            ),),
                            SizedBox(width: 15,),
                            Text('IMDB Rating',style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 18.0
                            ),)
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.item.name,
                        style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(223,27,71, 0.8),
                            fontSize: 24.0
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color:Color.fromRGBO(223,27,71, 0.8),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: IconButton(color:Colors.white,iconSize: 30,onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditMovie()));
                          }, icon: Icon(Icons.add))),
                    ],
                  ),
                ),
                Text(widget.item.releaseDate,
                  style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 20.0
                  ),
                ),
                SizedBox(height:20),
                Text(widget.item.description,
                  style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                      fontSize: 18.0
                  ),
                ),
                SizedBox(height: 30,),
                Center(
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {

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
                            "Watch Movie",
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
              ],
            ),
          ),
        ),
    );
  }
}
