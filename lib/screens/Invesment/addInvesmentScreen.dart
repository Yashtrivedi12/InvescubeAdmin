// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;

// // ignore: camel_case_types
// class addInvestmentScreen extends StatefulWidget {
//   const addInvestmentScreen({super.key});

//   @override
//   State<addInvestmentScreen> createState() => _addInvestmentScreenState();
// }

// // ignore: camel_case_types
// class _addInvestmentScreenState extends State<addInvestmentScreen> {
//   String? _selectedInvestmentValue;
//   final List<String> _InvestmentType = ['Short Term', 'Mid Term', 'Long Term'];
//   String? _selectedbuysellValue; // Change default value here
//   final List<String> _buysellType = ['Sell', 'Buy'];
//   String _response = '';
//   final TextEditingController stockName = TextEditingController();
//   final TextEditingController addDate = TextEditingController();
//   final TextEditingController addTime = TextEditingController();
//   final TextEditingController entry = TextEditingController();
//   final TextEditingController cmp = TextEditingController();
//   final TextEditingController target1Price = TextEditingController();
//   final TextEditingController target2Price = TextEditingController();
//   final TextEditingController target3Price = TextEditingController();
//   final TextEditingController target1Status = TextEditingController();
//   final TextEditingController target2Status = TextEditingController();
//   final TextEditingController target3Status = TextEditingController();
//   final TextEditingController stopLossPrice = TextEditingController();
//   final TextEditingController stopLossStatus = TextEditingController();
//   final TextEditingController desc1 =
//       TextEditingController(text: 'Remarks : Cash Intraday');
//   final TextEditingController desc2 =
//       TextEditingController(text: 'Update : Educational Purpose Only');

//   @override
//   void initState() {
//     super.initState();
//     // Set initial date to current date
//     addDate.text = DateTime.now().toString().substring(0, 10);
//     addTime.text = DateFormat('HH:mm:ss').format(DateTime.now());
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (pickedDate != null && pickedDate != DateTime.now()) {
//       setState(() {
//         String formattedDate = "${pickedDate.day.toString().padLeft(2, '0')} "
//             "${pickedDate.month.toString().padLeft(2, '0')} "
//             "${pickedDate.year.toString()}";
//         addDate.text = formattedDate;
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (pickedTime != null) {
//       setState(() {
//         final now = DateTime.now();
//         final selectedTime = DateTime(
//           now.year,
//           now.month,
//           now.day,
//           pickedTime.hour,
//           pickedTime.minute,
//         );
//         addTime.text = DateFormat('HH:mm:ss').format(selectedTime);
//       });
//     }
//   }

//   Future<void> _addInvestment() async {
//     const url = 'https://admin.invescube.com/admin_api/add_trading.php';
//     final headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

//     var request = http.MultipartRequest('POST', Uri.parse(url));

//     // Add headers
//     request.headers.addAll(headers);

//     // Add fields to the request

//     request.fields['sname'] =
//         stockName.text; // Assuming you use the same value as stockName
//     print(stockName);
//     request.fields['type'] = _selectedInvestmentValue ?? '';
//     print(_selectedInvestmentValue);
//     request.fields['date'] = addDate.text;
//     request.fields['time'] = addTime.text;
//     request.fields['entry'] =
//         '450-500'; // Assuming this value is fixed, replace as needed
//     request.fields['target_price'] =
//         target1Price.text; // Assuming target1Price is used for target_price
//     request.fields['target1_price'] = target1Price.text;
//     request.fields['target2_price'] = target2Price.text;
//     request.fields['stoploss_price'] = stopLossPrice.text;
//     request.fields['target_status'] =
//         target1Status.text; // Assuming target1Status is used for target_status
//     request.fields['target1_status'] = target1Status.text;
//     request.fields['target2_status'] = target2Status.text;
//     request.fields['stoploss_status'] = stopLossStatus.text;
//     request.fields['cmp'] =
//         'sdfsdf'; // Assuming this value is fixed, replace as needed
//     request.fields['des'] = desc1.text;
//     request.fields['des1'] = desc2.text;

//     // Send the request
//     var response = await request.send();

//     // Check the status code of the response
//     if (response.statusCode == 200) {
//       // If the server returns a 200 OK response, you can handle the success here
//       print('Investment added successfully');

//       // Fetch updated data after adding the investment
//       final updatedDataResponse = await http.get(
//         Uri.parse(url), // Assuming this endpoint returns the updated data
//         headers: headers,
//       );

//       if (updatedDataResponse.statusCode == 200) {
//         // If the updated data is fetched successfully, print it in the console
//         print('Updated data:');
//         setState(() {
//           _response =
//               updatedDataResponse.body; // Update the state with the response
//         });
//       } else {
//         // Handle the case where fetching updated data fails
//         throw Exception('Failed to fetch updated data');
//       }
//     } else {
//       // If the server returns an error response, throw an exception.
//       throw Exception('Failed to add investment');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     // double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Investment'),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           color: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Text(
//                 //   'Add Investment',
//                 //   style: TextStyle(
//                 //     color: Colors.grey[600],
//                 //     fontSize: 18,
//                 //     fontWeight: FontWeight.w500,
//                 //   ),
//                 // ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Select Category',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.grey[500],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10.0),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 0.5,
//                               blurRadius: 6,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: DropdownButton<String>(
//                           hint: const Text('Select Category'),
//                           icon: const Icon(Icons.arrow_drop_down),
//                           iconSize: 24,
//                           elevation: 16,
//                           style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                           ),
//                           underline: Container(
//                             height: 2,
//                             color: const Color.fromRGBO(124, 77, 255, 1),
//                           ),
//                           value: _selectedInvestmentValue,
//                           items: _InvestmentType.map((String value) {
//                             return DropdownMenuItem<String>(
//                               child: Text(value),
//                               value: value,
//                             );
//                           }).toList(),
//                           onChanged: (String? newvalue) {
//                             setState(() {
//                               _selectedInvestmentValue = newvalue!;
//                             });
//                           },
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         'Stock Name',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.grey[500],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       CustomTextField(
//                         controller: stockName,
//                         hintText: 'Stock Name',
//                         labelText: 'Stock Name',
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         'Sell / Buy',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.grey[500],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10.0),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 0.5,
//                               blurRadius: 6,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: DropdownButton<String>(
//                           hint: const Text('Select Category'),
//                           icon: const Icon(Icons.arrow_drop_down),
//                           iconSize: 24,
//                           elevation: 16,
//                           style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                           ),
//                           underline: Container(
//                             height: 2,
//                             color: const Color.fromRGBO(124, 77, 255, 1),
//                           ),
//                           value: _selectedbuysellValue,
//                           items: _buysellType.map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                           onChanged: (String? newvalue) {
//                             setState(() {
//                               _selectedbuysellValue = newvalue!;
//                             });
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         'Date',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.grey[500],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       GestureDetector(
//                         onTap: () => _selectDate(context),
//                         child: AbsorbPointer(
//                           child: TextFormField(
//                             controller: addDate,
//                             decoration: InputDecoration(
//                               hintText: 'Select Date',
//                               prefixIcon: const Icon(Icons.calendar_today),
//                               labelText: 'Date',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         'Time',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.grey[500],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       GestureDetector(
//                         onTap: () => _selectTime(context),
//                         child: AbsorbPointer(
//                           child: TextFormField(
//                             controller: addTime,
//                             decoration: InputDecoration(
//                               hintText: 'Select Time',
//                               prefixIcon: const Icon(Icons.access_time),
//                               labelText: 'Time',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: screenHeight * 0.32,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.indigo, width: 1)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Target 1',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.grey[500],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               TextFormField(
//                                 readOnly: true,
//                                 decoration: InputDecoration(
//                                     hintText: 'Target 1',
//                                     hintStyle: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.grey[600],
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0))),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               TextFormField(
//                                 keyboardType: TextInputType.number,
//                                 controller: target1Price,
//                                 decoration: InputDecoration(
//                                     hintText: 'Target Price',
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey[600],
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0))),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               TextFormField(
//                                 keyboardType: TextInputType.number,
//                                 controller: target1Status,
//                                 decoration: InputDecoration(
//                                     hintText: 'Target Status',
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey[600],
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0))),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: screenHeight * 0.32,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.indigo, width: 1)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Target 2',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.grey[500],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               TextFormField(
//                                 readOnly: true,
//                                 decoration: InputDecoration(
//                                     hintText: 'Target 2',
//                                     hintStyle: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.grey[600],
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0))),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               TextFormField(
//                                 keyboardType: TextInputType.number,
//                                 controller: target2Price,
//                                 decoration: InputDecoration(
//                                     hintText: 'Target Price',
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey[600],
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0))),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               TextFormField(
//                                 keyboardType: TextInputType.number,
//                                 controller: target2Status,
//                                 decoration: InputDecoration(
//                                     hintText: 'Target Status',
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey[600],
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0))),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: screenHeight * 0.32,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.indigo, width: 1)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Target 3',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.grey[500],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               TextFormField(
//                                 readOnly: true,
//                                 decoration: InputDecoration(
//                                     hintText: 'Target 3',
//                                     hintStyle: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.grey[600],
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0))),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               TextFormField(
//                                 controller: target3Price,
//                                 keyboardType: TextInputType.number,
//                                 decoration: InputDecoration(
//                                     hintText: 'Target Price',
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey[600],
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0))),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               TextFormField(
//                                 controller: target3Status,
//                                 keyboardType: TextInputType.number,
//                                 decoration: InputDecoration(
//                                     hintText: 'Target Status',
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey[600],
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0))),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: screenHeight * 0.24,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.indigo, width: 1)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Description',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.grey[500],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               TextFormField(
//                                 controller: desc1,
//                                 maxLines: 3,
//                                 decoration: InputDecoration(
//                                     hintText: 'Enter Description',
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey[600],
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0))),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: screenHeight * 0.24,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.indigo, width: 1)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Description 1',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.grey[500],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               TextFormField(
//                                 controller: desc2,
//                                 maxLines: 3,
//                                 decoration: InputDecoration(
//                                     hintText: 'Enter Description 1',
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey[600],
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0))),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: SizedBox(
//                           height: 45,
//                           width: 100,
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.0)),
//                                 backgroundColor:
//                                     const Color.fromARGB(255, 110, 29, 203),
//                               ),
//                               onPressed: _addInvestment,
//                               child: const Text(
//                                 'Add',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w500),
//                               )),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: SizedBox(
//                           height: 45,
//                           width: 110,
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.0)),
//                                 backgroundColor: Colors.red,
//                               ),
//                               onPressed: () {},
//                               child: const Text(
//                                 'Cancel',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w500),
//                               )),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     desc1.dispose();
//     desc2.dispose();
//     super.dispose();
//   }
// }

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final String labelText;
//   final bool obscureText;
//   final TextInputType keyboardType;
//   final BorderRadius borderRadius;

//   const CustomTextField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     required this.labelText,
//     this.obscureText = false,
//     this.keyboardType = TextInputType.text,
//     this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         hintText: hintText,
//         labelText: labelText,
//         hintStyle: TextStyle(color: Colors.grey[200]),
//         border: OutlineInputBorder(
//           borderRadius: borderRadius,
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:invescube_admin/main.dart';
import 'package:invescube_admin/screens/Invesment/invesmentScreen.dart';
import 'package:invescube_admin/screens/Trading/addTradingScreen.dart';

class InvestmentStockForm extends StatefulWidget {
  const InvestmentStockForm({super.key});

  @override
  _InvestmentStockFormState createState() => _InvestmentStockFormState();
}

class _InvestmentStockFormState extends State<InvestmentStockForm> {
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>>? _dropdownItems;
  String? _selectedType;
  bool _isLoading = true;

  final TextEditingController stockName = TextEditingController();
  final TextEditingController addDate = TextEditingController();
  final TextEditingController addTime = TextEditingController();
  final TextEditingController entry = TextEditingController();
  final TextEditingController cmp = TextEditingController();
  final TextEditingController target1Price = TextEditingController();
  final TextEditingController target2Price = TextEditingController();
  final TextEditingController target3Price = TextEditingController();
  // final TextEditingController target1Status = TextEditingController();
  // final TextEditingController target2Status = TextEditingController();
  // final TextEditingController target3Status = TextEditingController();
  String? _selectedTarget1;
  String? _selectedTarget2;
  String? _selectedTarget3;
  String? _selectedStopLoss;

  final TextEditingController stopLossPrice = TextEditingController();
  final TextEditingController stopLossStatus = TextEditingController();
  final TextEditingController desc1 =
      TextEditingController(text: 'Remarks : Cash Intraday');
  final TextEditingController desc2 =
      TextEditingController(text: 'Update : Educational Purpose Only');

  String? selectedName;
  String? selectedSellBuy;

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
    stopLossStatus.dispose();
    desc1.dispose();
    desc2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _assignCurrentDateTime();
    _fetchDropdownData();
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

  Future<void> _submitForm() async {
    const url = 'https://admin.invescube.com/admin_api/add-investment.php';
    final headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    // print('select name $selectedName');

    // String? type;

    // if (selectedName == 'Short term') {
    //   type = '11';
    // } else if (selectedName == 'Mid term') {
    //   type = '12';
    // } else if (selectedName == 'Long term') {
    //   type = '13';
    // }

    request.fields['sname'] = stockName.text;
    request.fields['name'] = selectedName.toString();
    request.fields['type'] = selectedSellBuy.toString();
    request.fields['date'] = addDate.text;
    request.fields['time'] = addTime.text;
    request.fields['entry'] = entry.text;
    request.fields['target_price'] = target1Price.text;
    request.fields['target1_price'] = target1Price.text;
    request.fields['target2_price'] = target2Price.text;
    request.fields['stoploss_price'] = stopLossPrice.text;
    request.fields['target_status'] = _selectedTarget1.toString();
    request.fields['target1_status'] = _selectedTarget2.toString();
    request.fields['target2_status'] = _selectedTarget3.toString();
    request.fields['stoploss_status'] = _selectedStopLoss.toString();
    request.fields['cmp'] = cmp.text;
    request.fields['des'] = desc1.text;
    request.fields['des1'] = desc2.text;

    var response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Investment added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      // If the server returns a 200 OK response, handle success
      print('Investment added successfully');
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
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Add Investment Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          DropdownButtonFormField<String>(
                            value: selectedName,
                            items: _dropdownItems,
                            onChanged: (newValue) {
                              setState(() {
                                selectedName = newValue;
                              });
                            },
                            decoration:
                                _inputDecoration('Category', 'Select Category'),
                          ),
                          // Your other UI elements here
                        ],
                      ),
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
                DropdownButtonFormField<String>(
                  value: selectedSellBuy,
                  items: ['Sell ', 'Buy'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: _inputDecoration('Sell/Buy', 'Select Sell/Buy'),
                  onChanged: (newValue) {
                    setState(() {
                      selectedSellBuy = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select Sell/Buy';
                    }
                    return null;
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
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: entry,
                  decoration: _inputDecoration(
                      'Entry', 'Enter entry value For ex: 900-950'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter entry value';
                    }
                    return null;
                  },
                ),
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
                // TextFormField(
                //   keyboardType: TextInputType.number,
                //   controller: target2Status,
                //   decoration: _inputDecoration(
                //       'Target 2 Status', 'Enter target 2 status'),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter target 2 status';
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
                                  _submitForm();
                                }
                              },
                              child: const Text(
                                'Add',
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
                                  stopLossStatus.clear();
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
