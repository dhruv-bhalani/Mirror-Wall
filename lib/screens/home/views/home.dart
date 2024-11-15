import 'package:flutter/material.dart';
import 'package:government_app/screens/home/views/home_provider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Homeprovider homeproviderW;
  late Homeprovider homeproviderR;
  @override
  void initState() {
    context.read<Homeprovider>().checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeproviderW = context.watch<Homeprovider>();
    homeproviderR = context.read<Homeprovider>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Home",
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: homeproviderR.webList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/web',
                  arguments: homeproviderR.webList[index]);
            },
            child: Card(
              shadowColor: Colors.black12,
              margin: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(homeproviderR.webList[index].icon),
                  const SizedBox(height: 10),
                  Text("${homeproviderR.webList[index].title}"),
                ],
              ),
            ),
          );
        },
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }
}
