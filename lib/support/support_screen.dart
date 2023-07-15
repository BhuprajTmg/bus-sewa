
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

_sendingMails() async {
  const url = 'tsaroj895@gmail.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_sendingSMS() async {
  const url = 'sms:9826770332';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL() async {
  const url = 'https://www.linkedin.com/in/bhupraj-tamang-7713a2227/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'could not launch $url';
  }
}

_launchURL2() async {
  const url = 'https://www.facebook.com/bhupraj.tamang';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'could not launch $url';
  }
}

_launchURL3() async {
  const url = 'https://github.com/BhuprajTmg/bus-sewa';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'could not launch $url';
  }
}

class support extends StatefulWidget {
  static const routeName = '/support';
  const support({Key key}) : super(key: key);

  @override
  _supportState createState() => _supportState();
}

class _supportState extends State<support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Support',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          width: double.infinity,
          color: Colors.white70,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Lottie.asset('assets/support.json', height: 200),
                Container(
                  height: 20.0,
                ),
                const Text(
                  'we are here to help you with any information and problems through our contact center.',
                  style: TextStyle(letterSpacing: 0.5, fontSize: 16),
                ),
                Container(
                  height: 10.0,
                ),

                const Text(
                  'Mail us',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Tsaroj895@gmail.com',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                // ignore: deprecated_member_use
                // FlatButton(
                //   child: Text(
                //     'Click Here',
                //     style: TextStyle(fontSize: 20),
                //   ),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: new BorderRadius.circular(18.0),
                //     side: BorderSide(color: Colors.black),
                //   ),
                //   padding: const EdgeInsets.all(15),
                //   color: Colors.purple[900],
                //   textColor: Colors.yellowAccent,
                //   onPressed: _sendingMails,
                // ),
                Container(
                  height: 20.0,
                ),
                const Text(
                  'Or Send SMS',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Tsaroj895@gmail.com',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // ignore: deprecated_member_use
                // FlatButton(
                //   child: Text(
                //     'Click Here',
                //     style: TextStyle(fontSize: 20),
                //   ),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: new BorderRadius.circular(18.0),
                //     side: BorderSide(color: Colors.black),
                //   ),
                //   padding: const EdgeInsets.all(15),
                //   color: Colors.purple[900],
                //   textColor: Colors.yellowAccent,
                //   onPressed: _sendingSMS,
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                const Text(
                  'Developers contact',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    const Text(
                      'Linkdin',
                      style: TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                    const SizedBox(
                      width: 230,
                    ),
                    // ignore: deprecated_member_use
                    Flexible(
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: FlatButton(
                          onPressed: _launchURL,
                          child: Image.asset(
                            'assets/linkedin.png',
                            height: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text(
                      'Facebook',
                      style: TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                    const SizedBox(
                      width: 200,
                    ),
                    // ignore: deprecated_member_use
                      Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: FlatButton(
                          onPressed: _launchURL2,
                          child: Image.asset(
                            'assets/facebook.png',
                            height: 22,
                          ),
                        ),
                      ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    const Text(
                      'github',
                      style: TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                    const SizedBox(
                      width: 233,
                    ),
                    // ignore: deprecated_member_use
                    Container(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: _launchURL3,
                        child: Image.asset(
                          'assets/github.png',
                          height: 22,
                        ),
                      ),
                    ),
                  ],
                ),
                //SizedBox(height: 10,),
                
              ],
            ),
          ),
        );
      }),
    );
  }
}
