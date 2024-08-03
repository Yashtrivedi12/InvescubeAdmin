import 'package:device_preview/device_preview.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invescube_admin/Model/tradingModel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DataRow {
  final String field1;
  final String field2;
  final String field3;
  bool isExpanded;
  DataRow(this.field1, this.field2, this.field3, {this.isExpanded = false});
}

// class CustomExpansionTile extends StatefulWidget {
//   final DataRow data;
//   final int index;
//
//   CustomExpansionTile({required this.data, required this.index});
//
//   @override
//   _CustomExpansionTileState createState() => _CustomExpansionTileState();
// }
//
// class _CustomExpansionTileState extends State<CustomExpansionTile> {
//   late bool isExpanded;
//
//   @override
//   void initState() {
//     super.initState();
//     isExpanded = widget.data.isExpanded;
//   }
//   @override
//   Widget build(BuildContext context) {
//     final Color tileColor = widget.index % 2 == 0 ? Colors.blue : Colors.green;
//     return Container(
//       // color: tileColor,
//       decoration: BoxDecoration(
//         //color: Colors.blue,
//         border: Border.all(color: kColor),
//       ),
//       child: Column(
//         children: <Widget>[
//           Container(
//             child: ListTile(
//               contentPadding: EdgeInsets.zero,
//               leading: InkWell(
//                 onTap: () {
//                   setState(() {
//                     isExpanded = !isExpanded;
//                     widget.data.isExpanded = isExpanded;
//                   });
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(left: 7),
//                   child: isExpanded
//                       ? Padding(
//                     padding: const EdgeInsets.only(top: 7.0, bottom: 0),
//                     child: FaIcon(
//                       FontAwesomeIcons.sortUp,
//                       size: 20,
//                       color: Color.fromRGBO(21, 43, 83, 1),
//                     ),
//                   )
//                       : Padding(
//                     padding: const EdgeInsets.only(top: 0.0, bottom: 7),
//                     child:
//                     FaIcon(
//                       FontAwesomeIcons.sortDown,
//                       size: 20,
//                       color: Color.fromRGBO(21, 43, 83, 1),
//                     ),
//                   ),
//                 ),
//               ),
//               title: Padding(
//                 padding: const EdgeInsets.all(2.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Expanded(child: Text(widget.data.field1,style: TextStyle(color: kColor,fontWeight: FontWeight.bold,fontSize: 14),)),
//                     SizedBox(width: MediaQuery.of(context).size.width * .08,),
//                     // SizedBox(width: 5),
//                     Expanded(child: Text(widget.data.field2,style: TextStyle(color: kColor,fontWeight: FontWeight.bold,fontSize: 14),)),
//                     SizedBox(width: MediaQuery.of(context).size.width * .08,),
//                     // SizedBox(width: 5),
//                     Expanded(child: Text(widget.data.field3,style: TextStyle(color: kColor,fontWeight: FontWeight.bold,fontSize: 14),)),
//                     SizedBox(width: MediaQuery.of(context).size.width * .02,),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           if (isExpanded)
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//              // color: Colors.blue,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(child:  FaIcon(
//                           FontAwesomeIcons.sortDown,
//                           size: 50,
//                          color: Colors.transparent,
//                          // color: Color.fromRGBO(21, 43, 83, 1),
//                         ),),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Container(
//                                 margin: EdgeInsets.only(bottom: 8.0),
//                                 child: Text(
//                                   'Rental Owner Name: ${widget.data.field1}',
//                                   style: TextStyle(fontSize: 10,color: kColor),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(bottom: 8.0),
//                                 child: Text(
//                                   'Locality: ${widget.data.field2}',
//                                   style: TextStyle(fontSize: 10),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(bottom: 8.0),
//                                 child: Text(
//                                   'Phone No: ${widget.data.field3}',
//                                   style: TextStyle(fontSize: 10),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(bottom: 8.0),
//                                 child: Text(
//                                   'Last Updated At: ${widget.data.field3}',
//                                   style: TextStyle(fontSize: 10),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                          SizedBox(width: 5,),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Container(
//                                 margin: EdgeInsets.only(bottom: 8.0),
//                                 child: Text(
//                                   'Rental Company Name: ${widget.data.field1}',
//                                   style: TextStyle(fontSize: 10),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(bottom: 8.0),
//                                 child: Text(
//                                   'Primary E-mail: ${widget.data.field2}',
//                                   style: TextStyle(fontSize: 10),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(bottom: 8.0),
//                                 child: Text(
//                                   'Created At: ${widget.data.field3}',
//                                   style: TextStyle(fontSize: 10),
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width: 40,
//                           child: Column(
//                             children: [
//                               IconButton(
//                                 icon: FaIcon(
//                                   FontAwesomeIcons.edit,
//                                   size: 20,
//                                   color: Color.fromRGBO(21, 43, 83, 1),
//                                 ),
//                                 onPressed: () {
//                                   // Edit button logic
//                                 },
//                               ),
//                               IconButton(
//                                 icon: FaIcon(
//                                   FontAwesomeIcons.trashCan,
//                                   size: 20,
//                                   color: Color.fromRGBO(21, 43, 83, 1),
//                                 ),
//                                 onPressed: () {
//                                   // Delete button logic
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
// class CustomExpansionTile extends StatefulWidget {
//   final propertytype data;
//   final int index;
//
//   CustomExpansionTile({required this.data, required this.index});
//
//   @override
//   _CustomExpansionTileState createState() => _CustomExpansionTileState();
// }
//
// class _CustomExpansionTileState extends State<CustomExpansionTile> {
//
//   late bool isExpanded;
//   late Future<List<propertytype>> futurePropertyTypes;
//
//   @override
//   void initState() {
//     super.initState();
//     isExpanded = false; // Or use widget.data.isExpanded if needed
//   }
//   void handleEdit(propertytype property) async {
//     // Handle edit action
//     print('Edit ${property.sId}');
//     final result = await Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => Edit_property_type(
//               property: property,
//             )));
//     /* if (result == true) {
//       setState(() {
//         futurePropertyTypes = PropertyTypeRepository().fetchPropertyTypes();
//       });
//     }*/
//   }
//
//   void _showAlert(BuildContext context, String id) {
//     Alert(
//       context: context,
//       type: AlertType.warning,
//       title: "Are you sure?",
//       desc: "Once deleted, you will not be able to recover this property!",
//       style: AlertStyle(
//         backgroundColor: Colors.white,
//       ),
//       buttons: [
//         DialogButton(
//           child: Text(
//             "Cancel",
//             style: TextStyle(color: Colors.white, fontSize: 18),
//           ),
//           onPressed: () => Navigator.pop(context),
//           color: Colors.grey,
//         ),
//         DialogButton(
//           child: Text(
//             "Delete",
//             style: TextStyle(color: Colors.white, fontSize: 18),
//           ),
//           onPressed: () async {
//             var data = PropertyTypeRepository().DeletePropertyType(id: id);
//             // Add your delete logic here
//             setState(() {
//               futurePropertyTypes =
//                   PropertyTypeRepository().fetchPropertyTypes();
//             });
//             Navigator.pop(context);
//           },
//           color: Colors.red,
//         )
//       ],
//     ).show();
//   }
//   void handleDelete(propertytype property) {
//     _showAlert(context, property.propertyId!);
//     // Handle delete action
//     print('Delete ${property.sId}');
//   }
//   @override
//   Widget build(BuildContext context) {
//     return
//       Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blue),
//       ),
//       child: Column(
//         children: <Widget>[
//           ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: InkWell(
//               onTap: () {
//                 setState(() {
//                   isExpanded = !isExpanded;
//                 });
//               },
//               child:
//               Container(
//                 margin: EdgeInsets.only(left: 7),
//                 child:
//                 FaIcon(
//                   isExpanded ? FontAwesomeIcons.sortUp : FontAwesomeIcons.sortDown,
//                   size: 20,
//                   color: Color.fromRGBO(21, 43, 83, 1),
//                 ),
//               ),
//             ),
//             title: Padding(
//               padding: const EdgeInsets.all(2.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(
//                     child: Text(
//                      '${widget.data.propertyType}',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width * .08),
//                   Expanded(
//                     child: Text(
//                       '${widget.data.propertysubType}',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width * .08),
//                   Expanded(
//                     child: Text(
//                       // '${widget.data.createdAt}',
//                       formatDate('${widget.data.createdAt}'),
//
//                       style: TextStyle(
//                         color:Colors.blue,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width * .02),
//                 ],
//               ),
//             ),
//           ),
//           if (isExpanded)
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         FaIcon(
//                           isExpanded ? FontAwesomeIcons.sortUp : FontAwesomeIcons.sortDown,
//                           size: 50,
//                           color:Colors.transparent,
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text.rich(
//                                 TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: 'Updated At : ',
//                                       style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue), // Bold and black
//                                     ),
//                                     TextSpan(
//                                       text: ' ${widget.data.updatedAt}',
//                                       style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey), // Light and grey
//                                     ),
//                                   ],
//                                 ),
//                               ),
//
//                               // _buildInfoText('Rental Owner Name', widget.data.field1),
//                               // _buildInfoText('Locality', widget.data.field2),
//                               // _buildInfoText('Phone No', widget.data.field3),
//                               // _buildInfoText('Last Updated At', widget.data.field3),
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: 5),
//                         // Expanded(
//                         //   child: Column(
//                         //     crossAxisAlignment: CrossAxisAlignment.start,
//                         //     children: <Widget>[
//                         //       _buildInfoText('Rental Company Name', widget.data.field1),
//                         //       _buildInfoText('Primary E-mail', widget.data.field2),
//                         //       _buildInfoText('Created At', widget.data.field3),
//                         //     ],
//                         //   ),
//                         // ),
//                         Container(
//                           width: 40,
//                           child: Column(
//                             children: [
//                               IconButton(
//                                 icon: FaIcon(
//                                   FontAwesomeIcons.edit,
//                                   size: 20,
//                                   color: Color.fromRGBO(21, 43, 83, 1),
//                                 ),
//                                 onPressed: () {
//                                   handleEdit(widget.data);
//                                   },
//                               ),
//                               IconButton(
//                                 icon: FaIcon(
//                                   FontAwesomeIcons.trashCan,
//                                   size: 20,
//                                   color: Color.fromRGBO(21, 43, 83, 1),
//                                 ),
//                                 onPressed: () {
//                                   handleDelete(widget.data);
//                                     },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoText(String label, String value) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         '$label: $value',
//         style: TextStyle(fontSize: 10, color: Colors.black),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: true,
//       tools: [
//         ...DevicePreview.defaultTools,
//       ],
//       builder: (context) => ExpandTable(),
//     ),
//   );
// }
// class ExpandTable extends StatefulWidget {
//   @override
//   State<ExpandTable> createState() => _ExpandTableState();
// }
//
// class _ExpandTableState extends State<ExpandTable> {
//   final List<DataRow> data = [
//
//     DataRow('Value 1', 'Value 2', 'Value 3'),
//     DataRow('Longer Value 1', 'Value 2', 'Another Long Value 3'),
//     DataRow('Value 1', 'Another Value 2', 'Value 3'),
//   ];
//
//   int index = 0;
//   bool isSort = false;
//   bool isSort1 = false;
//   bool isSort2 = false;
//   bool isSort3 = false;
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Custom Expansion Table'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListView(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: kColor,
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(14),topRight: Radius.circular(14)), // Change this value to set the desired radius
//                 ),
//                 child: ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   leading:  InkWell(
//                     child: Container(
//                       child: Icon(
//                         Icons.expand_less ,
//                         color: Colors.transparent,
//                       ),
//
//                     ),
//                   ),
//                   //  minLeadingWidth: 0, // Removes space between leading icon and title
//                   //visualDensity: VisualDensity(horizontal: -4, vertical: 0), // Adjusts the horizontal space
//
//                   title: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Expanded(
//                         child: InkWell(
//                           onTap: (){
//                             setState(() {
//                               isSort1 = !isSort1;
//                             });
//                             },
//                           child: Row(
//
//                             children: [
//                               Text("Property", style: TextStyle(color: Colors.white)),
//                               SizedBox(width: 3,),
//                               isSort1  ?
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 7.0,bottom: 0),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.sortUp,
//                                   size: 20,
//                                   color: Colors.white,
//                                 ),
//                               ):
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 0.0,bottom: 7),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.sortDown,
//                                   size: 20,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: InkWell(
//                           onTap: (){
//                             setState(() {
//                               isSort2 = !isSort2;
//                             });
//                           },
//                           child: Row(
//                             children: [
//                               width  < 400 ?   Text("Property \n Type", style: TextStyle(color: Colors.white))  :Text("Property Type", style: TextStyle(color: Colors.white)),
//                               SizedBox(width: 3,),
//                               isSort2  ?
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 7.0,bottom: 0),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.sortUp,
//                                   size: 20,
//                                   color: Colors.white,
//                                 ),
//                               ):
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 0.0,bottom: 7),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.sortDown,
//                                   size: 20,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: InkWell(
//                           onTap: (){
//                             setState(() {
//                               isSort3 = !isSort3;
//                             });
//                           },
//                           child: Row(
//                             children: [
//                               Text("Subtypes", style: TextStyle(color: Colors.white)),
//                               SizedBox(width: 3,),
//                               isSort3  ?
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 7.0,bottom: 0),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.sortUp,
//                                   size: 20,
//                                   color: Colors.white,
//                                 ),
//                               ):
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 0.0,bottom: 7),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.sortDown,
//                                   size: 20,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20,),
//               Container(
//                 decoration: BoxDecoration(
//                     border:Border.all(color:kColor )
//                 ),
//                 child: Column(
//                   children: data.map((dataRow) => CustomExpansionTile(data: dataRow,index: index++,)).toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ExpandTable extends StatefulWidget {
  @override
  State<ExpandTable> createState() => _ExpandTableState();
}

class _ExpandTableState extends State<ExpandTable> {
  late Future<List<Data>> futureData;
  late bool isExpanded;
  int? expandedIndex;
  String? selectedValue;
  final List<String> items = ['Residential', "Commercial", "All"];

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
    isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Data>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data available'));
              } else {
                final data = snapshot.data!;
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () async {},
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(21, 43, 81, 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Add New Property",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.034,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          height: 50.0,
                          padding: EdgeInsets.only(top: 8, left: 10),
                          width: MediaQuery.of(context).size.width * .91,
                          margin: const EdgeInsets.only(
                              bottom: 6.0), // Same as `blurRadius` i guess
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color.fromRGBO(21, 43, 81, 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), // (x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Text(
                            "Property Type",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      child: Row(
                        children: [
                          SizedBox(width: 5),
                          Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(2),
                            child: Container(
                              height: 40,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(color: Color(0xFF8A95A8))),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      cursorColor:
                                          Color.fromRGBO(21, 43, 81, 1),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Search here...",
                                        hintStyle: TextStyle(
                                          color: Color(0xFF8A95A8),
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          DropdownButtonHideUnderline(
                            child: Material(
                              elevation: 3,
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: const Row(
                                  children: [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Type',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF8A95A8),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: items
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 40,
                                  width: 160,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                      color: Color(0xFF8A95A8),
                                    ),
                                    color: Colors.white,
                                  ),
                                  elevation: 0,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  offset: const Offset(-20, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness: MaterialStateProperty.all(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildHeader(),
                    SizedBox(height: 20),
                    Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.blue)),
                      child: Column(
                        children: data.asMap().entries.map((entry) {
                          int index = entry.key;
                          Data dataItem = entry.value;
                          bool isExpanded = expandedIndex == index;
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isExpanded = !isExpanded;
                                        if (isExpanded) {
                                          expandedIndex = null;
                                        } else {
                                          expandedIndex = index;
                                        }
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 5),
                                      padding: !isExpanded
                                          ? EdgeInsets.only(bottom: 10)
                                          : EdgeInsets.only(top: 10),
                                      child: FaIcon(
                                        isExpanded
                                            ? FontAwesomeIcons.sortUp
                                            : FontAwesomeIcons.sortDown,
                                        size: 20,
                                        color: Color.fromRGBO(21, 43, 83, 1),
                                      ),
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            dataItem.mainType,
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .08),
                                        Expanded(
                                          child: Text(
                                            dataItem.subTypes.join(', '),
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .08),
                                        Expanded(
                                          child: Text(
                                            dataItem.createdAt,
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .02),
                                      ],
                                    ),
                                  ),
                                ),
                                if (isExpanded)
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              FaIcon(
                                                isExpanded
                                                    ? FontAwesomeIcons.sortUp
                                                    : FontAwesomeIcons.sortDown,
                                                size: 50,
                                                color: Colors.transparent,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Updated At : ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                          TextSpan(
                                                            text: dataItem
                                                                .updatedAt,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Sample Header : ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                          TextSpan(
                                                            text: dataItem
                                                                .sampleData,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Sample Header : ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                          TextSpan(
                                                            text: dataItem
                                                                .sampleData,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Sample Header: ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                          TextSpan(
                                                            text: dataItem
                                                                .sampleData,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Sample Header : ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                          TextSpan(
                                                            text: dataItem
                                                                .sampleData,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Sample Header : ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                          TextSpan(
                                                            text: dataItem
                                                                .sampleData,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 40,
                                                child: Column(
                                                  children: [
                                                    IconButton(
                                                      icon: FaIcon(
                                                        FontAwesomeIcons.edit,
                                                        size: 20,
                                                        color: Color.fromRGBO(
                                                            21, 43, 83, 1),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                    IconButton(
                                                      icon: FaIcon(
                                                        FontAwesomeIcons
                                                            .trashCan,
                                                        size: 20,
                                                        color: Color.fromRGBO(
                                                            21, 43, 83, 1),
                                                      ),
                                                      onPressed: () {
                                                        //handleDelete(dataItem);
                                                        // _showAlert(
                                                        //     context,
                                                        //     dataItem
                                                        //         .propertyId!);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          child: Icon(
            Icons.expand_less,
            color: Colors.transparent,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    // Sorting logic here
                  });
                },
                child: Row(
                  children: [
                    width < 400
                        ? Text("Main Type ",
                            style: TextStyle(color: Colors.white))
                        : Text("Main Type",
                            style: TextStyle(color: Colors.white)),
                    SizedBox(width: 3),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7, left: 2),
                      child: FaIcon(
                        FontAwesomeIcons.sortDown,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    // Sorting logic here
                  });
                },
                child: Row(
                  children: [
                    Text("Subtypes", style: TextStyle(color: Colors.white)),
                    SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7, left: 2),
                      child: FaIcon(
                        FontAwesomeIcons.sortDown,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    // Sorting logic here
                  });
                },
                child: Row(
                  children: [
                    Text("Created At", style: TextStyle(color: Colors.white)),
                    SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7, left: 2),
                      child: FaIcon(
                        FontAwesomeIcons.sortDown,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Data {
  final String mainType;
  final List<String> subTypes;
  final String createdAt;
  final String updatedAt;
  final String sampleData;

  Data(
      {required this.mainType,
      required this.subTypes,
      required this.createdAt,
      required this.updatedAt,
      required this.sampleData});
}

Future<List<Data>> fetchData() async {
  // Simulate network delay
  await Future.delayed(Duration(seconds: 2));

  // Mock data
  return [
    Data(
      mainType: "Type 1",
      subTypes: ["Subtype A", "Subtype B"],
      createdAt: "2022-01-01",
      updatedAt: "2022-01-02",
      sampleData: "Sample Data 1",
    ),
    Data(
      mainType: "Type 2",
      subTypes: ["Subtype C", "Subtype D"],
      createdAt: "2022-02-01",
      updatedAt: "2022-02-02",
      sampleData: "Sample Data 2",
    ),
    // Add more data as needed
  ];
}
