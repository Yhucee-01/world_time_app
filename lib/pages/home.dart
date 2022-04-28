import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    } else {
      data = {
        'location': 'Lagos',
        'time': '',
        'flag': 'nigeria.png',
        'isDaytime': true
      };
    }
    //print(data);

    //set background image
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    // set background color
    var bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'flag': result['flag'],
                        'isDaytime': result['isDaytime'],
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 30.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ]),
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 70.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
