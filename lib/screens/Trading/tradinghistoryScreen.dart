import 'package:flutter/material.dart';
import 'package:flutter_expandable_table/flutter_expandable_table.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invescube_admin/Model/tradingModel.dart';
import 'package:invescube_admin/screens/Trading/addTradingScreen.dart';
import 'package:invescube_admin/screens/dashBoardScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TradingHistoryTable extends StatefulWidget {
  @override
  State<TradingHistoryTable> createState() => _TradingHistoryTableState();
}

class _TradingHistoryTableState extends State<TradingHistoryTable> {
  List<Data> dataList = []; // Your data list
  List<Data> filteredList = []; // Filtered data list
  int currentPage = 1;
  int itemsPerPage = 10; // Number of items per page
  TextEditingController searchController = TextEditingController();
  String? _selectedType; // Variable to store the selected dropdown value

  List<Map<String, String>> _dropdownItems = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
    _fetchDropdownData(); // Fetch dropdown data
  }

  Future<void> _fetchDropdownData() async {
    final url =
        Uri.parse('https://admin.invescube.com/admin_api/show_trading_cat.php');
    final headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

    try {
      final response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        print(jsonData);
        final List<Map<String, String>> parsedData = jsonData.map((item) {
          return {
            'id': item['id'].toString(),
            'name': item['name'] as String,
          };
        }).toList();
        setState(() {
          _dropdownItems = parsedData;
        });
      } else {
        throw Exception('Failed to load dropdown data');
      }
    } catch (e) {
      print('Error fetching dropdown data: $e');
    }
  }

  Future<void> fetchDataFromApi() async {
    var url =
        Uri.parse('https://admin.invescube.com/admin_api/trading_history.php');
    var headers = {'Authorization': 'yp7280uvfkvdirgjkpo'};

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> responseData = json.decode(response.body);

        // Extract data from JSON and populate dataList
        if (responseData.containsKey('data')) {
          List<dynamic> jsonData = responseData['data'];
          setState(() {
            dataList = jsonData.map((item) => Data.fromJson(item)).toList();
            filteredList = List<Data>.from(
                dataList); // Initially, filtered list is the same as data list
          });
        } else {
          print('No data found in the response.');
        }
      } else {
        // Handle error, show error message or retry mechanism
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      print('Error fetching data: $e');
    }
  }

  Future<void> deleteTableItem(String id) async {
    var url =
        Uri.parse('https://admin.invescube.com/admin_api/delete_history.php');

    var request = http.MultipartRequest('POST', url);

    request.headers['Authorization'] = 'yp7280uvfkvdirgjkpo';

    request.fields['t_id'] = id;
    request.fields['type'] = 'trading';

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print(' $id Item deleted successfully');
        Fluttertoast.showToast(
            msg: "Trade deleted successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          dataList.removeWhere((item) => item.id == id);
          filteredList.removeWhere((item) => item.id == id);
        });

        // Optionally, you can fetch the updated data to refresh the UI
      } else {
        print('Failed to delete item');
        // Handle error accordingly
      }
    } catch (e) {
      print('Error while deleting item: $e');
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
        title: const Text('Trading History'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
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
                          filterData(searchController
                              .text); // Call filter with search query
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
                    SizedBox(
                      width: 10,
                    ),
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
                child: ListView.builder(
                  itemCount: paginatedData.length + 1,
                  itemBuilder: (context, index) {
                    if (index == paginatedData.length) {
                      return buildPaginationControls();
                    } else {
                      return CustomTableRow(
                          index, paginatedData[index], deleteTableItem);
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
      print(_selectedType);
      if (query.isEmpty && _selectedType == null) {
        // If both search query and dropdown selection are empty, show all data
        filteredList = dataList;
      } else {
        // Filter data based on the search query and dropdown selection
        filteredList = dataList.where((data) {
          return (query.isEmpty ||
                  data.id!.toLowerCase().contains(query.toLowerCase()) ||
                  data.mainType!.toLowerCase().contains(query.toLowerCase()) ||
                  data.name!.toLowerCase().contains(query.toLowerCase())) &&
              (_selectedType == null || data.mainType == _selectedType);
        }).toList();
      }
      // Reset pagination to the first page when filtering
      currentPage = 1;
    });
  }
}

class CustomTableRow extends StatefulWidget {
  final int index;
  final Data rowData;
  final Future<void> Function(String id) deleteTableItem;

  CustomTableRow(this.index, this.rowData, this.deleteTableItem);

  @override
  State<CustomTableRow> createState() => _CustomTableRowState();
}

class _CustomTableRowState extends State<CustomTableRow> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text('${widget.index + 1}')),
              Expanded(
                  child: Text(widget.rowData.mainType == '1'
                      ? 'Intraday'
                      : 'Positional')),
              SizedBox(
                width: 20,
              ),
              Expanded(child: Text(widget.rowData.name!)),
              // const Icon(Icons.arrow_drop_down),
            ],
          ),
        ],
      ),
      children: <Widget>[
        SizedBox(
          height: 35,
          child: ListTile(
            title: const Text(
              'Show Date',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.showDate!,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'Time',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.time ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'Type',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.type ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'Target 1',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.target ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'Target 2',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.target1 ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'Target 3',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.target2 ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'Stop Loss',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.target ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),

        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'TS 1',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.targetStatus! ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),

        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'T1 TimeStamp',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.t1Update ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),

        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'TS 2',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.target1Status! ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),

        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'T2 TimeStamp',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.t2Update ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'TS 3',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.target2Status! ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),

        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'T3 TimeStamp',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.t3Update ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'SL Status',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.stoplessStatus ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'SL Update',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.spUpdate ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        // SizedBox(
        //   height: 40,
        //   child: ListTile(
        //     title: Text(
        //       'Close Call',
        //       style: TextStyle(fontWeight: FontWeight.w500),
        //     ),
        //     trailing: Text(
        //       widget.rowData.exitStatus ?? 'N/A',
        //       style: TextStyle(fontSize: 16),
        //     ),
        //   ),
        // ),

        const SizedBox(
          height: 45,
          child: ListTile(
            title: Text(
              'Close Call',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),

        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text(
              'Add date',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              widget.rowData.date ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),

        SizedBox(
          height: 50,
          child: ListTile(
              title: const Text(
                'Delete',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: IconButton(
                  onPressed: () async {
                    await widget.deleteTableItem(widget.rowData.id!);
                  },
                  icon: const Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                  ))),
        ),
      ],
    );
  }
}
