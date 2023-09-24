
import 'package:flutter/material.dart';
import 'package:song_m_app/recently/recently%20model.dart';



class RecentlyScreen extends StatefulWidget {
  const RecentlyScreen({super.key});

  @override
  State<RecentlyScreen> createState() => _RecentlyScreenState();
}

class _RecentlyScreenState extends State<RecentlyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        // playlist4VN (2:68)
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 2,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/main_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
             
              
              Expanded(child: recentmod())
            ],
          )),
        ),
      ),
    );
  }
}

