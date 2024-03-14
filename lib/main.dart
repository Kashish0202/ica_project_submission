import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Auth_Exceptions.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  final myController = TextEditingController();
  final myController1 = TextEditingController();
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
                'Email: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
                width: 500,
                child:TextFormField(
                  controller: myController,
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
                  controller: myController1,
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
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: myController.text,
                    password: myController1.text,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    throw UserNotFoundAuthException();
                  } else if (e.code == 'wrong-password') {
                    throw WrongPasswordAuthException();
                  } else {
                    throw GenericAuthException();
                  }
                } catch (_) {
                  throw GenericAuthException();
                }
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
class _DetailsPageState extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String _address="";
  String _name="";
  String _email="";
  String _password="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value=="") {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value=="") {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value=="") {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value=="") {
                    return 'Please enter a password';
                  }
                  if (value!.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Now you can use _name, _email, _password for further processing
                    // For demonstration, we will just print them
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {

            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _DetailsPageState()),
              );
            },
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
             mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height:500,
                width:1000,
                child:Row(
                  children: <Widget>[
                    Image.asset(
                    'assets/images/image1.png',
                     height: 400,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class  CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  void _incrementCounter() {
    setState(() {
      _count++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_count > 0) {
        _count--;
       }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: _decrementCounter,
            ),
            Text(
              '$_count',
              style: TextStyle(fontSize: 20),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _incrementCounter,
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
    int a;
    int b;
    int c;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Wines'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(146, 104, 129, 1.0),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {

            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _DetailsPageState()),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 150,
            width: 2000,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/images/image2.jpg',
                  height: 150,
                  width: 75,
                ),
                const ElevatedButton(
                  onPressed:null,
                  child: Text(
                    'Sula Shiraz Cabernet 375 Ml ₹381',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color:Color.fromRGBO(146, 104, 129, 1.0)),
                  ),
                ),
                Text('',
                  style:TextStyle(fontSize: 200),
                ),
                Container(
                  width:200,
                  height:50,
                  child: CounterPage(),
                ),
                    ],
                  ),
                ),
          SizedBox(
            height: 150,
            width: 2000,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/image3.jpg',
                height: 150,
                width: 75,
              ),
              const ElevatedButton(
                onPressed: null,
                child: Text(
                  'FRATELLI CABERNET SAUVIGNON  ₹1000',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color:Color.fromRGBO(146, 104, 129, 1.0)),
                ),
              ),
              Text('',
                style:TextStyle(fontSize: 200),
              ),
              Container(
                width:200,
                height:50,
                child: CounterPage(),
              ),
            ],
          ),
        ),
          SizedBox(
            height: 150,
            width: 2000,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/image4.png',
                height: 150,
                width: 75,
              ),
              const ElevatedButton(
                onPressed: null,
                child: Text(
                  'Pinot Noir  ₹12,495',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color:Color.fromRGBO(146, 104, 129, 1.0)),
                ),
              ),
              Text('',
                style:TextStyle(fontSize: 200),
              ),
              Container(
                width:200,
                height:50,
                child: CounterPage(),
              ),
            ],
          ),
      ),
          Text(''),
          ElevatedButton(
            onPressed: () async {
              var db = FirebaseFirestore.instance;
              final order = <String, dynamic>{
                "Sula Shiraz Cabernet 375 Ml ₹381": ,
                "FRATELLI CABERNET SAUVIGNON  ₹1000": ,
                "Pinot Noir  ₹12,495":
              };

// Add a new document with a generated ID
              db.collection("users").add(user).then((DocumentReference doc) =>
                  print('DocumentSnapshot added with ID: ${doc.id}'));
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
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {

              },
            ),
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _DetailsPageState()),
                );
              },
            ),
          ],
    ),

        body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text('Your order',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Color.fromRGBO(146, 104, 129, 1.0)
          ),
          ),
          const Text('  ',
            style: TextStyle(
              fontSize: 300
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