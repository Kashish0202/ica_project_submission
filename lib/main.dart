import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wine seller app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(146, 104, 129, 1.0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: FractionalOffset.topCenter,
            padding: const EdgeInsets.all(0.0),
            margin: const EdgeInsets.all(0.0),
            child: const Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 100,color:Color.fromRGBO(146, 104, 129, 1.0)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Username: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
                width: 500,
                child:TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your email id',
                  ),
                ),
              ),
            ],
          ),
          const Text(
            '   ',
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Password: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
                width: 500,
                child:TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your Password',
                  ),
                ),
              ),
            ],
          ),
          const Text(
              '  ',
            style: TextStyle(fontSize: 30),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
              },
              child: const Text(
                'Submit'
              ),
          ),
        ],
      ),
    );
  }
}
class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Liquor'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(146, 104, 129, 1.0),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
             mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
              'assets/images/image1.png',
               height: 500,
               width: 250,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ThirdRoutes()),
                   );
                  },
                child: const Text(
                  'Wines',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 100,color:Color.fromRGBO(146, 104, 129, 1.0)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class ThirdRoutes extends StatelessWidget {
  const ThirdRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Wines'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(146, 104, 129, 1.0),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/image2.jpg',
                height: 100,
                width: 50,
              ),
              const ElevatedButton(
                onPressed: null,
                child: Text(
                  'Sula Shiraz Cabernet 375 Ml ₹381',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color:Color.fromRGBO(146, 104, 129, 1.0)),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/image3.jpg',
                height: 100,
                width: 50,
              ),
              const ElevatedButton(
                onPressed: null,
                child: Text(
                  'FRATELLI CABERNET SAUVIGNON  ₹1000',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color:Color.fromRGBO(146, 104, 129, 1.0)),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/image4.png',
                height: 100,
                width: 50,
              ),
              const ElevatedButton(
                onPressed: null,
                child: Text(
                  'Pinot Noir  ₹12,495',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color:Color.fromRGBO(146, 104, 129, 1.0)),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FourthRoute()),
              );
            },
            child: const Text('Submit your order'),
          ),
          const Text(
            '',
            style: TextStyle(fontSize: 10),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondRoute()),
              );
            },
            child: const Text('Go back!'),
          ),
        ],
      ),
    );
  }
}


class FourthRoute extends StatelessWidget {
  const FourthRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Your Cart'),
    foregroundColor: Colors.white,
    backgroundColor: const Color.fromRGBO(146, 104, 129, 1.0),
    ),

        body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text('Your order',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Color.fromRGBO(146, 104, 129, 1.0)
          ),
          ),
          Container(
            child: const Text('  ',
              style: TextStyle(
                fontSize: 300
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ThirdRoutes()),
              );
            },
            child: const Text('Go back!'),
          ),
        ],
      ),
    );
  }
}