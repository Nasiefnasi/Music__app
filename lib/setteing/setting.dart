

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:song_m_app/setteing/aboutme.dart';
import 'package:song_m_app/setteing/privacy.dart';
import 'package:song_m_app/setteing/termsandcondition.dart';

import 'package:share_plus/share_plus.dart';

class setting extends StatelessWidget {
  const setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        color: const Color.fromARGB(230, 24, 24, 24),
        // ignore: prefer_const_literals_to_create_immutables
        child: Column(children: [
          // const SizedBox(
          //   height: 30,
          // ),
          // const CircleAvatar(
          //   backgroundImage: AssetImage('assets/pexels-photo-3746156.webp'),
          //   radius: 80,
          // ),
          // c
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AboutScreen(),
            )),
            // tileColor: Color.fromARGB(255, 85, 82, 82),
            title: const Text(
              'About Playme',
              style: TextStyle(fontSize: 18, color: Colors.white38),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.white54,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TermsAndConditionScreen(),
                ));
              },

              // tileColor: Color.fromARGB(255, 85, 82, 82),
              title: const Text(
                'terms  and condition',
                style: TextStyle(fontSize: 18, color: Colors.white38),
              ),
              trailing: IconButton(
                  onPressed: () {
                    // Center(
                    //     child: Container(
                    //         height: 300,
                    //         width: 600,
                    //         child: SimpleDialog(
                    //           backgroundColor: Colors.white,
                    //           children: [],
                    //         )));
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white54,
                  ))),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PrivacyPolicyScreen(),
              ));
            },

            // tileColor: Color.fromARGB(255, 85, 82, 82),
            title: const Text(
              'privacy and policy',
              style: TextStyle(fontSize: 18, color: Colors.white38),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.white54,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () => Share.share('Welcome to M_app'),
            // tileColor: Color.fromARGB(255, 85, 82, 82),
            title: const Text(
              'share  playMe',
              style: TextStyle(fontSize: 18, color: Colors.white38),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.white54,
            ),
          ),
       
        ]),
      ),
    );
  }
}

