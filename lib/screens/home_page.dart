import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:httpscalls/models/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserDetails> userDetails = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            itemCount: userDetails.length,
            itemBuilder: (context, index) {
              return Container(
                height: 250,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getText(
                      index,
                      'ID: ',
                      userDetails[index].id.toString(),
                    ),
                    getText(
                      index,
                      'Name: ',
                      userDetails[index].name.toString(),
                    ),
                    getText(
                      index,
                      'Username: ',
                      userDetails[index].username.toString(),
                    ),
                    getText(
                      index,
                      'Email: ',
                      userDetails[index].email.toString(),
                    ),
                    getText(
                      index,
                      'Phone: ',
                      userDetails[index].phone.toString(),
                    ),
                    getText(
                      index,
                      'Website: ',
                      userDetails[index].website.toString(),
                    ),
                    getText(
                      index,
                      'Address: ',
                      '${userDetails[index].address.suite.toString()}, '
                          '${userDetails[index].address.street.toString()}, '
                          '${userDetails[index].address.city.toString()}, '
                          '${userDetails[index].address.zipcode.toString()}',
                    ),
                    getText(
                        index,
                        'Company: ',
                        '${userDetails[index].company.name.toString()}, '
                            '${userDetails[index].company.catchPhrase.toString()}, '
                            '${userDetails[index].company.bs.toString()}, '),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Text getText(int index, String fieldName, String content) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: fieldName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          TextSpan(
            text: content,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Future<List<UserDetails>> getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        userDetails.add(UserDetails.fromJson(index));
      }
      return userDetails;
    } else {
      return userDetails;
    }
  }
}
