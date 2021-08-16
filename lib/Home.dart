import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/EditMovie.dart';
import 'package:movieapp/EditMovieItem.dart';
import 'package:movieapp/Login.dart';
import 'package:movieapp/Movie.dart';
import 'package:movieapp/providers/database_helper.dart';
class MovieItem {
  final int id;
  final String image;
  final String name;
  final int rating;
  final releaseDate;
  final description;
  MovieItem(this.id,this.image,this.name,this.rating,this.releaseDate,this.description);
}
final List<String> imgList = [
  'https://wp.stanforddaily.com/wp-content/uploads/2020/10/chicago-poster.jpg',
  'https://images.thequint.com/thequint/2019-12/b63e6b4a-51d1-4895-bde0-a06ef43c0973/0_6U_Vertical_Main_RGB_US.jpg',
  'https://images.radio.com/aiu-media/toalltheboys-c4379883-35fb-452a-a8a7-7bc0d9ee035c.jpg',
  'https://cdn.mos.cms.futurecdn.net/ngNmNpMtMves8S8wT3aYwH-1200-80.png',
  'https://imgcacheblog.instube.com/2019/10/Joker-Hollywood-Movie-Download-InsTube.jpg'
];
final List<MovieItem> movies = [
  MovieItem(1,'https://wp.stanforddaily.com/wp-content/uploads/2020/10/chicago-poster.jpg', 'The Trial of the Chicago', 3,'30 September 2020','The film is based on the infamous 1969 trial of seven defendants charged by the federal government with conspiracy and more, arising from the countercultural protests in Chicago at the 1968 Democratic National Convention. The trial transfixed the nation and sparked a conversation about mayhem intended to undermine the U.S. government.'),
  MovieItem(2,'https://images.thequint.com/thequint/2019-12/b63e6b4a-51d1-4895-bde0-a06ef43c0973/0_6U_Vertical_Main_RGB_US.jpg', '6 Underground', 3,'13 December 2019','Six individuals from all around the globe, each the very best at what they do, have been chosen not only for their skill, but for a unique desire to delete their pasts to change the future.'),
  MovieItem(3,'https://images.radio.com/aiu-media/toalltheboys-c4379883-35fb-452a-a8a7-7bc0d9ee035c.jpg', 'To All the Boys: Always', 3,'12 February 2021','Senior year of high school takes center stage as Lara Jean returns from a family trip to Korea and considers her college plans -- with and without Peter.'),
  MovieItem(4,'https://cdn.mos.cms.futurecdn.net/ngNmNpMtMves8S8wT3aYwH-1200-80.png', 'Enola Holmes', 3,'23 September 2020','While searching for her missing mother, intrepid teen Enola Holmes uses her sleuthing skills to outsmart big brother Sherlock and help a runaway lord.'),
  MovieItem(5,'https://imgcacheblog.instube.com/2019/10/Joker-Hollywood-Movie-Download-InsTube.jpg', 'Joker',3,'2 October 2019','Forever alone in a crowd, failed comedian Arthur Fleck seeks connection as he walks the streets of Gotham City. Arthur wears two masks -- the one he paints for his day job as a clown, and the guise he projects in a futile attempt to feel like hes part of the world around him. Isolated, bullied and disregarded by society, Fleck begins a slow descent into madness as he transforms into the criminal mastermind known as the Joker.'),
];
List<MovieItem> moviesTemp =[];
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> imageSliders = imgList
      .map((item) => Container(
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item, fit: BoxFit.cover, width: 1200.0,height: 1500,),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    movies[imgList.indexOf(item)].name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )),
    ),
  ))
      .toList();

  void queryData() async {
    List<Map<String,dynamic>> queryRows = await DatabaseHelper.instance.queryAll();
    print("Start");
    moviesTemp = [];
    print(queryRows[0]['ReleaseDate']);
    for(int i = 0;i < queryRows.length;i++){
      if(queryRows[i] != null){
        MovieItem item = MovieItem(queryRows[i]['_id'],queryRows[i]['Image'], queryRows[i]['Name'], queryRows[i]['Rating'], queryRows[i]['ReleaseDate'], queryRows[i]['Description']);
        setState(() {
            moviesTemp.add(item);
          });
      }
    }
  }
  void delete(int id) async {
    await DatabaseHelper.instance.delete(id);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    queryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text("Discover",
              style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(223,27,71, 0.8),
                  fontSize: 26.0
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text("Watch Trending Movies",
                style: GoogleFonts.raleway(
                  letterSpacing: 0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 16.0
                ),),
            ),
            SizedBox(height: 15,),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2,
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 12.0,top: 12),
              child: Text("Movies",
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(223,27,71, 0.8),
                  fontSize: 24.0
                ),
              ),
            ),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: moviesTemp.length,
                  itemBuilder: (BuildContext context,int index){
                    return Padding(
                      padding: const EdgeInsets.only(left: 12.0,bottom: 3),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Movie(moviesTemp[index])));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.memory(base64Decode(moviesTemp[index].image),height: 100,width: 130,),
                                  // child: Image.network(
                                  //   movies[index].image,
                                  //   height: 100.0,
                                  //   width: 130.0,
                                  // ),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(height: 5,),
                                        Text(moviesTemp[index].name,style: GoogleFonts.raleway(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                            fontSize: 16.0
                                        ),),
                                        Container(
                                          width: 30,
                                          child: IconButton(icon: Icon(Icons.delete,size: 22,color: Color.fromRGBO(223,27,71, 0.8),), onPressed: () async {
                                            setState(() {
                                              print(moviesTemp[index].id);
                                              delete(moviesTemp[index].id);
                                              moviesTemp.removeAt(index);
                                            });
                                          }),
                                        ),
                                        IconButton(icon: Icon(Icons.edit,size: 22,color: Color.fromRGBO(223,27,71, 0.8),), onPressed: () async {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditMovieItem(moviesTemp[index])));
                                        })
                                      ],
                                    ),

                                    Text(moviesTemp[index].releaseDate,style: GoogleFonts.raleway(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black45,
                                        fontSize: 16.0
                                    ),),
                                    SizedBox(height: 5,),
                                    Row(
                                        children: [
                                          Icon(Icons.star,size: 20,color: Colors.amber),
                                          Icon(Icons.star,size: 20,color: Colors.amber),
                                          Icon(Icons.star,size: 20,color: Colors.amber),
                                          Icon(Icons.star,size: 20,color: Colors.black12),
                                          Icon(Icons.star,size: 20,color: Colors.black12),
                                        ]
                                    )
                                  ],)

                              ]
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),

          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(223,27,71, 1),
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditMovie()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 80,
          child: Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(onPressed: (){

                  },minWidth: 60,
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.dashboard,
                        color: Color.fromRGBO(223,27,71, 0.8),
                      ),
                      Text('Home',style: TextStyle(
                        color: Color.fromRGBO(223,27,71, 0.8),
                      ),)
                    ],
                  ),),
                  MaterialButton(onPressed: (){},minWidth: 40,child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.movie,
                        color: Colors.black45,
                      ),
                      Text('Movies',style: TextStyle(color: Colors.black45),),
                    ],
                  ),),
                  SizedBox(width: 50,),
                  MaterialButton(onPressed: (){},minWidth: 40,child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.black45,
                      ),
                      Text('Settings',style: TextStyle(color: Colors.black45),),
                    ],
                  ),),
                  MaterialButton(onPressed: (){},minWidth: 40,child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_box_rounded,
                        color: Colors.black45,
                      ),
                      Text('Account',style: TextStyle(color: Colors.black45),),
                    ],
                  ),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
