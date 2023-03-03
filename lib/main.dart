import 'dart:async';
import 'package:first_project_fetch_api/models/wallet.dart';
import 'package:first_project_fetch_api/services/wallet_service.dart';
import 'package:flutter/material.dart';

import 'list_operations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Wallet>> futureWallet;

  @override
  void initState() {
    super.initState();
    futureWallet = fetchWallet();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Wallet>>(
            future: futureWallet,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Wallet>? wallets = snapshot.data!;
                return GridView.count(
                  childAspectRatio: 3.0,
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(wallets.length, (index) {
                    return Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return ListOfOperations(walletRef: wallets[index].reference);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Text(wallets[index].balance.toString()),
                            ),
                          ),
                        ));
                  }),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
