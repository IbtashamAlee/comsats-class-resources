import 'package:class_resources/components/buttons.dart';
import 'package:class_resources/components/centered-appbar.dart';
import 'package:class_resources/components/empty-state.dart';
import 'package:class_resources/components/list-header.dart';
import 'package:class_resources/components/loader.dart';
import 'package:class_resources/components/reference-item.dart';
import 'package:class_resources/components/text-avatar.dart';
import 'package:class_resources/models/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  Widget getEmptyState() {
    return EmptyState(
      icon: Icons.library_books,
      text: "No course added",
      button: PrimaryFlatButton(
        child: Text("Add Courses"),
        onPressed: () {},
      ),
    );
  }

  Widget courseList(String name, String code, String teacher) {
    return ListTile(
      leading: TextAvatar(text: name),
      title: Text(name),
      subtitle: Text("$name - $teacher"),
      onTap: () {},
    );
  }

  Widget onError(error) {
    return Text('Error: $error');
  }

  Widget onLoaded(List<DocumentSnapshot> semesters) {
    List<Widget> children = [];
    for (var semester in semesters.reversed) {
      children.add(ListHeader(text: semester["name"]));
      for (DocumentReference course in semester["courses"]) {
        children.add(RefItem(ref: course));
      }
    }
    return ListView(children: children);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: ProfileModel(),
      child: ScopedModelDescendant<ProfileModel>(
        builder: (context, child, model) {
          return Scaffold(
            appBar: centeredAppBar(context, "Courses"),
            body: StreamBuilder(
              stream: model.getUserSemester(),
              builder: (builder, snapshot) {
                if (snapshot.hasError) {
                  return onError(snapshot.error);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Loader();
                } else {
                  return onLoaded(snapshot.data.documents);
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.edit),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}

// ListView(
//         children: <Widget>[
//           ListHeader(text: "Semester 03"),
//           courseList("Object Oriented Programming", "CSC241", "4(3, 1)"),
//           courseList("Digital Logic Design", "CSC241", "4(3, 1)"),
//           courseList("Statistics & Probability Theory", "CSC241", "4(3, 1)"),
//           courseList("Linear Algebra", "CSC241", "4(3, 1)"),
//           courseList("Modern Physics", "CSC241", "4(3, 1)"),
//           ListHeader(text: "Semester 02"),
//           courseList("Programming Fundamentals	", "CSC241", "4(3, 1)"),
//           courseList("Report Writing Skills", "CSC241", "4(3, 1)"),
//           courseList("Multivaribale Calculus", "CSC241", "4(3, 1)"),
//           courseList("Professional Practices for IT", "CSC241", "4(3, 1)"),
//           courseList("Discrete Structures", "CSC241", "4(3, 1)"),
//           courseList("Electricity, Magnetism & Optics", "CSC241", "4(3, 1)"),
//           ListHeader(text: "Semester 01"),
//           courseList("Introduction to ICT", "CSC241", "4(3, 1)"),
//           courseList("English Comprehension & Composition", "CSC241", "4(3, 1)"),
//           courseList("Islamic Studies", "CSC241", "4(3, 1)"),
//           courseList("Calculus & Analytics Geometery", "CSC241", "4(3, 1)"),
//           courseList("Applied Physics for Engineers", "CSC241", "4(3, 1)"),
//         ],
//       )
