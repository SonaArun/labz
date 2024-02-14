import 'package:flutter/material.dart';

import 'index.dart';

class CourseCard extends StatelessWidget{
  final course;
  const CourseCard({Key? key, @required this.course}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      Image.network(course['image'],
                      width: MediaQuery.of(context).size.width *0.2,
                      height: 100,),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        alignment: Alignment.centerRight,
                        height: 100,
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           Text(course['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal,color: Color.fromARGB(255,46,46,46)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const SizedBox(height: 8),
                            Text(course['category'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color.fromARGB(255,137,139,140)),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                // get rating widget
                                StarRating(rating: course['rating']['rate'].toInt()),
                                Text(' (${course['rating']['rate']})',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color.fromARGB(255,137,139,140)),
                            ),
                                Text(' (${course['rating']['count']})',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color.fromARGB(255,137,139,140)),
                            ),
                            const Spacer(),
                            Text(course['price'] ==0?'Free': '\$${course['price'].round().toString()}',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal,color: Color.fromARGB(255,46,46,46)),
                            ),
                              ],
                            )
                          
                              ],
                            )],
                        ),
                      )
                    ]);
  }
  
}