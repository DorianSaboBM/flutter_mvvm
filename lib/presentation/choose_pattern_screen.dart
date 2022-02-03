import 'package:flutter/material.dart';
import 'package:mvvm_flutter/routes_manager.dart';

class ChoosePatterScreen extends StatefulWidget {
  ChoosePatterScreen({Key? key}) : super(key: key);

  @override
  State<ChoosePatterScreen> createState() => _ChoosePatterScreenState();
}

class _ChoosePatterScreenState extends State<ChoosePatterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Pattern"),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(Routes.streamPatter),
              child: Text('Stream Builder'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(Routes.providerPatter),
              child: Text('Provider'),
            ),
          ],
        ),
      ),
    );
  }
}
