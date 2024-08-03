import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:invescube_admin/302/addLease.dart';
import 'package:invescube_admin/302/addTenant.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class addLease extends StatefulWidget {
  const addLease({super.key});

  @override
  State<addLease> createState() => _addLeaseState();
}

class _addLeaseState extends State<addLease>
    with SingleTickerProviderStateMixin {
  bool InValid = false;

  bool isEnjoyNowSelected = true;
  bool isTenantSelected = true;
  String? _selectedProperty;
  String? _selectedLeaseType;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> _addRecurringFormKey = GlobalKey<FormState>();

  final TextEditingController Amount = TextEditingController();
  final TextEditingController rentAmount = TextEditingController();
  final TextEditingController rentNextDueDate = TextEditingController();
  final TextEditingController rentMemo = TextEditingController();
  final TextEditingController securityDepositeAmount = TextEditingController();
  final TextEditingController recurringContentAmount = TextEditingController();
  final TextEditingController recurringContentMemo = TextEditingController();
  final TextEditingController oneTimeContentMemo = TextEditingController();
  final TextEditingController oneTimeContentAmount = TextEditingController();
  final TextEditingController signatureController = TextEditingController();
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  String? _selectedRent;
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _endDate = TextEditingController();

  bool _selectedResidentsEmail = false; // Initialize the boolean variable

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
  ];
  String? selectedValue;
  List<File> _pdfFiles = [];

  Future<void> _pickPdfFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      List<File> files = result.paths
          .where((path) => path != null)
          .map((path) => File(path!))
          .toList();

      if (files.length > 10) {
        files = files.sublist(0, 10);
      }

      setState(() {
        _pdfFiles = files;
      });
    }
  }

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> _validateSignature() async {
    if (isTenantSelected) {
      // Check if the signature pad has any strokes
      final image = await _signaturePadKey.currentState!.toImage();
      final byteData = await image.toByteData();
      final buffer = byteData!.buffer.asUint8List();
      bool isEmpty = buffer.every((byte) => byte == 0);
      return !isEmpty;
    } else {
      // Check if the typed signature is empty
      if (signatureController.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate() && await _validateSignature()) {
      // Proceed with submission
      print("Signature validated and form submitted!");
    } else {
      // Show validation error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please provide either a drawn or typed signature.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Lease'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(21, 43, 83, 1),
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Property *',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(
                            height: 8,
                          ),
                          CustomDropdown(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a property';
                              }
                              return null;
                            },
                            labelText: 'Select Property',
                            items: items,
                            selectedValue: _selectedProperty,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedProperty = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Lease Type *',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(
                            height: 8,
                          ),
                          CustomDropdown(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a lease';
                              }
                              return null;
                            },
                            labelText: 'Select Lease',
                            items: items,
                            selectedValue: _selectedLeaseType,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedLeaseType = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Start Date *',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                                locale: Locale('en', 'US'),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Color.fromRGBO(21, 43, 83,
                                            1), // header background color
                                        onPrimary:
                                            Colors.white, // header text color
                                        onSurface: Color.fromRGBO(
                                            21, 43, 83, 1), // body text color
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Color.fromRGBO(21,
                                              43, 83, 1), // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                                setState(() {
                                  _startDate.text = formattedDate;
                                });
                              }
                            },
                            readOnnly: true,
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.date_range_rounded)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select start date';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            hintText: 'dd-mm-yyyy',
                            controller: _startDate,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('End Date *',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                                locale: Locale('en', 'US'),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Color.fromRGBO(21, 43, 83,
                                            1), // header background color
                                        onPrimary:
                                            Colors.white, // header text color
                                        onSurface: Color.fromRGBO(
                                            21, 43, 83, 1), // body text color
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Color.fromRGBO(21,
                                              43, 83, 1), // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                                setState(() {
                                  _endDate.text = formattedDate;
                                });
                              }
                            },
                            readOnnly: true,
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.date_range_rounded)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select end date';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            hintText: 'dd-mm-yyyy',
                            controller: _endDate,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(21, 43, 83, 1),
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text('Add lease',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF152b51))),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        contentPadding: EdgeInsets.zero,
                                        title: Text('Add Tenant or Cosigner',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF152b51))),
                                        content: Form(
                                          key: _addRecurringFormKey,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              color: Colors.white,
                                              width: double.infinity,
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  isTenantSelected =
                                                                      true;
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: isTenantSelected
                                                                      ? null
                                                                      : Border.all(
                                                                          color: Color.fromRGBO(
                                                                              21,
                                                                              43,
                                                                              83,
                                                                              1),
                                                                          width:
                                                                              1),
                                                                  gradient:
                                                                      isTenantSelected
                                                                          ? LinearGradient(
                                                                              colors: [
                                                                                Color.fromRGBO(21, 43, 83, 1),
                                                                                Color.fromRGBO(21, 43, 83, 1),
                                                                              ],
                                                                            )
                                                                          : null,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            4),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            4),
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: isTenantSelected
                                                                    ? EdgeInsets
                                                                        .symmetric(
                                                                            vertical:
                                                                                13)
                                                                    : EdgeInsets.symmetric(
                                                                        vertical:
                                                                            12),
                                                                child: isTenantSelected
                                                                    ? Text(
                                                                        "Tenant",
                                                                        style:
                                                                            TextStyle(
                                                                          color: !isTenantSelected
                                                                              ? Colors.transparent
                                                                              : Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      )
                                                                    : ShaderMask(
                                                                        shaderCallback:
                                                                            (bounds) {
                                                                          return LinearGradient(
                                                                            colors: [
                                                                              Color.fromRGBO(21, 43, 83, 1),
                                                                              Color.fromRGBO(21, 43, 83, 1),
                                                                            ],
                                                                          ).createShader(
                                                                              bounds);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Tenant",
                                                                          style:
                                                                              TextStyle(
                                                                            color: isTenantSelected
                                                                                ? Colors.transparent
                                                                                : Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  isTenantSelected =
                                                                      false;
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: isTenantSelected ==
                                                                          false
                                                                      ? null
                                                                      : Border.all(
                                                                          color: Color.fromRGBO(
                                                                              21,
                                                                              43,
                                                                              83,
                                                                              1),
                                                                          width:
                                                                              1),
                                                                  gradient: isTenantSelected ==
                                                                          false
                                                                      ? LinearGradient(
                                                                          colors: [
                                                                            Color.fromRGBO(
                                                                                21,
                                                                                43,
                                                                                83,
                                                                                1),
                                                                            Color.fromRGBO(
                                                                                21,
                                                                                43,
                                                                                83,
                                                                                1),
                                                                          ],
                                                                        )
                                                                      : null,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            4),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            4),
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: isTenantSelected
                                                                    ? EdgeInsets
                                                                        .symmetric(
                                                                            vertical:
                                                                                12)
                                                                    : EdgeInsets.symmetric(
                                                                        vertical:
                                                                            13),
                                                                child: !isTenantSelected
                                                                    ? Text(
                                                                        "Cosigner",
                                                                        style:
                                                                            TextStyle(
                                                                          color: isTenantSelected
                                                                              ? Colors.transparent
                                                                              : Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      )
                                                                    : ShaderMask(
                                                                        shaderCallback:
                                                                            (bounds) {
                                                                          return LinearGradient(
                                                                            colors: [
                                                                              Color.fromRGBO(21, 43, 83, 1),
                                                                              Color.fromRGBO(21, 43, 83, 1),
                                                                            ],
                                                                          ).createShader(
                                                                              bounds);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Cosigner",
                                                                          style:
                                                                              TextStyle(
                                                                            color: !isTenantSelected
                                                                                ? Colors.transparent
                                                                                : Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      isTenantSelected
                                                          ? AddTenant()
                                                          : AddCosigner(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          Container(
                                              height: 50,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Color(0xFF152b51),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0))),
                                                  onPressed: () {
                                                    if (_addRecurringFormKey
                                                        .currentState!
                                                        .validate()) {
                                                      print('object valid');
                                                    } else {
                                                      print('object invalid');
                                                    }
                                                  },
                                                  child: Text(
                                                    'Add',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFf7f8f9)),
                                                  ))),
                                          Container(
                                              height: 50,
                                              width: 94,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Color(0xFFffffff),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0))),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF748097)),
                                                  )))
                                        ],
                                      );
                                    });
                                  });
                            },
                            child: Text('+ Add Tenant or Cosigner',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2ec433))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(21, 43, 83, 1),
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text('Rent',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF152b51))),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Rent Cycle *',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(
                            height: 8,
                          ),
                          CustomDropdown(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a rent';
                              }
                              return null;
                            },
                            labelText: 'Select Rent',
                            items: items,
                            selectedValue: _selectedRent,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedRent = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Amount *',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter amount';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            hintText: 'Enter Amount',
                            controller: rentAmount,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Next Due Date',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                                locale: Locale('en', 'US'),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Color.fromRGBO(21, 43, 83,
                                            1), // header background color
                                        onPrimary:
                                            Colors.white, // header text color
                                        onSurface: Color.fromRGBO(
                                            21, 43, 83, 1), // body text color
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Color.fromRGBO(21,
                                              43, 83, 1), // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                                setState(() {
                                  rentNextDueDate.text = formattedDate;
                                });
                              }
                            },
                            readOnnly: true,
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.date_range_rounded)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select Next Due Date';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            hintText: 'dd-mm-yyyy',
                            controller: rentNextDueDate,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Memo',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter memo';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            hintText: 'Enter Memo',
                            controller: rentMemo,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(21, 43, 83, 1),
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text('Charges (Optional)',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF152b51))),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Add Charges',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(
                            height: 8,
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            contentPadding: EdgeInsets.zero,
                                            title: Text('Add Recurring content',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF152b51))),
                                            content: Form(
                                              key: _addRecurringFormKey,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  color: Colors.white,
                                                  height: InValid ? 336 : 280,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Property *',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.grey)),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      CustomDropdown(
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please select a property';
                                                          }
                                                          return null;
                                                        },
                                                        labelText:
                                                            'Select Property',
                                                        items: items,
                                                        selectedValue:
                                                            _selectedProperty,
                                                        onChanged:
                                                            (String? value) {
                                                          setState(() {
                                                            _selectedProperty =
                                                                value;
                                                          });
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text('Amount *',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.grey)),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      CustomTextField(
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter amount';
                                                          }
                                                          return null;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                        hintText:
                                                            'Enter Amount',
                                                        controller: rentAmount,
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text('Memo',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.grey)),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      CustomTextField(
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter memo';
                                                          }
                                                          return null;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                        hintText: 'Enter Memo',
                                                        controller: rentMemo,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              Container(
                                                  height: 50,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0)),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Color(0xFF152b51),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0))),
                                                      onPressed: () {
                                                        if (_addRecurringFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          setState(() {
                                                            InValid = false;
                                                          });
                                                          print('object valid');
                                                          setState(() {
                                                            InValid = true;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            InValid = true;
                                                          });
                                                          print(
                                                              'object invalid');
                                                        }
                                                      },
                                                      child: Text(
                                                        'Add',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFFf7f8f9)),
                                                      ))),
                                              Container(
                                                  height: 50,
                                                  width: 94,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0)),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Color(0xFFffffff),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0))),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF748097)),
                                                      )))
                                            ],
                                          );
                                        });
                                      });
                                },
                                child: Text(' + Add Recurring Charge',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2ec433))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            contentPadding: EdgeInsets.zero,
                                            title: Text(
                                                'Add One Time Charge Content',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF152b51))),
                                            content: Form(
                                              key: _addRecurringFormKey,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Container(
                                                  color: Colors.white,
                                                  height: InValid ? 336 : 280,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Property *',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.grey)),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      CustomDropdown(
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please select a property';
                                                          }
                                                          return null;
                                                        },
                                                        labelText:
                                                            'Select Property',
                                                        items: items,
                                                        selectedValue:
                                                            _selectedProperty,
                                                        onChanged:
                                                            (String? value) {
                                                          setState(() {
                                                            _selectedProperty =
                                                                value;
                                                          });
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text('Amount *',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.grey)),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      CustomTextField(
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter amount';
                                                          }
                                                          return null;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                        hintText:
                                                            'Enter Amount',
                                                        controller: rentAmount,
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text('Memo',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.grey)),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      CustomTextField(
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter memo';
                                                          }
                                                          return null;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                        hintText: 'Enter Memo',
                                                        controller: rentMemo,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              Container(
                                                  height: 50,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0)),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Color(0xFF152b51),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0))),
                                                      onPressed: () {
                                                        if (_addRecurringFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          setState(() {
                                                            InValid = false;
                                                          });
                                                          print('object valid');
                                                          setState(() {
                                                            InValid = true;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            InValid = true;
                                                          });
                                                          print(
                                                              'object invalid');
                                                        }
                                                      },
                                                      child: Text(
                                                        'Add',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFFf7f8f9)),
                                                      ))),
                                              Container(
                                                  height: 50,
                                                  width: 94,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0)),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Color(0xFFffffff),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0))),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF748097)),
                                                      )))
                                            ],
                                          );
                                        });
                                      });
                                },
                                child: Text(' + Add One Time Charge',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2ec433))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(21, 43, 83, 1),
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text('Security Deposit (Optional)',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF152b51))),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Amount',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter amount';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            hintText: 'Enter Amount',
                            controller: securityDepositeAmount,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                                'Don\'t forget to record the payment once you have connected the deposite',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(21, 43, 83, 1),
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text('Upload Files (Maximum of 10)',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF152b51))),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            width: 95,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF152b51),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () async {
                                await _pickPdfFiles();
                              },
                              child: Text(
                                'Upload',
                                style: TextStyle(color: Color(0xFFf7f8f9)),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Flexible(
                            fit: FlexFit.loose,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _pdfFiles.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                      _pdfFiles[index].path.split('/').last,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF748097))),
                                  trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _pdfFiles.removeAt(index);
                                        });
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.remove,
                                        color: Color(0xFF748097),
                                      )),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(21, 43, 83, 1),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'E-Signature',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF152b51),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 330, // Set a fixed height for TabBarView
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isEnjoyNowSelected = true;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: isEnjoyNowSelected
                                                ? null
                                                : Border.all(
                                                    color: Color.fromRGBO(
                                                        21, 43, 83, 1),
                                                    width: 1),
                                            gradient: isEnjoyNowSelected
                                                ? LinearGradient(
                                                    colors: [
                                                      Color.fromRGBO(
                                                          21, 43, 83, 1),
                                                      Color.fromRGBO(
                                                          21, 43, 83, 1),
                                                    ],
                                                  )
                                                : null,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          padding: isEnjoyNowSelected
                                              ? EdgeInsets.symmetric(
                                                  vertical: 13)
                                              : EdgeInsets.symmetric(
                                                  vertical: 12),
                                          child: isEnjoyNowSelected
                                              ? Text(
                                                  "Draw Signature",
                                                  style: TextStyle(
                                                    color: !isEnjoyNowSelected
                                                        ? Colors.transparent
                                                        : Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : ShaderMask(
                                                  shaderCallback: (bounds) {
                                                    return LinearGradient(
                                                      colors: [
                                                        Color.fromRGBO(
                                                            21, 43, 83, 1),
                                                        Color.fromRGBO(
                                                            21, 43, 83, 1),
                                                      ],
                                                    ).createShader(bounds);
                                                  },
                                                  child: Text(
                                                    "Draw Signature",
                                                    style: TextStyle(
                                                      color: isEnjoyNowSelected
                                                          ? Colors.transparent
                                                          : Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isEnjoyNowSelected = false;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: isEnjoyNowSelected == false
                                                ? null
                                                : Border.all(
                                                    color: Color.fromRGBO(
                                                        21, 43, 83, 1),
                                                    width: 1),
                                            gradient:
                                                isEnjoyNowSelected == false
                                                    ? LinearGradient(
                                                        colors: [
                                                          Color.fromRGBO(
                                                              21, 43, 83, 1),
                                                          Color.fromRGBO(
                                                              21, 43, 83, 1),
                                                        ],
                                                      )
                                                    : null,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          padding: isEnjoyNowSelected
                                              ? EdgeInsets.symmetric(
                                                  vertical: 12)
                                              : EdgeInsets.symmetric(
                                                  vertical: 13),
                                          child: !isEnjoyNowSelected
                                              ? Text(
                                                  "Type Signature",
                                                  style: TextStyle(
                                                    color: isEnjoyNowSelected
                                                        ? Colors.transparent
                                                        : Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : ShaderMask(
                                                  shaderCallback: (bounds) {
                                                    return LinearGradient(
                                                      colors: [
                                                        Color.fromRGBO(
                                                            21, 43, 83, 1),
                                                        Color.fromRGBO(
                                                            21, 43, 83, 1),
                                                      ],
                                                    ).createShader(bounds);
                                                  },
                                                  child: Text(
                                                    "Type Signature",
                                                    style: TextStyle(
                                                      color: !isEnjoyNowSelected
                                                          ? Colors.transparent
                                                          : Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                isEnjoyNowSelected
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 5),
                                          Container(
                                            height: 36,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              border: Border.all(width: 1),
                                            ),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                backgroundColor: Colors.white,
                                              ),
                                              onPressed: () {
                                                _signaturePadKey.currentState!
                                                    .clear();
                                              },
                                              child: Text('Clear'),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            child: SfSignaturePad(
                                              key: _signaturePadKey,
                                              strokeColor: Colors.black,
                                              backgroundColor: Colors.grey[200],
                                            ),
                                            height: 200,
                                            width: 300,
                                          ),
                                        ],
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: Container(
                                          height: 250,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(width: 1),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'please enter signature';
                                                    }
                                                    return null;
                                                  },
                                                  maxLength: 30,
                                                  decoration: InputDecoration(
                                                    hintText: 'Type Signature',
                                                    hintStyle: TextStyle(
                                                      color: Colors.grey[400],
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  controller:
                                                      signatureController,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      signatureController.text =
                                                          newValue;
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Container(
                                                child: Text(
                                                  '${signatureController.text}',
                                                  style:
                                                      GoogleFonts.dancingScript(
                                                    fontSize: 38,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(21, 43, 83, 1),
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Residents center Welcome Email',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF152b51))),
                              SizedBox(
                                width: 5,
                              ),
                              Switch(
                                activeColor: Color(0xFF152b51),
                                value: _selectedResidentsEmail,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedResidentsEmail = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'We send a welcome email to anyone without resident center access',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF748097))),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF67758e),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0))),
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    // If the form is valid, display a snackbar
                                    print('valid');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Processing Data')),
                                    );
                                  } else {
                                    print('invalid');
                                    _handleSubmit();
                                  }
                                },
                                child: Text(
                                  'Create Lease',
                                  style: TextStyle(color: Color(0xFFf7f8f9)),
                                ))),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFffffff),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0))),
                                onPressed: () {},
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Color(0xFF748097)),
                                )))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddTenant extends StatefulWidget {
  const AddTenant({super.key});

  @override
  State<AddTenant> createState() => _AddTenantState();
}

class _AddTenantState extends State<AddTenant> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController workNumber = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController alterEmail = TextEditingController();
  final TextEditingController passWord = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController taxPayerId = TextEditingController();
  final TextEditingController comments = TextEditingController();
  final TextEditingController contactName = TextEditingController();
  final TextEditingController relationToTenant = TextEditingController();
  final TextEditingController emergencyEmail = TextEditingController();
  final TextEditingController emergencyPhoneNumber = TextEditingController();
  bool _obscureText = true;
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.blue, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
    }
  }

  bool isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _showalterNumber = false;
  bool _showalterEmail = false;
  bool _showPersonalDetail = false;
  bool _showEmergancyDetail = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromRGBO(21, 43, 103, 1),
                border: Border.all(
                  color: Color.fromRGBO(21, 43, 83, 1),
                ),
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Contact information tenant',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white)),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text('First Name *',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  keyboardType: TextInputType.text,
                  hintText: 'Enter first name',
                  controller: firstName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the first name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Last Name *',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  keyboardType: TextInputType.text,
                  hintText: 'Enter last name',
                  controller: lastName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the last name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Phone Number *',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Enter phone number',
                  controller: phoneNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _showalterNumber = !_showalterNumber;
                    });
                  },
                  child: Text('+Add alternative Phone',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2ec433))),
                ),
                _showalterNumber
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text('Work Number',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              keyboardType: TextInputType.number,
                              hintText: 'Enter work number',
                              controller: workNumber,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                Text('Email *',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter Email',
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!isValidEmail(value)) {
                      print('!isValidEmail(value) invalid');
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _showalterEmail = !_showalterEmail;
                    });
                  },
                  child: Text('+Add alternative Email',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2ec433))),
                ),
                _showalterEmail
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text('Alternative Email',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Enter alternative email',
                              controller: alterEmail,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                Text('Password *',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        keyboardType: TextInputType.text,
                        obscureText: !_obscureText,
                        hintText: 'Enter password',
                        controller: passWord,
                        validator: (value) {
                          if (value == null) {
                            return 'please enter password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10), // Add some space between the widgets
                    Container(
                      width: 38,
                      height: 40,
                      child: Center(
                        child: GestureDetector(
                          onTap: _toggleObscureText,
                          child: FaIcon(
                            _obscureText
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(1.0, 1.0),
                            blurRadius: 8.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                        border: Border.all(width: 0, color: Colors.white),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _showPersonalDetail = !_showPersonalDetail;
              });
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(21, 43, 103, 1),
                  border: Border.all(
                    color: Color.fromRGBO(21, 43, 83, 1),
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('+    Personal Information',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ),
            ),
          ),
          _showPersonalDetail
              ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text('Date of Birth',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 46,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(1.0,
                                    1.0), // Shadow offset to the bottom right
                                blurRadius: 8.0, // How much to blur the shadow
                                spreadRadius:
                                    0.0, // How much the shadow should spread
                              ),
                            ],
                            border: Border.all(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.circular(6.0)),
                        child: TextFormField(
                          style: TextStyle(
                            color: Color(0xFF8898aa), // Text color
                            fontSize: 16.0, // Text size
                            fontWeight: FontWeight.w400, // Text weight
                          ),
                          controller: _dateController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xFFb0b6c3)),
                            border: InputBorder.none,
                            // labelText: 'Select Date',
                            hintText: 'dd-mm-yyyy',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                _selectDate(context);
                              },
                            ),
                          ),
                          readOnly: true,
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('TaxPayer ID',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      SizedBox(height: 10),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        hintText: 'Enter contact name',
                        controller: taxPayerId,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Comments',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 90,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(1.0,
                                    1.0), // Shadow offset to the bottom right
                                blurRadius: 8.0, // How much to blur the shadow
                                spreadRadius:
                                    0.0, // How much the shadow should spread
                              ),
                            ],
                            border: Border.all(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.circular(6.0)),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: comments,
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 13, color: Color(0xFFb0b6c3)),
                              hintText: 'Enter the comment',
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _showEmergancyDetail = !_showEmergancyDetail;
              });
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(21, 43, 103, 1),
                  border: Border.all(
                    color: Color.fromRGBO(21, 43, 83, 1),
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('+    Emergency Contact',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ),
            ),
          ),
          _showEmergancyDetail
              ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text('Contact Name',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        hintText: 'Enter contact name',
                        controller: contactName,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Relationship to Tenant',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        hintText: 'Enter relationship to tenant',
                        controller: relationToTenant,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('E-Mail',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Enter email',
                        controller: emergencyEmail,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Phone Number',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.number,
                        hintText: 'Enter phone number',
                        controller: emergencyPhoneNumber,
                      ),
                    ],
                  ),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class AddCosigner extends StatefulWidget {
  const AddCosigner({super.key});

  @override
  State<AddCosigner> createState() => _AddCosignerState();
}

class _AddCosignerState extends State<AddCosigner> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController workNumber = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController alterEmail = TextEditingController();
  final TextEditingController streetAddrees = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController postalCode = TextEditingController();
  bool _showalterNumber = false;
  bool _showalterEmail = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromRGBO(21, 43, 103, 1),
                border: Border.all(
                  color: Color.fromRGBO(21, 43, 83, 1),
                ),
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Contact information cosinger',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white)),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text('First Name *',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  keyboardType: TextInputType.text,
                  hintText: 'Enter first name',
                  controller: firstName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the first name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Last Name *',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  keyboardType: TextInputType.text,
                  hintText: 'Enter last name',
                  controller: lastName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the last name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Phone Number *',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Enter phone number',
                  controller: phoneNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _showalterNumber = !_showalterNumber;
                    });
                  },
                  child: Text('+Add alternative Phone',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2ec433))),
                ),
                _showalterNumber
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text('Work Number',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              keyboardType: TextInputType.number,
                              hintText: 'Enter work number',
                              controller: workNumber,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                Text('Email *',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter Email',
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _showalterEmail = !_showalterEmail;
                    });
                  },
                  child: Text('+Add alternative Email',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2ec433))),
                ),
                _showalterEmail
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text('Alternative Email',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Enter alternative email',
                              controller: alterEmail,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(21, 43, 83, 1)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('City',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  keyboardType: TextInputType.text,
                  hintText: 'Enter city',
                  controller: city,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the city';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Country',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  keyboardType: TextInputType.text,
                  hintText: 'Enter country',
                  controller: country,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter country';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Postal code',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Enter postal code',
                  controller: postalCode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter postal code';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
