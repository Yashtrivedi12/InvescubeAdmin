// import 'package:flutter/material.dart';
// import 'package:flutter_expandable_table/flutter_expandable_table.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:invescube_admin/Model/tradingModel.dart';
// import 'package:invescube_admin/screens/Trading/addTradingScreen.dart';
// import 'package:invescube_admin/screens/Trading/editTrading.dart';
// import 'package:invescube_admin/screens/Trading/tradinghistoryScreen.dart';
// import 'package:invescube_admin/screens/dashBoardScreen.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class TradingTableView extends StatefulWidget {
//   @override
//   State<TradingTableView> createState() => _TradingTableViewState();
// }

// class _TradingTableViewState extends State<TradingTableView> {
//   List<Data> dataList = []; // Your data list
//   List<Data> filteredList = []; // Filtered data list
//   int currentPage = 1;
//   int itemsPerPage = 10; // Number of items per page
//   TextEditingController searchController = TextEditingController();
//   String? _selectedType; // Variable to store the selected dropdown value
//   bool isLoading = true;

//   List<Map<String, String>> _dropdownItems = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromApi();
//     _fetchDropdownData(); // Fetch dropdown data
//   }

//   Future<void> _fetchDropdownData() async {
//     final url =
//         Uri.parse('https://admin.invescube.com/admin_api/show_trading_cat.php');
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
//     var url = Uri.parse('https://admin.invescube.com/admin_api/show_data.php');
//     var headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

//     try {
//       var response = await http.get(url, headers: headers);

//       if (response.statusCode == 200) {
//         // Parse the JSON response
//         Map<String, dynamic> responseData = json.decode(response.body);

//         // Extract data from JSON and populate dataList
//         if (responseData.containsKey('data')) {
//           List<dynamic> jsonData = responseData['data'];
//           print(jsonData);
//           setState(() {
//             dataList = jsonData.map((item) => Data.fromJson(item)).toList();
//             print(dataList);
//             filteredList = List<Data>.from(dataList);
//             isLoading =
//                 false; // Initially, filtered list is the same as data list
//           });
//         } else {
//           print('No data found in the response.');
//           setState(() {
//             isLoading = false; // No data found, set loading to false
//           });
//         }
//       } else {
//         // Handle error, show error message or retry mechanism
//         print('Failed to fetch data: ${response.statusCode}');
//         setState(() {
//           isLoading = false; // Error fetching data, set loading to false
//         });
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
//     request.fields['type'] = 'trading';

//     try {
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         print(' $id Item deleted successfully');
//         Fluttertoast.showToast(
//             msg: "Trade deleted successfully",
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

//   Future<void> closeCallItem(String id) async {
//     var url = Uri.parse('https://admin.invescube.com/admin_api/close_call.php');

//     var request = http.MultipartRequest('POST', url);

//     request.headers['Authorization'] = 'yp7280uvfkvdirgjkpo';
//     request.fields['t_id'] = id;
//     request.fields['type'] = 'trading';

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
//         title: const Text('Trading'),
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
//                               builder: (context) => TradingStockForm()));
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
//                               builder: (context) => TradingHistoryTable()));
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
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: isLoading // Check if data is still loading
//                     ? const Center(
//                         child:
//                             CircularProgressIndicator()) // Show loading indicator
//                     : ListView.builder(
//                         itemCount: paginatedData.length +
//                             1, // Add 1 for the pagination controls
//                         itemBuilder: (context, index) {
//                           if (index == paginatedData.length) {
//                             // Render pagination controls
//                             return buildPaginationControls();
//                           } else {
//                             return CustomTableRow(paginatedData[index],
//                                 deleteTableItem, closeCallItem);
//                           }
//                         },
//                       ),
//               ),
//             ),
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

//   CustomTableRow(this.rowData, this.deleteTableItem, this.closeCallItem);

//   @override
//   State<CustomTableRow> createState() => _CustomTableRowState();
// }

// class _CustomTableRowState extends State<CustomTableRow> {
//   void _callApiTarget1Status(String id) async {
//     var url = Uri.parse('https://admin.invescube.com/admin_api/update_t1.php');
//     var headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

//     var request = http.MultipartRequest('POST', url)
//       ..headers.addAll(headers)
//       ..fields['t_id'] = id.toString()
//       ..fields['type'] = 'trading'
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

//   void _callApiTarget2Status(String id) async {
//     var url = Uri.parse('https://admin.invescube.com/admin_api/update_t2.php');
//     var headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

//     var request = http.MultipartRequest('POST', url)
//       ..headers.addAll(headers)
//       ..fields['t_id'] = id.toString()
//       ..fields['type'] = 'trading'
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
//       ..fields['type'] = 'trading'
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
//         // ignore: use_build_context_synchronously
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
//       ..fields['type'] = 'trading'
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

//   String? selectedValue;
//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       title: Row(
//         children: [
//           Expanded(child: Text(widget.rowData.id!)),
//           Expanded(
//               child: Text(
//                   widget.rowData.mainType == '1' ? 'Intraday' : 'Positional')),
//           const SizedBox(
//             width: 12,
//           ),
//           Expanded(child: Text(widget.rowData.name!)),
//           const SizedBox(
//             width: 14,
//           ),
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
//         const SizedBox(
//           height: 10,
//         ),
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
//                             builder: (context) => EditTradingForm(
//                                   investmentData: widget.rowData!,
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

// trading_table_view.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invescube_admin/Model/tradingModel.dart';
import 'package:invescube_admin/screens/Trading/addTradingScreen.dart';
import 'package:invescube_admin/screens/Trading/editTrading.dart';
import 'package:invescube_admin/screens/Trading/tradinghistoryScreen.dart';

class TradingTableView extends StatefulWidget {
  @override
  State<TradingTableView> createState() => _TradingTableViewState();
}

class _TradingTableViewState extends State<TradingTableView> {
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
        title: const Text('Trading'),
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
                              builder: (context) => TradingStockForm()));
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
                              builder: (context) => TradingHistoryTable()));
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
                        'Id',
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
    final url = Uri.parse('${_baseUrl}show_data.php');

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
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }

  Future<List<Map<String, String>>> fetchDropdownData() async {
    final url = Uri.parse('${_baseUrl}show_trading_cat.php');

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
      ..fields['t_id'] = id
      ..fields['type'] = 'trading';

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
// custom_table_row.dart

class CustomTableRow extends StatefulWidget {
  final int index;
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
    return ExpansionTile(
      title: Row(
        children: [
          Expanded(child: Text('${widget.index + 1}')),
          Expanded(
              child: Text(
                  widget.rowData.mainType == '1' ? 'Intraday' : 'Positional')),
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
        const SizedBox(height: 20),
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
          const SizedBox(width: 38),
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
          const SizedBox(width: 10),
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
                builder: (context) => EditTradingForm(
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

class ApiService {
  static const String _authorizationHeader = 'yp7280uvfkvdirgjkpo';

  static Future<void> updateStatus(
      String id, String endpoint, BuildContext context) async {
    var url = Uri.parse('https://admin.invescube.com/admin_api/$endpoint');
    var headers = {'Authorization': _authorizationHeader};

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['t_id'] = id
      ..fields['type'] = 'trading'
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
          MaterialPageRoute(builder: (context) => TradingTableView()),
        );
      } else {
        print('Failed to call API: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API call: $e');
    }
  }
}










// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:invescube_admin/Model/tradingModel.dart';
// import 'package:invescube_admin/screens/Trading/addTradingScreen.dart';

// class tradingScreen extends StatefulWidget {
//   @override
//   _tradingScreenState createState() => _tradingScreenState();
// }

// class _tradingScreenState extends State<tradingScreen> {
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

//   Future<void> _fetchDropdownData() async {
//     final url =
//         Uri.parse('https://admin.invescube.com/admin_api/show_trading_cat.php');
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

//   Future<void> fetchData() async {
//     setState(() {
//       _isLoading = true; // Show loading indicator while fetching data
//     });

//     var url = Uri.parse('https://admin.invescube.com/admin_api/show_data.php');

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

//   String _getTypeValue(String type) {
//     switch (type) {
//       case 'intraday':
//         return '1';
//       case 'positional':
//         return '2';
//       default:
//         return '';
//     }
//   }

//   void deleteTableItem(String id) async {
//     var url =
//         Uri.parse('https://admin.invescube.com/admin_api/delete_data.php');

//     var request = http.MultipartRequest('POST', url);

//     request.headers['Authorization'] = 'yp7280uvfkvdirgjkpo';
//     request.fields['t_id'] = id;
//     request.fields['type'] = 'trading';

//     try {
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         print(' $id Item deleted successfully');
//         // Optionally, you can fetch the updated data to refresh the UI
//         Navigator.pop(context);

//         fetchData();
//       } else {
//         print('Failed to delete item');
//         // Handle error accordingly
//       }
//     } catch (e) {
//       print('Error while deleting item: $e');
//     }
//   }

//   void _showDetailsDialog(Data data) {
//     String? type;
//     if (data.mainType == '1') {
//       type = 'Intraday';
//     } else if (data.mainType == '2') {
//       type = 'Positional';
//     } else {
//       type = 'Unknown'; // Handle unknown types
//     }
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(data.name ?? 'Details'),
//           content: SingleChildScrollView(
//             child: Table(
//               border: TableBorder.all(width: 1),
//               children: [
//                 TableRow(children: [
//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text('No'),
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
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(data.targetStatus ?? ''),
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
//                   Text(data.exitStatus ?? ''),
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
//                     child: IconButton(
//                         onPressed: () {
//                           deleteTableItem(data.id.toString());
//                         },
//                         icon: const Icon(
//                           Icons.delete,
//                           color: Colors.red,
//                         )),
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
//         elevation: 1,
//         backgroundColor: Colors.white,
//         title: const Text('Trading'),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
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
//                                 builder: (context) => TradingStockForm()));
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
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => TradingStockForm()));
//                       },
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
//               const SizedBox(height: 12),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12.0),
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
//                     borderRadius: BorderRadius.circular(12.0),
//                     borderSide: BorderSide(
//                       color: Colors.black54,
//                       width: 1.0,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     borderSide: BorderSide(
//                       color: Colors.black,
//                       width: 1.0,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     borderSide: BorderSide(
//                       color: Color(0xFF4e4376),
//                       width: 2.0,
//                     ),
//                   ),
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Expanded(
//                 child: _isLoading
//                     ? const Center(
//                         child:
//                             CircularProgressIndicator()) // Show loading indicator
//                     : _investmentDataSource != null
//                         ? SingleChildScrollView(
//                             child: PaginatedDataTable(
//                               // columnSpacing: 112.12,
//                               // header: const Text('Trading Data'),
//                               columns: const [
//                                 DataColumn(label: Text('ID')),
//                                 DataColumn(label: Text('Main Type')),
//                                 DataColumn(label: Text('Name')),
//                               ],
//                               source: _investmentDataSource!,
//                               rowsPerPage: 12,
//                             ),
//                           )
//                         : const Center(
//                             child: Text('No data available.'),
//                           ),
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
//     if (data.mainType == '1') {
//       type = 'Intraday';
//     } else if (data.mainType == '2') {
//       type = 'Positional';
//     } else {
//       type = 'Unknown'; // Handle unknown types
//     }

//     return DataRow.byIndex(
//       index: index,
//       cells: [
//         DataCell(
//             Text(
//               data.id ?? '',
//               style: TextStyle(color: Colors.blue[800]),
//             ),
//             onTap: () => onRowTap(data)),
//         DataCell(Text(type), onTap: () => onRowTap(data)),
//         DataCell(Text(data.name ?? ''), onTap: () => onRowTap(data)),
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
