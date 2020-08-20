
import 'package:gallay_app/model/person.dart';
import 'dart:async';
import 'dart:convert';
import 'package:gallay_app/util/app_string.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class NetworkService{

  Future<List<Person>> loadData(String url) async {
    print(url);
    final response = await http.get(url);
    try {
      print(response.body);
      if (response.statusCode == 200)
      {
        List<Person> list = parsePostsForHome(response.body);
        print(list.length);
        return list;
      } else {
        throw Exception(AppString.INTERNET_ERROR);
      }
    } catch (e) {
      print(e);
    }
  }


   List<Person> parsePostsForHome(String responseBody)
  {
    List<Person> personList=[];
    Map nodes = jsonDecode(responseBody);
    List<dynamic> list = nodes["nodes"];
    for( int i =0;i<list.length;i++){
      Map d= list.elementAt(i);
      Person p = Person.fromJson(d["node"]);
      personList.add(p);
    }

return personList;
  }


}