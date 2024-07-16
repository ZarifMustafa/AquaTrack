import 'package:flutter/material.dart';
import 'history_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Meter Details App',
    home: MeterDetailsPage(meterId: 'Meter 1'),
  ));
}

class MeterDetailsPage extends StatefulWidget {
  final String meterId;

  MeterDetailsPage({required this.meterId});

  @override
  _MeterDetailsPageState createState() => _MeterDetailsPageState();
}

class _MeterDetailsPageState extends State<MeterDetailsPage> {
  List<Map<String, dynamic>> residents = [
    {'flatNo': 'Flat 101', 'residentNo': 4, 'residentEmail': 'raisa@example.com', 'residentName': 'Raisa', 'role': 'Owner', 'usage': 120, 'date': DateTime(2023, 7, 1)},
    {'flatNo': 'Flat 101', 'residentNo': 3, 'residentEmail': 'zaarif@example.com', 'residentName': 'Zaarif', 'role': 'Tenant', 'usage': 150, 'date': DateTime(2023, 6, 1)},
    {'flatNo': 'Flat 101', 'residentNo': 2, 'residentEmail': 'rubaba@example.com', 'residentName': 'Rubaba', 'role': 'Owner', 'usage': 110, 'date': DateTime(2023, 5, 1)},
    {'flatNo': 'Flat 101', 'residentNo': 1, 'residentEmail': 'rubaid@example.com', 'residentName': 'Rubaid', 'role': 'Tenant', 'usage': 100, 'date': DateTime(2023, 4, 1)},
  ];

  void _addResident(Map<String, dynamic> newResident) {
    setState(() {
      int highestResidentNo = residents.fold<int>(0, (prev, element) => element['residentNo'] > prev ? element['residentNo'] : prev);
      newResident['residentNo'] = highestResidentNo + 1;

      residents.add(newResident);
      residents.sort((a, b) => b['residentNo'].compareTo(a['residentNo']));
    });
  }

  void _editResident(int index, Map<String, dynamic> editedResident) {
    setState(() {
      residents[index] = editedResident;
      residents.sort((a, b) => b['residentNo'].compareTo(a['residentNo']));
    });
  }

  void _deleteResident(int index) {
    setState(() {
      residents.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meter Details for ${widget.meterId}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.blue.shade400, Color.fromARGB(255, 130, 186, 221)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: residents.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Current Resident',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        _buildResidentCard(index),
                        if (residents.length > 1)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Past Residents',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                      ],
                    );
                  } else {
                    return _buildResidentCard(index);
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddResidentDialog(onAddResident: _addResident);
                  },
                );
              },
              child: Text('Add Resident'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildResidentCard(int index) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              residents[index]['flatNo'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Resident: ${residents[index]['residentName']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Resident No: ${residents[index]['residentNo']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Email: ${residents[index]['residentEmail']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Role: ${residents[index]['role']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Usage this month: ${residents[index]['usage']} units',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Date: ${residents[index]['date']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryPage(resident: residents[index]),
                      ),
                    );
                  },
                  child: Text('History'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _deleteResident(index);
                  },
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditResidentDialog(
                          resident: residents[index],
                          onEditResident: (editedResident) {
                            _editResident(index, editedResident);
                          },
                        );
                      },
                    );
                  },
                  child: Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddResidentDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddResident;

  AddResidentDialog({required this.onAddResident});

  @override
  _AddResidentDialogState createState() => _AddResidentDialogState();
}

class _AddResidentDialogState extends State<AddResidentDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _residentEmailController = TextEditingController();
  final TextEditingController _usageController = TextEditingController();
  String _role = 'Owner';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Resident'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _residentEmailController,
              decoration: InputDecoration(labelText: 'Resident Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter resident email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _usageController,
              decoration: InputDecoration(labelText: 'Usage this month'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter usage';
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              value: _role,
              decoration: InputDecoration(labelText: 'Role'),
              items: ['Owner', 'Tenant'].map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _role = newValue!;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newResident = {
                'flatNo': 'Flat 101',
                'residentEmail': _residentEmailController.text,
                'residentName': 'New Resident', // Placeholder name
                'role': _role,
                'usage': int.parse(_usageController.text),
                'date': DateTime.now(),
              };
              widget.onAddResident(newResident);
              Navigator.of(context).pop();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}

class EditResidentDialog extends StatefulWidget {
  final Map<String, dynamic> resident;
  final Function(Map<String, dynamic>) onEditResident;

  EditResidentDialog({required this.resident, required this.onEditResident});

  @override
  _EditResidentDialogState createState() => _EditResidentDialogState();
}

class _EditResidentDialogState extends State<EditResidentDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _residentEmailController;
  late TextEditingController _residentNameController;
  String _role = 'Owner';

  @override
  void initState() {
    super.initState();
    _residentEmailController = TextEditingController(text: widget.resident['residentEmail']);
    _residentNameController = TextEditingController(text: widget.resident['residentName']);
    _role = widget.resident['role'];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Resident'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _residentEmailController,
              decoration: InputDecoration(labelText: 'Resident Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter resident email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _residentNameController,
              decoration: InputDecoration(labelText: 'Resident Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter resident name';
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              value: _role,
              decoration: InputDecoration(labelText: 'Role'),
              items: ['Owner', 'Tenant'].map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _role = newValue!;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final editedResident = {
                'flatNo': widget.resident['flatNo'],
                'residentNo': widget.resident['residentNo'],
                'residentEmail': _residentEmailController.text,
                'residentName': _residentNameController.text,
                'role': _role,
                'usage': widget.resident['usage'],
                'date': widget.resident['date'],
              };
              widget.onEditResident(editedResident);
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
