import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_table/model/text_widget_model.dart';
import 'package:time_table/view/course_screen/course_screen.dart';

class HomeScreenBodyWidget extends StatelessWidget {
  const HomeScreenBodyWidget({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('courses').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.blue,));
        }
        if (snapshot.hasError) {
          return Center(
            child: TextWidget(
              text: 'No courses available',
              color: Colors.white,
              size: screenSize.width / 16,
              fontFamily: '',
              weight: FontWeight.bold,
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: TextWidget(
              text: 'No courses available',
              color: Colors.white,
              size: screenSize.width / 16,
              fontFamily: '',
              weight: FontWeight.bold,
            ),
          );
        }

        final courses = snapshot.data!.docs;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width / 80),
          child: GridView.builder(
            padding: EdgeInsets.only(top: screenSize.height / 80),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: courses.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: screenSize.width / 25,
              mainAxisSpacing: screenSize.height / 40,
              childAspectRatio: 4 / 3,
            ),
            itemBuilder: (context, index) {
              final courseData = courses[index].data() as Map<String, dynamic>;
              final courseName = courseData['name'] ?? 'Unnamed Course';

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return CourseScreen(courseName: courseName,screenSize: screenSize,);
                  },));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenSize.width / 40),
                  ),
                  shadowColor: Colors.black54,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenSize.width / 40),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6a11cb), Color(0xFF2575fc)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width / 80),
                        child: TextWidget(
                          text: courseName,
                          color: Colors.white,
                          size: screenSize.width / 28,
                          fontFamily: '',
                          weight: FontWeight.bold,
                          maxline: true,
                          alignTextCenter: true,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
