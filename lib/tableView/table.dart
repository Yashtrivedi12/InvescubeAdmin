// import 'package:http/http.dart' as http;
// import 'package:expandable_datatable/expandable_datatable.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:invescube_admin/Model/tradingModel.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late List<ExpandableColumn<dynamic>> headers;
//   late List<ExpandableRow> rows;
//   late List<ExpandableRow> filteredRows;
//   final TextEditingController _searchController = TextEditingController();
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchCalls();
//     _searchController.addListener(_filterData);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<void> fetchCalls() async {
//     const url = 'https://admin.invescube.com/admin_api/show_data.php';
//     const requestHeaders = {'Authorization': 'yp7280uvfkvdirgjkpo'};

//     try {
//       final response = await http.get(Uri.parse(url), headers: requestHeaders);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body)['data'];
//         final List<Call> callList =
//             data.map((item) => Call.fromMap(item)).toList();
//         createDataSource(callList);
//         setLoading(false);
//       } else {
//         print('Failed to fetch calls');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   void setLoading(bool isLoading) {
//     setState(() {
//       _isLoading = isLoading;
//     });
//   }

//   void createDataSource(List<Call> callList) {
//     headers = [
//       ExpandableColumn<String>(columnTitle: "ID", columnFlex: 1),
//       ExpandableColumn<String>(columnTitle: "Name", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "Type", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "Show Date", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "Time", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "Target 1", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "Target 2", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "Target 3", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "Stop Loss", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "TS 1", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "T1 TimeStamp", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "TS 2", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "T2 TimeStamp", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "TS 3", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "T3 TimeStamp", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "Stoploss Status", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "Call Status", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "Update On", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "Add date", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "Edit", columnFlex: 2),
//       ExpandableColumn<String>(columnTitle: "Delete", columnFlex: 2),
//     ];

//     rows = callList.map<ExpandableRow>((call) {
//       return ExpandableRow(cells: [
//         ExpandableCell<String>(columnTitle: "ID", value: call.id ?? ''),
//         ExpandableCell<String>(columnTitle: "Name", value: call.name ?? ''),
//         ExpandableCell<String>(columnTitle: "Type", value: call.type ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "Show Date", value: call.showDate ?? ''),
//         ExpandableCell<String>(columnTitle: "Time", value: call.time ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "Target 1", value: call.target ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "Target 2", value: call.target1 ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "Target 3", value: call.target2 ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "Stop Loss", value: call.stoploss ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "TS 1", value: call.targetStatus ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "T1 TimeStamp", value: call.t1Update ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "TS 2", value: call.target1Status ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "T2 TimeStamp", value: call.t2Update ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "TS 3", value: call.target2Status ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "T3 TimeStamp", value: call.t3Update ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "Stoploss Status", value: call.stoplossStatus ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "Call Status", value: call.callStatus ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "Update On", value: call.updateOn ?? ''),
//         ExpandableCell<String>(columnTitle: "Add date", value: call.date ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "Edit", value: call.exitStatus ?? ''),
//         ExpandableCell<String>(
//             columnTitle: "Delete", value: call.ifDelete ?? ''),
//       ]);
//     }).toList();
//     filteredRows = List.from(rows);
//     setState(() {}); // Ensure UI updates after creating the data source
//   }

//   void _filterData() {
//     String searchTerm = _searchController.text.toLowerCase();
//     setState(() {
//       filteredRows = rows.where((row) {
//         return row.cells.any((cell) {
//           return cell.value.toString().toLowerCase().contains(searchTerm);
//         });
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: const InputDecoration(
//                   labelText: 'Search',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : LayoutBuilder(
//                       builder: (context, constraints) {
//                         int visibleCount = 3;

//                         if (constraints.maxWidth < 600) {
//                           visibleCount = 3;
//                         } else if (constraints.maxWidth < 800) {
//                           visibleCount = 4;
//                         } else if (constraints.maxWidth < 1000) {
//                           visibleCount = 5;
//                         } else {
//                           visibleCount = 6;
//                         }
//                         return ExpandableTheme(
//                           data: ExpandableThemeData(
//                             context,
//                             contentPadding: const EdgeInsets.all(20),
//                             expandedBorderColor: Colors.transparent,
//                             paginationSize: 38,
//                             headerHeight: 56,
//                             headerBorder: const BorderSide(
//                               color: Colors.black,
//                               width: 1,
//                             ),
//                             evenRowColor: const Color(0xFFFFFFFF),
//                             rowBorder: const BorderSide(
//                               color: Colors.black,
//                               width: 0.3,
//                             ),
//                             headerTextMaxLines: 4,
//                             headerSortIconColor: const Color(0xFF6c59cf),
//                             paginationSelectedFillColor:
//                                 const Color(0xFF6c59cf),
//                             paginationSelectedTextColor: Colors.white,
//                           ),
//                           child: ExpandableDataTable(
//                             headers: headers,
//                             rows: filteredRows,
//                             multipleExpansion: false,
//                             isEditable: false,
//                             onRowChanged: (newRow) {
//                               print(newRow.cells[1].value);
//                             },
//                             onPageChanged: (page) {
//                               print(page);
//                             },
//                             renderEditDialog: (row, onSuccess) =>
//                                 _buildEditDialog(row, onSuccess),
//                             visibleColumnCount: visibleCount,
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEditDialog(
//       ExpandableRow row, Function(ExpandableRow) onSuccess) {
//     return AlertDialog(
//       title: SizedBox(
//         height: 300,
//         child: TextButton(
//           child: const Text("Change name"),
//           onPressed: () {
//             row.cells[1].value = "Updated Name";
//             onSuccess(row);
//           },
//         ),
//       ),
//     );
//   }
// }
