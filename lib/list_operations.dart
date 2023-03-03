import 'package:first_project_fetch_api/models/Operation.dart';
import 'package:first_project_fetch_api/models/response_dto.dart';
import 'package:first_project_fetch_api/services/operation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListOfOperations extends StatefulWidget {
  const ListOfOperations({Key? key, required this.walletRef}) : super(key: key);
  final String walletRef;
  @override
  State<ListOfOperations> createState() => _ListOfOperationsState(walletRef);
}

class _ListOfOperationsState extends State<ListOfOperations> {
  late Future<ResponseDto> futureOperation;
  String walletRef;
  _ListOfOperationsState(this.walletRef);
  @override
  void initState() {
    super.initState();
    futureOperation = fetchOperation(walletRef);
  }
  final _formKey = GlobalKey<FormState>();
  TextEditingController amount = TextEditingController();
  Operation operation = new Operation(operationType: "", amount: 0, dateTransaction: "",walletRef: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text(walletRef)
                ],
              ),
            ),

            FutureBuilder<ResponseDto>(
              future: futureOperation,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Iterable operationIterable = snapshot.data!.data;
                  List<Operation> operations = List<Operation>.from(
                      operationIterable.map((model) => Operation.fromJson(model)));
                  return Expanded(
                    child: Container(
                      child: GridView.count(
                        childAspectRatio: 3.0,
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount: 1,
                        mainAxisSpacing: 10,
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(operations.length, (index) {
                          return Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "Type operation :"+ operations[index].operationType,
                                            style: TextStyle(
                                                color: operations[index].operationType == "WITHDRAW" ?
                                                    Colors.red : Colors.green
                                            ),
                                          ),

                                          Text(
                                            "Date operation :"+ operations[index].dateTransaction.toString(),
                                          ),

                                          Text(
                                            "Amount :"+ operations[index].amount.toString(),
                                          ),

                                        ],
                                      )),
                                ),
                              ));
                        }),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),



            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                     ElevatedButton(
                       style: ButtonStyle(
                           backgroundColor: MaterialStatePropertyAll(Colors.green)
                       ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      right: -40.0,
                                      top: -40.0,
                                      child: InkResponse(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: CircleAvatar(
                                          child: Icon(Icons.close),
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                                              ],
                                              decoration: InputDecoration(
                                                hintText: "Enter your amount"
                                              ),
                                              controller: amount,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              child: Text("save"),
                                              onPressed: () {
                                                operation.amount = double.parse(amount.text);
                                                operation.operationType = "DEPOSIT";
                                                operation.walletRef = walletRef;
                                                if (_formKey.currentState!.validate()) {
                                                  _formKey.currentState!.save();
                                                }
                                                addOperation(operation);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Text("Deposit"),
                    ),



                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.redAccent)
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Stack(
                                children: <Widget>[
                                  Positioned(
                                    right: -40.0,
                                    top: -40.0,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: CircleAvatar(
                                        child: Icon(Icons.close),
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                                            ],
                                            controller: amount,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            child: Text("save"),
                                            onPressed: () {
                                              operation.amount = double.parse(amount.text);
                                              operation.operationType = "WITHDRAW";
                                              if (_formKey.currentState!.validate()) {
                                                _formKey.currentState!.save();
                                              }
                                              addOperation(operation);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Text("WITHDRAW"),
                  ),
                ],
              ),
            )




          ],
        ),
      ),
    );
  }
}
