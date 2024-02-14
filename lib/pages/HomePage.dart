import 'package:flutter/material.dart';
import 'package:xo_game/pages/GamePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 0.03 * size.height,
          ),
          Container(
            height: 0.55 * size.height,
            width: size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/texture.png"),
                    fit: BoxFit.fill)),
          ),
          SizedBox(
            height: 0.03 * size.height,
          ),
          Container(
            height: 0.18 * size.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/x.png"),
                Image.asset("assets/images/o.png"),
              ],
            ),
          ),
          SizedBox(
            height: 0.03 * size.height,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => TicTacToeGame()));
            },
            child: Container(
              height: 0.07 * size.height,
              width: 0.8 * size.width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 212, 41),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  "Play now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
