
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:gallay_app/model/person.dart';
import 'package:gallay_app/network/network_api.dart';
import 'package:gallay_app/network/network_connectivity.dart';
import 'package:gallay_app/network/network_service.dart';
import 'package:gallay_app/util/app_colors.dart';
import 'package:gallay_app/util/app_string.dart';
import 'package:gallay_app/util/commom_component.dart';
import 'package:gallay_app/view/person_explorer.dart';

import 'cell.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallary Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'PinkVilla'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  List<Person> personList =[];
  bool _isLoading = true;
  bool _hasMore = true;
  Map _source = {ConnectivityResult.none: false};
  NetworkConnectivity _connectivity = NetworkConnectivity.instance;
  NetworkService  service ;
  bool isDataLoading;
  int pageNumber =0;

  @override
  void initState() {
    super.initState();
    service =NetworkService();
    _connectivity.initialise();
    _connectivity.myStream.listen((source)
    {
      setState(() => _source = source);
    });
   _loadData(AppString.BASE_URL+NetworkApi.API_PHOTO_GALLARY_FEED);
  }

  @override
  Widget build(BuildContext context) {
    String string="";
    switch (_source.keys.toList()[0])
    {
      case ConnectivityResult.none:
        string = "Offline";
        break;
      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        break;
      case ConnectivityResult.wifi:
        string = "WiFi: Online";
    }

    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonComponent.getAppBar(COLORS.APP_THEME_COLOR, "PinkVilla"),
      body: GridView.builder(
        shrinkWrap: true,
        itemCount: _hasMore ? personList.length + 1 : personList.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index)
        {
          if (index >= personList.length)
          {
             if (!_isLoading)
            {
              _loadData(AppString.BASE_URL+NetworkApi.API_PHOTO_GALLARY_FEED_BY_PAGE+pageNumber.toString());
            }
            return Center(
                           child: SizedBox(
                child: CircularProgressIndicator(),
                height: 24,
                width: 24,
              ),
            );
          }

          return GestureDetector(
            child: Cell(personList.elementAt(index)),
            onTap: () => gridClicked(context, personList.elementAt(index)),
          );
        },
      )
    );
  }


  void _loadData(String url)
  {
    _isLoading = true;
    service.loadData(url).then((value)
    {
      personList.addAll(value);
      pageNumber++;
      _isLoading =false;
      setState(()
      {

      });
    }
    );
  }
 void gridClicked(BuildContext context, Person elementAt)
  {
    print(elementAt.title);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PersonExplorer(url:AppString.BASE_URL+elementAt.path)),
    );

  }


}

