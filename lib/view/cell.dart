import 'package:flutter/material.dart';
import 'package:gallay_app/model/person.dart';
import 'package:gallay_app/util/app_string.dart';

class Cell extends StatelessWidget {
  const Cell(this._person);
  @required
  final Person _person;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding:
          new EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0, top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(AppString.BASE_URL+_person.fieldPhotoImageSection,
                  alignment: Alignment.center,
                  fit: BoxFit.scaleDown),
                        ],
          ),
        ),
      ),
    );
  }
}