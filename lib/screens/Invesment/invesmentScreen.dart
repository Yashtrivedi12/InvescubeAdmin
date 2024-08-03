// import 'package:flutter/material.dart';
// import 'package:flutter_expandable_table/flutter_expandable_table.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:invescube_admin/Model/tradingModel.dart';
// import 'package:invescube_admin/screens/Invesment/EditInvesment.dart';
// import 'package:invescube_admin/screens/Invesment/addInvesmentScreen.dart';
// import 'package:invescube_admin/screens/Invesment/invesmentHistory.dart';

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class InvestmentTableView extends StatefulWidget {
//   @override
//   State<InvestmentTableView> createState() => _InvestmentTableViewState();
// }

// class _InvestmentTableViewState extends State<InvestmentTableView> {
//   List<Data> dataList = []; // Your data list
//   List<Data> filteredList = []; // Filtered data list
//   int currentPage = 1;
//   int itemsPerPage = 10; // Number of items per page
//   TextEditingController searchController = TextEditingController();
//   String? _selectedType; // Variable to store the selected dropdown value

//   List<Map<String, String>> _dropdownItems = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromApi();
//     _fetchDropdownData(); // Fetch dropdown data
//   }

//   Future<void> _fetchDropdownData() async {
//     final url = Uri.parse(
//         'https://admin.invescube.com/admin_api/show_investment_cat.php');
//     final headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

//     try {
//       final response = await http.post(url, headers: headers);

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//         final List<Map<String, String>> parsedData = jsonData.map((item) {
//           return {
//             'id': item['id'].toString(),
//             'name': item['name'] as String,
//           };
//         }).toList();
//         setState(() {
//           _dropdownItems = parsedData;
//         });
//       } else {
//         throw Exception('Failed to load dropdown data');
//       }
//     } catch (e) {
//       print('Error fetching dropdown data: $e');
//     }
//   }

//   Future<void> fetchDataFromApi() async {
//     var url =
//         Uri.parse('https://admin.invescube.com/admin_api/show_investment.php');
//     var headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

//     try {
//       var response = await http.get(url, headers: headers);

//       if (response.statusCode == 200) {
//         // Parse the JSON response
//         Map<String, dynamic> responseData = json.decode(response.body);

//         // Extract data from JSON and populate dataList
//         if (responseData.containsKey('data')) {
//           List<dynamic> jsonData = responseData['data'];
//           setState(() {
//             dataList = jsonData.map((item) => Data.fromJson(item)).toList();
//             filteredList = List<Data>.from(
//                 dataList); // Initially, filtered list is the same as data list
//             _isLoading = false; // Data loading is complete
//           });
//         } else {
//           print('No data found in the response.');
//         }
//       } else {
//         // Handle error, show error message or retry mechanism
//         print('Failed to fetch data: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle network errors
//       print('Error fetching data: $e');
//     }
//   }

//   Future<void> deleteTableItem(String id) async {
//     var url =
//         Uri.parse('https://admin.invescube.com/admin_api/delete_data.php');

//     var request = http.MultipartRequest('POST', url);

//     request.headers['Authorization'] = 'yp7280uvfkvdirgjkpo';
//     request.fields['t_id'] = id;

//     try {
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         print(' $id Item deleted successfully');
//         Fluttertoast.showToast(
//             msg: "Investment deleted successfully",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             textColor: Colors.white,
//             fontSize: 16.0);
//         setState(() {
//           dataList.removeWhere((item) => item.id == id);
//           filteredList.removeWhere((item) => item.id == id);
//         });

//         // Optionally, you can fetch the updated data to refresh the UI
//       } else {
//         print('Failed to delete item');
//         // Handle error accordingly
//       }
//     } catch (e) {
//       print('Error while deleting item: $e');
//     }
//   }

//   Future<void> closeCallItem(String id) async {
//     var url = Uri.parse('https://admin.invescube.com/admin_api/close_call.php');

//     var request = http.MultipartRequest('POST', url);

//     request.headers['Authorization'] = 'yp7280uvfkvdirgjkpo';
//     request.fields['t_id'] = id;

//     try {
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         print(' $id Item deleted successfully');
//         Fluttertoast.showToast(
//             msg: "Close Called Sucessfully",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             textColor: Colors.white,
//             fontSize: 16.0);
//         // Navigator.pop(context);
//         setState(() {
//           dataList.removeWhere((item) => item.id == id);
//           filteredList.removeWhere((item) => item.id == id);
//         });

//         // Optionally, you can fetch the updated data to refresh the UI
//       } else {
//         print('Failed to delete item');
//         // Handle error accordingly
//       }
//     } catch (e) {
//       print('Error while deleting item: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Data> paginatedData = filteredList
//         .skip((currentPage - 1) * itemsPerPage)
//         .take(itemsPerPage)
//         .toList();

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text('Investment'),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                   width: 160,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   const InvestmentStockForm()));
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 32.0, vertical: 12.0),
//                       backgroundColor: const Color.fromARGB(
//                           255, 67, 45, 144), // Background color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       elevation: 2,
//                     ),
//                     child: const Text(
//                       'Add',
//                       style: TextStyle(
//                           fontSize: 14.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 160,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => InvestmentHistoryTable()));
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 32.0, vertical: 12.0),
//                       backgroundColor: const Color.fromARGB(255, 67, 45, 144),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       elevation: 2,
//                     ),
//                     child: const Text(
//                       'History',
//                       style: TextStyle(
//                           fontSize: 14.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: searchController,
//                     decoration: InputDecoration(
//                       hintText: 'Search',
//                       hintStyle: TextStyle(color: Colors.grey.shade600),
//                       prefixIcon:
//                           const Icon(Icons.search, color: Color(0xFF4e4376)),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                         borderSide: const BorderSide(
//                           color: Colors.black54,
//                           width: 1.0,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                         borderSide: const BorderSide(
//                           color: Colors.black,
//                           width: 1.0,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                         borderSide: const BorderSide(
//                           color: Color(0xFF4e4376),
//                           width: 2.0,
//                         ),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                           vertical: 0.0, horizontal: 16.0),
//                     ),
//                     onChanged: (value) => filterData(value),
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12.0),
//                       border: Border.all(color: Colors.grey.shade300),
//                     ),
//                     child: DropdownButtonFormField<String>(
//                       hint: const Text('Select Category'),
//                       value: _selectedType,
//                       items: _dropdownItems.map((Map<String, String> item) {
//                         return DropdownMenuItem<String>(
//                           value: item['id'],
//                           child: Text(item['name']!),
//                         );
//                       }).toList(),
//                       onChanged: (String? value) {
//                         setState(() {
//                           _selectedType = value;
//                           filterData(searchController
//                               .text); // Call filter with search query
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Divider(),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: ListTile(
//                 title: Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Id',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         'Main Type',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: Text(
//                         'Name',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Expanded(child: Text('')),
//                   ],
//                 ),
//               ),
//             ),
//             Divider(),
//             _isLoading
//                 ? const CircularProgressIndicator()
//                 : Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ListView.builder(
//                         itemCount: paginatedData.length +
//                             1, // Add 1 for the pagination controls
//                         itemBuilder: (context, index) {
//                           if (index == paginatedData.length) {
//                             // Render pagination controls
//                             return buildPaginationControls();
//                           } else {
//                             return CustomTableRow(
//                                 paginatedData[index],
//                                 deleteTableItem,
//                                 dataList[index],
//                                 closeCallItem);
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildPaginationControls() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(100.0)),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.arrow_back_ios_rounded),
//               onPressed:
//                   currentPage == 1 ? null : () => setState(() => currentPage--),
//             ),
//             Text(
//               'Page $currentPage',
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             IconButton(
//               icon: const Icon(Icons.arrow_forward_ios_rounded),
//               onPressed: filteredList.length <= currentPage * itemsPerPage
//                   ? null
//                   : () => setState(() => currentPage++),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void filterData(String query) {
//     setState(() {
//       print(_selectedType);
//       if (query.isEmpty && _selectedType == null) {
//         // If both search query and dropdown selection are empty, show all data
//         filteredList = dataList;
//       } else {
//         // Filter data based on the search query and dropdown selection
//         filteredList = dataList.where((data) {
//           return (query.isEmpty ||
//                   data.id!.toLowerCase().contains(query.toLowerCase()) ||
//                   data.mainType!.toLowerCase().contains(query.toLowerCase()) ||
//                   data.name!.toLowerCase().contains(query.toLowerCase())) &&
//               (_selectedType == null || data.mainType == _selectedType);
//         }).toList();
//       }
//       // Reset pagination to the first page when filtering
//       currentPage = 1;
//     });
//   }
// }

// class CustomTableRow extends StatefulWidget {
//   final Data rowData;
//   final Future<void> Function(String id) deleteTableItem;
//   final Future<void> Function(String id) closeCallItem;

//   final Data additionalData;

//   CustomTableRow(this.rowData, this.deleteTableItem, this.additionalData,
//       this.closeCallItem);

//   @override
//   State<CustomTableRow> createState() => _CustomTableRowState();
// }

// class _CustomTableRowState extends State<CustomTableRow> {
//   String? selectedValue;
//   void _callApiTarget1Status(String id) async {
//     var url = Uri.parse('https://admin.invescube.com/admin_api/update_t1.php');
//     var headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

//     var request = http.MultipartRequest('POST', url)
//       ..headers.addAll(headers)
//       ..fields['t_id'] = id.toString()
//       ..fields['status'] = '1';

//     try {
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         print('API call successful: ${response.body}');
//         Fluttertoast.showToast(
//             msg: "Target Achieved successfully",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             textColor: Colors.white,
//             fontSize: 16.0);
//       } else {
//         print('Failed to call API: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error during API call: $e');
//     }
//   }

//   void _callApiTarget2Status(String id) async {
//     var url = Uri.parse('https://admin.invescube.com/admin_api/update_t2.php');
//     var headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

//     var request = http.MultipartRequest('POST', url)
//       ..headers.addAll(headers)
//       ..fields['t_id'] = id.toString()
//       ..fields['status'] = '1';

//     try {
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         print('API call successful: ${response.body}');
//         Fluttertoast.showToast(
//             msg: "Target Achieved successfully",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             textColor: Colors.white,
//             fontSize: 16.0);
//         Navigator.pop(context);
//       } else {
//         print('Failed to call API: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error during API call: $e');
//     }
//   }

//   void _callApiTarget3Status(String id) async {
//     var url = Uri.parse('https://admin.invescube.com/admin_api/update_t3.php');
//     var headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

//     var request = http.MultipartRequest('POST', url)
//       ..headers.addAll(headers)
//       ..fields['t_id'] = id.toString()
//       ..fields['status'] = '1';

//     try {
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         print('API call successful: ${response.body}');
//         Fluttertoast.showToast(
//             msg: "Target Achieved successfully",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             textColor: Colors.white,
//             fontSize: 16.0);
//         Navigator.pop(context);
//       } else {
//         print('Failed to call API: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error during API call: $e');
//     }
//   }

//   void _callApiStopLossStatus(String id) async {
//     var url = Uri.parse('https://admin.invescube.com/admin_api/update_sl.php');
//     var headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

//     var request = http.MultipartRequest('POST', url)
//       ..headers.addAll(headers)
//       ..fields['t_id'] = id.toString()
//       ..fields['status'] = '1';

//     try {
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         print('API call successful: ${response.body}');
//         Fluttertoast.showToast(
//             msg: "Target Achieved successfully",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             textColor: Colors.white,
//             fontSize: 16.0);
//         Navigator.pop(context);
//       } else {
//         print('Failed to call API: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error during API call: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
// String? nameOfType;
// if (widget.rowData.mainType == '11') {
//   nameOfType = 'Short Term';
// } else if (widget.rowData.mainType == '12') {
//   nameOfType = 'Mid Term';
// } else if (widget.rowData.mainType == '13') {
//   nameOfType = 'Long Term';
// }

//     return ExpansionTile(
//       title: Row(
//         children: [
//           Expanded(child: Text(widget.rowData.id!)),

//           Expanded(child: Text(nameOfType!)),
//           const SizedBox(
//             width: 20,
//           ),
//           Expanded(child: Text(widget.rowData.name!)),
//           // const Icon(Icons.arrow_drop_down),
//         ],
//       ),
//       children: <Widget>[
//         SizedBox(
//           height: 35,
//           child: ListTile(
//             title: const Text(
//               'Show Date',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             trailing: Text(
//               widget.rowData.showDate!,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//         Divider(),
//         SizedBox(
//           height: 40,
//           child: ListTile(
//             title: const Text(
//               'Time',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             trailing: Text(
//               widget.rowData.time ?? 'N/A',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//         Divider(),
//         SizedBox(
//           height: 40,
//           child: ListTile(
//             title: const Text(
//               'Type',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             trailing: Text(
//               widget.rowData.type ?? 'N/A',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//         Divider(),
//         SizedBox(
//           height: 40,
//           child: ListTile(
//             title: const Text(
//               'Target 1',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             trailing: Text(
//               widget.rowData.target ?? 'N/A',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//         Divider(),
//         SizedBox(
//           height: 40,
//           child: ListTile(
//             title: const Text(
//               'Target 2',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             trailing: Text(
//               widget.rowData.target1 ?? 'N/A',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//         Divider(),
//         SizedBox(
//           height: 40,
//           child: ListTile(
//             title: const Text(
//               'Target 3',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             trailing: Text(
//               widget.rowData.target2 ?? 'N/A',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//         Divider(),
//         SizedBox(
//           height: 40,
//           child: ListTile(
//             title: const Text(
//               'Stop Loss',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             trailing: Text(
//               widget.rowData.target ?? 'N/A',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//         Divider(),
//         const SizedBox(
//           height: 20,
//         ),
//         SizedBox(
//           height: 60,
//           width: double.infinity,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const SizedBox(
//                 width: 20,
//               ),
//               const Text(
//                 'TS 1',
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
//               ),
//               const SizedBox(
//                 width: 40,
//               ),
//               Text(
//                 widget.rowData.targetStatus!,
//                 style: const TextStyle(fontWeight: FontWeight.w500),
//               ),
//               // ignore: prefer_const_constructors
//               SizedBox(
//                 width: 40,
//               ),
//               Expanded(
//                   child: SizedBox(
//                 height: 60,
//                 child: DropdownButtonFormField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16.0, vertical: 12.0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(100.0),
//                     ),
//                   ),
//                   items: const [
//                     DropdownMenuItem(
//                       value: '',
//                       child: Text('No'),
//                     ),
//                     DropdownMenuItem(
//                       value: '1',
//                       child: Text('Target Achieved'),
//                     ),
//                   ],
//                   onChanged: (String? newValue) {
//                     if (newValue == '1') {
//                       _callApiTarget1Status(widget.rowData.id!);
//                     }
//                     // Handle the selected value
//                   },
//                   style: const TextStyle(
//                     fontSize: 16.0,
//                     color: Colors.black,
//                   ),
//                   iconSize: 24.0,
//                   icon: const Icon(Icons.arrow_drop_down),
//                   isExpanded: false,
//                   hint: const Text('Select an option'),
//                 ),
//               )),
//               const SizedBox(
//                 width: 20,
//               ),
//             ],
//           ),
//         ),
//         Divider(),
//         SizedBox(
//           height: 40,
//           child: ListTile(
//             title: const Text(
//               'T1 TimeStamp',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             trailing: Text(
//               widget.rowData.t1Update ?? 'N/A',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         SizedBox(
//           height: 60,
//           width: double.infinity,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const SizedBox(
//                 width: 20,
//               ),
//               const Text(
//                 'TS 2',
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
//               ),
//               const SizedBox(
//                 width: 40,
//               ),
//               Text(
//                 widget.rowData.target1Status!,
//                 style: const TextStyle(fontWeight: FontWeight.w500),
//               ),
//               // ignore: prefer_const_constructors
//               SizedBox(
//                 width: 40,
//               ),
//               Expanded(
//                   child: SizedBox(
//                 height: 60,
//                 child: DropdownButtonFormField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16.0, vertical: 12.0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(100.0),
//                     ),
//                   ),
//                   items: const [
//                     DropdownMenuItem(
//                       value: '',
//                       child: Text('No'),
//                     ),
//                     DropdownMenuItem(
//                       value: '1',
//                       child: Text('Target Achieved'),
//                     ),
//                   ],
//                   onChanged: (String? newValue) {
//                     if (newValue == '1') {
//                       _callApiTarget2Status(widget.rowData.id!);
//                     }
//                     // Handle the selected value
//                   },
//                   style: const TextStyle(
//                     fontSize: 16.0,
//                     color: Colors.black,
//                   ),
//                   iconSize: 24.0,
//                   icon: const Icon(Icons.arrow_drop_down),
//                   isExpanded: false,
//                   hint: const Text('Select an option'),
//                 ),
//               )),
//               const SizedBox(
//                 width: 20,
//               ),
//             ],
//           ),
//         ),
//         Divider(),
//         SizedBox(
//           height: 40,
//           child: ListTile(
//             title: const Text(
//               'T2 TimeStamp',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             trailing: Text(
//               widget.rowData.t2Update ?? 'N/A',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//         Divider(),
//         const SizedBox(
//           height: 20,
//         ),
//         SizedBox(
//           height: 60,
//           width: double.infinity,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const SizedBox(
//                 width: 20,
//               ),
//               const Text(
//                 'TS 3',
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
//               ),
//               const SizedBox(
//                 width: 40,
//               ),
//               Text(
//                 widget.rowData.target2Status!,
//                 style: const TextStyle(fontWeight: FontWeight.w500),
//               ),
//               // ignore: prefer_const_constructors
//               SizedBox(
//                 width: 40,
//               ),
//               Expanded(
//                   child: SizedBox(
//                 height: 60,
//                 child: DropdownButtonFormField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 12.0, vertical: 5.0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(100.0),
//                     ),
//                   ),
//                   items: const [
//                     DropdownMenuItem(
//                       value: '',
//                       child: Text('No'),
//                     ),
//                     DropdownMenuItem(
//                       value: '1',
//                       child: Text('Target Achieved'),
//                     ),
//                   ],
//                   onChanged: (String? newValue) {
//                     if (newValue == '1') {
//                       _callApiTarget3Status(widget.rowData.id!);
//                     }
//                     // Handle the selected value
//                   },
//                   style: const TextStyle(
//                     fontSize: 16.0,
//                     color: Colors.black,
//                   ),
//                   iconSize: 24.0,
//                   icon: const Icon(Icons.arrow_drop_down),
//                   isExpanded: false,
//                   hint: const Text('Select an option'),
//                 ),
//               )),
//               const SizedBox(
//                 width: 20,
//               ),
//             ],
//           ),
//         ),
//         Divider(),
//         SizedBox(
//           height: 40,
//           child: ListTile(
//             title: const Text(
//               'T3 TimeStamp',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             trailing: Text(
//               widget.rowData.t3Update ?? 'N/A',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//         Divider(),
//         const SizedBox(
//           height: 20,
//         ),
//         SizedBox(
//           height: 60,
//           width: double.infinity,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const SizedBox(
//                 width: 20,
//               ),
//               const Text(
//                 'SL Status',
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//               const Text(
//                 '0',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               // ignore: prefer_const_constructors
//               SizedBox(
//                 width: 38,
//               ),
//               Expanded(
//                   child: SizedBox(
//                 height: 60,
//                 child: DropdownButtonFormField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16.0, vertical: 12.0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(100.0),
//                     ),
//                   ),
//                   items: const [
//                     DropdownMenuItem(
//                       value: '',
//                       child: Text('No'),
//                     ),
//                     DropdownMenuItem(
//                       value: '1',
//                       child: Text('Target Achieved'),
//                     ),
//                   ],
//                   onChanged: (String? newValue) {
//                     if (newValue == '1') {
//                       _callApiStopLossStatus(widget.rowData.id!);
//                     }
//                     // Handle the selected value
//                   },
//                   style: const TextStyle(
//                     fontSize: 16.0,
//                     color: Colors.black,
//                   ),
//                   iconSize: 24.0,
//                   icon: const Icon(Icons.arrow_drop_down),
//                   isExpanded: false,
//                   hint: const Text('Select an option'),
//                 ),
//               )),
//               const SizedBox(
//                 width: 20,
//               ),
//             ],
//           ),
//         ),
//         Divider(),
//         SizedBox(
//           height: 40,
//           child: ListTile(
//             title: const Text(
//               'SL TimeStamp',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             trailing: Text(
//               widget.rowData.spUpdate ?? 'N/A',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//         Divider(),
//         SizedBox(
//           height: 45,
//           child: ListTile(
//               title: const Text(
//                 'Close Call',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               trailing: SizedBox(
//                   height: 50,
//                   width: 100,
//                   child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0)),
//                         backgroundColor: Colors.red,
//                       ),
//                       onPressed: () async {
//                         await widget.closeCallItem(widget.rowData.id!);
//                       },
//                       child: const Text(
//                         'Close',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       )))),
//         ),
//         Divider(),
//         const SizedBox(
//           height: 10,
//         ),
//         SizedBox(
//           height: 40,
//           child: ListTile(
//             title: const Text(
//               'Update On',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             trailing: Text(
//               widget.rowData.updateOn ?? 'N/A',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//         Divider(),
//         SizedBox(
//           height: 40,
//           child: ListTile(
//             title: const Text(
//               'Add date',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             trailing: Text(
//               widget.rowData.date ?? 'N/A',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//         Divider(),
//         SizedBox(
//           height: 45,
//           child: ListTile(
//               title: const Text(
//                 'Edit',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               trailing: IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => EditInvestmentForm(
//                                   rowData: widget.rowData,
//                                   id: widget.rowData.id!,
//                                 )));
//                   },
//                   icon: const Icon(
//                     Icons.mode_edit_outline_rounded,
//                     color: Colors.green,
//                   ))),
//         ),
//         Divider(),
//         SizedBox(
//           height: 50,
//           child: ListTile(
//               title: const Text(
//                 'Delete',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               trailing: IconButton(
//                   onPressed: () async {
//                     await widget.deleteTableItem(widget.rowData.id!);
//                   },
//                   icon: const Icon(
//                     Icons.delete_rounded,
//                     color: Colors.red,
//                   ))),
//         ),
//       ],
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:invescube_admin/Model/tradingModel.dart';
import 'package:invescube_admin/screens/Invesment/EditInvesment.dart';
import 'package:invescube_admin/screens/Invesment/addInvesmentScreen.dart';
import 'package:invescube_admin/screens/Invesment/invesmentHistory.dart';
import 'package:http/http.dart' as http;
import 'package:invescube_admin/screens/Trading/tradingScreen.dart';

class InvestmentTableView extends StatefulWidget {
  @override
  State<InvestmentTableView> createState() => _InvestmentTableViewState();
}

class _InvestmentTableViewState extends State<InvestmentTableView> {
  List<Data> dataList = [];
  List<Data> filteredList = [];
  int currentPage = 1;
  int itemsPerPage = 10;
  TextEditingController searchController = TextEditingController();
  String? _selectedType;
  bool isLoading = true;

  List<Map<String, String>> _dropdownItems = [];

  final DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchDropdownData();
  }

  Future<void> fetchData() async {
    try {
      final data = await _dataService.fetchData();
      setState(() {
        dataList = data;
        filteredList = List.from(dataList);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchDropdownData() async {
    try {
      final data = await _dataService.fetchDropdownData();
      setState(() {
        _dropdownItems = data;
      });
    } catch (e) {
      print('Error fetching dropdown data: $e');
    }
  }

  Future<void> deleteTableItem(String id) async {
    try {
      await _dataService.deleteData(id);
      Fluttertoast.showToast(
          msg: "Trade deleted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        dataList.removeWhere((item) => item.id == id);
        filteredList.removeWhere((item) => item.id == id);
      });
    } catch (e) {
      print('Error while deleting item: $e');
    }
  }

  Future<void> closeCallItem(String id) async {
    try {
      await _dataService.closeCall(id);
      Fluttertoast.showToast(
          msg: "Close Called Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        dataList.removeWhere((item) => item.id == id);
        filteredList.removeWhere((item) => item.id == id);
      });
    } catch (e) {
      print('Error while closing call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Data> paginatedData = filteredList
        .skip((currentPage - 1) * itemsPerPage)
        .take(itemsPerPage)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Investment'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InvestmentStockForm()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 12.0),
                      backgroundColor: const Color.fromARGB(255, 67, 45, 144),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InvestmentHistoryTable()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 12.0),
                      backgroundColor: const Color.fromARGB(255, 67, 45, 144),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'History',
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xFF4e4376)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Colors.black54,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Color(0xFF4e4376),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 16.0),
                    ),
                    onChanged: (value) => filterData(value),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonFormField<String>(
                      hint: const Text('Select Category'),
                      value: _selectedType,
                      items: _dropdownItems.map((Map<String, String> item) {
                        return DropdownMenuItem<String>(
                          value: item['id'],
                          child: Text(item['name']!),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedType = value;
                          filterData(searchController.text);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'No',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Main Type',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(child: Text('')),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: paginatedData.length + 1,
                        itemBuilder: (context, index) {
                          if (index == paginatedData.length) {
                            return buildPaginationControls();
                          } else {
                            return CustomTableRow(index, paginatedData[index],
                                deleteTableItem, closeCallItem);
                          }
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaginationControls() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(100.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed:
                  currentPage == 1 ? null : () => setState(() => currentPage--),
            ),
            Text(
              'Page $currentPage',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: filteredList.length <= currentPage * itemsPerPage
                  ? null
                  : () => setState(() => currentPage++),
            ),
          ],
        ),
      ),
    );
  }

  void filterData(String query) {
    setState(() {
      if (query.isEmpty && _selectedType == null) {
        filteredList = dataList;
      } else {
        filteredList = dataList.where((data) {
          return (query.isEmpty ||
                  data.id!.toLowerCase().contains(query.toLowerCase()) ||
                  data.mainType!.toLowerCase().contains(query.toLowerCase()) ||
                  data.name!.toLowerCase().contains(query.toLowerCase())) &&
              (_selectedType == null || data.mainType == _selectedType);
        }).toList();
      }
      currentPage = 1;
    });
  }
}

class DataService {
  static const _baseUrl = 'https://admin.invescube.com/admin_api/';
  static const _headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

  Future<List<Data>> fetchData() async {
    final url = Uri.parse('$_baseUrl/show_investment.php');

    try {
      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData.containsKey('data')) {
          final jsonData = responseData['data'] as List;
          return jsonData.map((item) => Data.fromJson(item)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      rethrow; // Re-throw the caught exception for higher level handling.
    }
  }

  Future<List<Map<String, String>>> fetchDropdownData() async {
    final url = Uri.parse('${_baseUrl}show_investment_cat.php');

    try {
      final response = await http.post(url, headers: _headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        return jsonData.map((item) {
          return {'id': item['id'].toString(), 'name': item['name'] as String};
        }).toList();
      } else {
        throw Exception('Failed to load dropdown data');
      }
    } catch (e) {
      print('Error fetching dropdown data: $e');
      throw Exception('Error fetching dropdown data');
    }
  }

  Future<void> deleteData(String id) async {
    final url = Uri.parse('${_baseUrl}delete_data.php');
    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'yp7280uvfkvdirgjkpo'
      ..fields['t_id'] = id;

    try {
      final response = await request.send();
      if (response.statusCode != 200) {
        throw Exception('Failed to delete item');
      }
    } catch (e) {
      print('Error while deleting item: $e');
      throw Exception('Error while deleting item');
    }
  }

  Future<void> closeCall(String id) async {
    final url = Uri.parse('${_baseUrl}close_call.php');
    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'yp7280uvfkvdirgjkpo'
      ..fields['t_id'] = id
      ..fields['type'] = 'trading';

    try {
      final response = await request.send();
      if (response.statusCode != 200) {
        throw Exception('Failed to close call');
      }
    } catch (e) {
      print('Error while closing call: $e');
      throw Exception('Error while closing call');
    }
  }
}

class ApiService {
  static const String _authorizationHeader = 'yp7280uvfkvdirgjkpo';

  static Future<void> updateStatus(
      String id, String endpoint, BuildContext context) async {
    var url = Uri.parse('https://admin.invescube.com/admin_api/$endpoint');
    var headers = {'Authorization': _authorizationHeader};

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['t_id'] = id
      ..fields['status'] = '1';

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Target Achieved successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InvestmentTableView()),
        );
      } else {
        print('Failed to call API: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API call: $e');
    }
  }
}

// custom_table_row.dart

// ignore: must_be_immutable
class CustomTableRow extends StatefulWidget {
  int index;
  final Data rowData;
  final Future<void> Function(String id) deleteTableItem;
  final Future<void> Function(String id) closeCallItem;

  CustomTableRow(
      this.index, this.rowData, this.deleteTableItem, this.closeCallItem);

  @override
  State<CustomTableRow> createState() => _CustomTableRowState();
}

class _CustomTableRowState extends State<CustomTableRow> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    String? nameOfType;
    if (widget.rowData.mainType == '11') {
      nameOfType = 'Short Term';
    } else if (widget.rowData.mainType == '12') {
      nameOfType = 'Mid Term';
    } else if (widget.rowData.mainType == '13') {
      nameOfType = 'Long Term';
    }
    return ExpansionTile(
      title: Row(
        children: [
          Expanded(child: Text('${widget.index + 1}')),
          Expanded(child: Text(nameOfType!)),
          const SizedBox(width: 12),
          Expanded(child: Text(widget.rowData.name!)),
          const SizedBox(width: 14),
        ],
      ),
      children: <Widget>[
        _buildListTile('Show Date', widget.rowData.showDate!),
        const Divider(),
        _buildListTile('Time', widget.rowData.time ?? 'N/A'),
        const Divider(),
        _buildListTile('Type', widget.rowData.type ?? 'N/A'),
        const Divider(),
        _buildListTile('Target 1', widget.rowData.target ?? 'N/A'),
        const Divider(),
        _buildListTile('Target 2', widget.rowData.target1 ?? 'N/A'),
        const Divider(),
        _buildListTile('Target 3', widget.rowData.target2 ?? 'N/A'),
        const Divider(),
        _buildListTile('Stop Loss', widget.rowData.stoploss ?? 'N/A'),
        const Divider(),
        const SizedBox(height: 20),
        _buildDropdownRow(
            'TS 1', widget.rowData.targetStatus!, 'update_t1.php'),
        const Divider(),
        _buildListTile('T1 TimeStamp', widget.rowData.t1Update ?? 'N/A'),
        const Divider(),
        const SizedBox(height: 20),
        _buildDropdownRow(
            'TS 2', widget.rowData.target1Status!, 'update_t2.php'),
        const Divider(),
        _buildListTile('T2 TimeStamp', widget.rowData.t2Update ?? 'N/A'),
        const Divider(),
        const SizedBox(height: 20),
        _buildDropdownRow(
            'TS 3', widget.rowData.target2Status!, 'update_t3.php'),
        const Divider(),
        _buildListTile('T3 TimeStamp', widget.rowData.t3Update ?? 'N/A'),
        const Divider(),
        const SizedBox(height: 10),
        _buildDropdownRow(
            'SL Status', widget.rowData.stoplessStatus!, 'update_sl.php'),
        const Divider(),
        _buildListTile('SL TimeStamp', widget.rowData.spUpdate ?? 'N/A'),
        const Divider(),
        const SizedBox(height: 10),
        _buildCloseButton(),
        const Divider(),
        const SizedBox(height: 10),
        _buildListTile('Update On', widget.rowData.updateOn ?? 'N/A'),
        const Divider(),
        _buildListTile('Add date', widget.rowData.date ?? 'N/A'),
        const Divider(),
        _buildEditButton(),
        const Divider(),
        _buildDeleteButton(),
      ],
    );
  }

  Widget _buildListTile(String title, String trailing) {
    return SizedBox(
      height: 40,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: Text(
          trailing,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildDropdownRow(String label, String status, String endpoint) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 20),
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          const SizedBox(width: 34),
          Text(status, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(width: 30),
          Expanded(
            child: SizedBox(
              height: 60,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: '', child: Text('No')),
                  DropdownMenuItem(value: '1', child: Text('Target Achieved')),
                ],
                onChanged: (String? newValue) {
                  if (newValue == '1') {
                    ApiService.updateStatus(
                        widget.rowData.id!, endpoint, context);
                  }
                },
                style: const TextStyle(fontSize: 16.0, color: Colors.black),
                iconSize: 24.0,
                icon: const Icon(Icons.arrow_drop_down),
                isExpanded: false,
                hint: const Text('Select an option'),
              ),
            ),
          ),
          const SizedBox(width: 14),
        ],
      ),
    );
  }

  Widget _buildCloseButton() {
    return SizedBox(
      height: 45,
      child: ListTile(
        title: const Text(
          'Close Call',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: SizedBox(
          height: 50,
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              backgroundColor: Colors.red,
            ),
            onPressed: () async {
              await widget.closeCallItem(widget.rowData.id!);
            },
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return SizedBox(
      height: 45,
      child: ListTile(
        title: const Text(
          'Edit',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditInvestmentForm(
                  rowData: widget.rowData,
                  id: widget.rowData.id!,
                  // onSave: (newData) {
                  //   setState(() {
                  //     widget.rowData = newData;
                  //   });
                  // },
                ),
              ),
            );
          },
          icon: const Icon(Icons.edit, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return SizedBox(
      height: 45,
      child: ListTile(
        title: const Text(
          'Delete',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: IconButton(
          onPressed: () async {
            await widget.deleteTableItem(widget.rowData.id!);
          },
          icon: const Icon(Icons.delete, color: Colors.red),
        ),
      ),
    );
  }
}
// api_service.dart









// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:invescube_admin/Model/tradingModel.dart';
// import 'package:invescube_admin/screens/Investment/addInvestmentScreen.dart';

// class InvestmentScreen extends StatefulWidget {
//   @override
//   _InvestmentScreenState createState() => _InvestmentScreenState();
// }

// class _InvestmentScreenState extends State<InvestmentScreen> {
//   String? _selectedTarget1Achieved;

//   List<Data> _filteredData = [];
//   String? _selectedType; // Default value is null
//   List<Data> _investmentData = []; // To store the fetched data
//   InvestmentDataTableSource? _investmentDataSource;
//   bool _isLoading = true;
//   List<Map<String, String>> _dropdownItems = [];

//   TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     _fetchDropdownData();
//     _searchController.addListener(_filterData);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<void> fetchData() async {
//     setState(() {
//       _isLoading = true; // Show loading indicator while fetching data
//     });

//     var url =
//         Uri.parse('https://admin.invescube.com/admin_api/show_investment.php');

//     // Create a multipart request
//     var request = http.MultipartRequest('POST', url);

//     // Add the authorization header
//     request.headers['Authorization'] = 'yp7280uvfkvdirgjkpo';

//     try {
//       // Send the request
//       var response = await request.send();

//       // Check the status code of the response
//       if (response.statusCode == 200) {
//         // If the server returns an OK response, parse the JSON
//         var data = await _parseResponse(response);
//         setState(() {
//           _investmentData = data;
//           _filteredData = data; // Initialize filtered data with all data
//           _investmentDataSource =
//               InvestmentDataTableSource(_filteredData, _showDetailsDialog);
//           _isLoading = false; // Hide loading indicator
//         });
//       } else {
//         // If the server did not return a 200 OK response, throw an exception.
//         throw Exception('Failed to post data');
//       }
//     } catch (e) {
//       print('Error while posting data: $e');
//       setState(() {
//         _isLoading = false; // Hide loading indicator
//       });
//     }
//   }

//   Future<List<Data>> _parseResponse(http.StreamedResponse response) async {
//     var responseData = await utf8.decodeStream(response.stream);
//     var jsonData = json.decode(responseData);
//     return (jsonData['data'] as List)
//         .map((item) => Data.fromJson(item))
//         .toList();
//   }

//   void _filterData() {
//     String query = _searchController.text.toLowerCase();
//     setState(() {
//       _filteredData = _investmentData.where((data) {
//         bool nameMatches = data.name?.toLowerCase().contains(query) ?? false;
//         bool idMatches = data.id?.toLowerCase().contains(query) ?? false;
//         bool typeMatches =
//             _selectedType == null || data.mainType == _selectedType!;
//         return (nameMatches || idMatches) && typeMatches;
//       }).toList();
//       _investmentDataSource =
//           InvestmentDataTableSource(_filteredData, _showDetailsDialog);
//     });
//   }

//   Future<void> _fetchDropdownData() async {
//     final url = Uri.parse(
//         'https://admin.invescube.com/admin_api/show_investment_cat.php');
//     final headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

//     try {
//       final response = await http.post(url, headers: headers);

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//         final List<Map<String, String>> parsedData = jsonData.map((item) {
//           return {
//             'id': item['id'].toString(),
//             'name': item['name'] as String,
//           };
//         }).toList();
//         setState(() {
//           _dropdownItems = parsedData;
//         });
//       } else {
//         throw Exception('Failed to load dropdown data');
//       }
//     } catch (e) {
//       print('Error fetching dropdown data: $e');
//     }
//   }

//   String _getTypeValue(String type) {
//     switch (type) {
//       case 'short term':
//         return '11';
//       case 'mid term':
//         return '12';
//       case 'long term':
//         return '13';
//       default:
//         return '';
//     }
//   }

//   void _showDetailsDialog(Data data) {
//     String? type;
//     if (data.mainType == '11') {
//       type = 'Short term';
//     } else if (data.mainType == '12') {
//       type = 'Mid term';
//     } else if (data.mainType == '13') {
//       type = 'Long term';
//     } else {
//       type = 'Unknown'; // Handle unknown types
//     }
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           title: Text(data.name ?? 'Details'),
//           content: SingleChildScrollView(
//             child: Table(
//               border: TableBorder.all(),
//               children: [
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text(
//                       'No',
//                       style:
//                           TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.id ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('Main Type'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(type.toString()),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('Name'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.name ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('Show Date'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.showDate ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('Time'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.time ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('Type'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.type ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('Target 1'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.target ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('Target 2'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.target1 ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('Target 3'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.target2 ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('Stoploss'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.stoploss ?? ''),
//                   ),
//                 ]),
//                 // Add more rows for other fields
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('TS 1'),
//                   ),
//                   Column(
//                     children: [
//                       Text(data.targetStatus ?? ''),
//                       SizedBox(
//                         width: 90, // Set the desired width here
//                         child: DropdownButtonFormField<String>(
//                           items: [
//                             DropdownMenuItem<String>(
//                                 value: '0', child: Text('0')),
//                             DropdownMenuItem<String>(
//                                 value: '1', child: Text('Target Achieved')),
//                           ],
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedTarget1Achieved = value;
//                             });
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Sel',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('T1 Timestamp'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.t1Update ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('TS 2'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.target1Status ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('T2 Timestamp'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.t2Update ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('TS 3'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.target2Status ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('T3 Timestamp'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.t1Update ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('SL Status'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.stoplessStatus ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('SL TimeStamp'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.stoplessStatus ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('Close Call'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.exitStatus ?? ''),
//                   ),
//                 ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('Add date'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.date ?? ''),
//                   ),
//                 ]),
//                 // TableRow(children: [
//                 //   const Padding(
//                 //     padding: EdgeInsets.all(12.0),
//                 //     child: Text('Edit'),
//                 //   ),
//                 //   Padding(
//                 //     padding: const EdgeInsets.all(12.0),
//                 //     child: Text(data. ?? ''),
//                 //   ),
//                 // ]),
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('Delete'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.ifDelete ?? ''),
//                   ),
//                 ]),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text('Investment'),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SizedBox(
//                     width: 160,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => InvestmentStockForm()));
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 32.0, vertical: 12.0),
//                         backgroundColor: Color.fromARGB(
//                             255, 67, 45, 144), // Background color
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                         ),
//                         elevation: 2,
//                       ),
//                       child: Text(
//                         'Add',
//                         style: TextStyle(
//                             fontSize: 14.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 160,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 32.0, vertical: 12.0),
//                         backgroundColor: Color.fromARGB(255, 67, 45, 144),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                         ),
//                         elevation: 2,
//                       ),
//                       child: Text(
//                         'History',
//                         style: TextStyle(
//                             fontSize: 14.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.0),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: DropdownButtonFormField<String>(
//                   hint: Text('Select Category'),
//                   value: _selectedType,
//                   items: _dropdownItems.map((item) {
//                     return DropdownMenuItem<String>(
//                       value: item['id'],
//                       child: Text(item['name'].toString()),
//                     );
//                   }).toList(),
//                   onChanged: (newValue) {
//                     setState(() {
//                       _selectedType = newValue;
//                       _filterData(); // Update filtered data when dropdown value changes
//                     });
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   hintText: 'Search',
//                   hintStyle: TextStyle(color: Colors.grey.shade600),
//                   prefixIcon: Icon(Icons.search, color: Color(0xFF4e4376)),
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide(
//                       color: Colors.black54,
//                       width: 1.0,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide(
//                       color: Colors.black,
//                       width: 1.0,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide(
//                       color: Color(0xFF4e4376),
//                       width: 2.0,
//                     ),
//                   ),
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: _isLoading
//                     ? const Center(child: CircularProgressIndicator())
//                     : SingleChildScrollView(
//                         child: PaginatedDataTable(
//                           columns: const [
//                             DataColumn(label: Text('ID')),
//                             DataColumn(label: Text('Main Type')),
//                             DataColumn(label: Text('Name')),
//                           ],
//                           source: _investmentDataSource!,
//                           rowsPerPage: 10,
//                         ),
//                       ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class InvestmentDataTableSource extends DataTableSource {
//   final List<Data> _investmentData;
//   final Function(Data) onRowTap;

//   InvestmentDataTableSource(this._investmentData, this.onRowTap);

//   @override
//   DataRow getRow(int index) {
//     final Data data = _investmentData[index];
//     String? type;
//     if (data.mainType == '11') {
//       type = 'Short term';
//     } else if (data.mainType == '12') {
//       type = 'Mid term';
//     } else if (data.mainType == '13') {
//       type = 'Long term';
//     } else {
//       type = 'Unknown';
//     }

//     return DataRow.byIndex(
//       index: index,
//       cells: [
//         DataCell(
//           Text(
//             data.id ?? 'N/A',
//             style: TextStyle(color: Colors.blue[800]),
//           ),
//           onTap: () => onRowTap(data),
//         ),
//         DataCell(
//           Text(type ?? 'N/A'),
//           onTap: () => onRowTap(data),
//         ),
//         DataCell(
//           Text(data.name ?? 'N/A'),
//           onTap: () => onRowTap(data),
//         ),
//       ],
//     );
//   }

//   @override
//   bool get isRowCountApproximate => false;
//   @override
//   int get rowCount => _investmentData.length;
//   @override
//   int get selectedRowCount => 0;
// }
