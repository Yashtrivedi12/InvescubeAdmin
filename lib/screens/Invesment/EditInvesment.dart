import 'dart:convert';

import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:invescube_admin/Model/tradingModel.dart';
import 'package:invescube_admin/main.dart';
import 'package:invescube_admin/screens/Invesment/invesmentScreen.dart';
import 'package:invescube_admin/screens/Trading/addTradingScreen.dart';

class EditInvestmentForm extends StatefulWidget {
  final Data rowData;
  final String id;

  EditInvestmentForm({required this.rowData, required this.id});
  @override
  _EditInvestmentFormState createState() => _EditInvestmentFormState();
}

class _EditInvestmentFormState extends State<EditInvestmentForm> {
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>>? _dropdownItems;
  String? _selectedType;
  bool _isLoading = true;

  String? id;
  String? mainType;
  late TextEditingController stockName;
  late TextEditingController addDate;
  late TextEditingController addTime;
  late TextEditingController entry;
  late TextEditingController cmp;
  late TextEditingController target1Price;
  late TextEditingController target2Price;
  late TextEditingController target3Price;
  String? _selectedTarget1;
  String? _selectedTarget2;
  String? _selectedTarget3;
  String? _selectedStopLoss;

  late TextEditingController stopLossPrice;

  late TextEditingController desc1;
  late TextEditingController desc2;
  String? selectedName;
  String? selectedSellBuy;

  @override
  void initState() {
    super.initState();
    _fetchDropdownData();

    selectedName = widget.rowData.mainType;
    selectedSellBuy = widget.rowData.type;

    stockName = TextEditingController(text: widget.rowData.name);
    addDate = TextEditingController(text: widget.rowData.date);
    addTime = TextEditingController(text: widget.rowData.time);
    entry = TextEditingController(text: widget.rowData.entry);
    cmp = TextEditingController(text: widget.rowData.cmp);
    target1Price = TextEditingController(text: widget.rowData.target);
    target2Price = TextEditingController(text: widget.rowData.target1);
    target3Price = TextEditingController(text: widget.rowData.target2);
    _selectedTarget1 = widget.rowData.targetStatus;
    print(_selectedTarget1);
    _selectedTarget2 = widget.rowData.target1Status;
    _selectedTarget3 = widget.rowData.target2Status;
    _selectedStopLoss = widget.rowData.stoplessStatus;
    desc1 = TextEditingController(text: widget.rowData.des);
    desc2 = TextEditingController(text: widget.rowData.des1);
    stopLossPrice = TextEditingController(text: widget.rowData.stoploss);

    _assignCurrentDateTime();
  }

  @override
  void dispose() {
    stockName.dispose();
    addDate.dispose();
    addTime.dispose();
    entry.dispose();
    cmp.dispose();
    target1Price.dispose();
    target2Price.dispose();
    target3Price.dispose();
    stopLossPrice.dispose();
    desc1.dispose();
    desc2.dispose();
    super.dispose();
  }

  void _assignCurrentDateTime() {
    // Assign current date
    final currentDate = DateTime.now();
    addDate.text = DateFormat('dd-MM-yyyy').format(currentDate);

    // Assign current time
    final currentTime = TimeOfDay.now();
    final formattedTime =
        '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}';
    addTime.text = formattedTime;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        addDate.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final String formattedTime =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00';
      setState(() {
        addTime.text = formattedTime;
      });
      print(addTime);
    }
  }

  InputDecoration _inputDecoration(String labelText, String hintText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  Future<void> _updateForm() async {
    const url = 'https://admin.invescube.com/admin_api/update_investment.php';
    final headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    request.fields['id'] = widget.id;

    request.fields['sname'] = stockName.text;
    request.fields['name'] = selectedName.toString();
    request.fields['type'] = selectedSellBuy.toString();
    request.fields['date'] = addDate.text;
    request.fields['time'] = addTime.text;
    request.fields['entry'] = entry.text;
    request.fields['t_price'] = target1Price.text;
    request.fields['t1_price'] = target2Price.text;
    request.fields['t2_price'] = target3Price.text;
    request.fields['stoploss'] = stopLossPrice.text;
    request.fields['t_status'] = _selectedTarget1.toString();
    request.fields['t1_status'] = _selectedTarget2.toString();
    request.fields['t2_status'] = _selectedTarget3.toString();

    request.fields['stoploss1'] = _selectedStopLoss.toString();
    request.fields['cmp'] = cmp.text;
    request.fields['des'] = desc1.text;
    request.fields['des1'] = desc2.text;

    print('id: ${widget.id}');
    print('sname: ${stockName.text}');
    print('name: ${selectedName.toString()}');
    print('type: ${selectedSellBuy.toString()}');
    print('date: ${addDate.text}');
    print('time: ${addTime.text}');
    print('entry: ${entry.text}');
    print('t1_price: ${target1Price.text}');
    print('t2_price: ${target2Price.text}');
    print('t3_price: ${target3Price.text}');
    print('stoploss: ${stopLossPrice.text}');
    print('t1_status: ${_selectedTarget1.toString()}');
    print('t2_status: ${_selectedTarget2.toString()}');
    print('t3_status: ${_selectedTarget3.toString()}');
    print('stoploss1: ${_selectedStopLoss.toString()}');
    print('cmp: ${cmp.text}');
    print('des: ${desc1.text}');
    print('des1: ${desc2.text}');

    var response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Investment Updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      // If the server returns a 200 OK response, handle success
      print('Investment Updated successfully');
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InvestmentTableView()),
      );
      // Handle success accordingly, such as showing a message or navigating back
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to add investment');
    }
  }

  Future<void> _fetchDropdownData() async {
    final url = Uri.parse(
        'https://admin.invescube.com/admin_api/show_investment_cat.php');
    final headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

    try {
      final response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        _dropdownItems = jsonData.map((item) {
          return DropdownMenuItem<String>(
            value: item['id'],
            child: Text(item['name']),
          );
        }).toList();

        setState(() {
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load dropdown data');
      }
    } catch (e) {
      print('Error fetching dropdown data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // _selectTime(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Trading Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                EasyAutocomplete(
                  progressIndicatorBuilder: const CircularProgressIndicator(),
                  debounceDuration: const Duration(seconds: 1),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the stock name';
                    }
                    return null;
                  },
                  controller: stockName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'stock name',
                  ),
                  asyncSuggestions: (query) async {
                    if (query.isEmpty) return [];
                    try {
                      List<Symbol> symbols =
                          await SymbolService.searchSymbols(query);
                      return symbols.map((symbol) => symbol.name).toList();
                    } catch (e) {
                      print('Error fetching symbols: $e');
                      return [];
                    }
                  },
                  onChanged: (value) {
                    print('onChanged value: $value');
                  },
                  onSubmitted: (value) {
                    print('onSubmitted value: $value');
                  },
                ),

                const SizedBox(height: 10),
                TextFormField(
                  controller: addDate,
                  readOnly: true,
                  decoration: _inputDecoration('Add Date', 'Pick a date'),
                  onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please pick a date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: addTime,
                  readOnly: true,
                  decoration: _inputDecoration('Add Time', 'Pick a time'),
                  onTap: () => _selectTime(context),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please pick a time';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: cmp,
                  decoration: _inputDecoration('CMP', 'Enter CMP value'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter CMP value';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  'Target 1 Details',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: 'Target 1',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: target1Price,
                  decoration: _inputDecoration(
                      'Target 1 Price', 'Enter target 1 price'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter target 1 price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  decoration: _inputDecoration(
                      'Target Status 1', 'Select Target Status 1'),
                  value: _selectedTarget1,
                  hint: const Text('Select Target Status 1'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTarget1 = newValue;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: '0',
                      child: Text('0'),
                    ),
                    DropdownMenuItem(
                      value: '1',
                      child: Text('1'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Target 2 Details',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: 'Target 2',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: target2Price,
                  decoration: _inputDecoration(
                      'Target 2 Price', 'Enter target 2 price'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter target 2 price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  decoration: _inputDecoration(
                      'Target Status 2', 'Select Target Status 2'),
                  value: _selectedTarget2,
                  hint: const Text('Select Target Status 2'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTarget2 = newValue;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: '0',
                      child: Text('0'),
                    ),
                    DropdownMenuItem(
                      value: '1',
                      child: Text('1'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Target 3 Details',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: 'Target 3',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: target3Price,
                  decoration: _inputDecoration(
                      'Target 3 Price', 'Enter target 3 price'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter target 3 price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // TextFormField(
                //   keyboardType: TextInputType.number,
                //   controller: target3Status,
                //   decoration: _inputDecoration(
                //       'Target 3 Status', 'Enter target 3 status'),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter target 3 status';
                //     }
                //     return null;
                //   },
                // ),
                DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  decoration: _inputDecoration(
                      'Target Status 3', 'Select Target Status 3'),
                  value: _selectedTarget3,
                  hint: const Text('Select Target Status 3'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTarget3 = newValue;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: '0',
                      child: Text('0'),
                    ),
                    DropdownMenuItem(
                      value: '1',
                      child: Text('1'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: stopLossPrice,
                  decoration: _inputDecoration(
                      'Stop Loss Price', 'Enter stop loss price'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter stop loss price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // TextFormField(
                //   keyboardType: TextInputType.number,
                //   controller: stopLossStatus,
                //   decoration: _inputDecoration(
                //       'Stop Loss Status', 'Enter stop loss status'),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter stop loss status';
                //     }
                //     return null;
                //   },
                // ),
                DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  decoration: _inputDecoration(
                      'Stop Loss Status', 'Select Stop Loss Status'),
                  value: _selectedStopLoss,
                  hint: const Text('Select Stop Loss Status'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStopLoss = newValue;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: '0',
                      child: Text('0'),
                    ),
                    DropdownMenuItem(
                      value: '1',
                      child: Text('1'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: desc1,
                  decoration:
                      _inputDecoration('Description 1', 'Enter description 1'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter description 1';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: desc2,
                  decoration:
                      _inputDecoration('Description 2', 'Enter description 2'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter description 2';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 45,
                          width: 90,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                backgroundColor:
                                    const Color.fromARGB(255, 110, 29, 203),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // _submitForm();
                                  _updateForm();
                                }
                              },
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 45,
                          width: 110,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  stockName.clear();
                                  addDate.clear();
                                  addTime.clear();
                                  entry.clear();
                                  cmp.clear();
                                  target1Price.clear();

                                  target2Price.clear();

                                  target3Price.clear();

                                  stopLossPrice.clear();

                                  desc1.clear();
                                  desc2.clear();
                                });
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
