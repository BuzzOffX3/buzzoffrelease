import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientFormPage extends StatefulWidget {
  const PatientFormPage({super.key});

  @override
  State<PatientFormPage> createState() => _PatientFormPageState();
}

class _PatientFormPageState extends State<PatientFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? type;
  String? gender;
  bool isPregnant = false;

  DateTime? dateOfAdmit;
  DateTime? dateOfBirth;
  DateTime? dueDate;

  String ageUnit = 'Years';
  final ageController = TextEditingController();
  final remarksController = TextEditingController();
  final medicineController = TextEditingController();

  Future<void> _pickDate(
    BuildContext context,
    ValueChanged<DateTime?> onPicked,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2025, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      onPicked(picked);
    }
  }

  Widget _buildTextField(
    String hint, {
    TextInputType? type,
    int maxLines = 1,
    bool expands = false,
  }) {
    return TextFormField(
      keyboardType: type,
      maxLines: maxLines,
      expands: expands,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildDateField(
    String label,
    DateTime? value,
    void Function(DateTime?) onPicked,
  ) {
    return InkWell(
      onTap: () => _pickDate(context, onPicked),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          value != null
              ? DateFormat('dd/MM/yyyy').format(value)
              : 'Select date',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // Left Navigation
          Container(
            width: 80,
            color: const Color(0xFF1C1C1E),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image.asset('images/logo.png', width: 40),
                const SizedBox(height: 20),
                navItem('images/patient_form_icon.png', selected: true),
                navItem('images/map_icon.png'),
                navItem('images/patient_management_icon.png'),
                navItem('images/analytics_icon.png'),
              ],
            ),
          ),

          // Right Form Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Welcome!",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('images/pfp.png'),
                        radius: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Patient Form",
                    style: TextStyle(color: Color(0xFFD9B4FF), fontSize: 22),
                  ),
                  const SizedBox(height: 20),

                  // Form Start
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        _buildTextField("Full Name"),
                                        const SizedBox(height: 10),
                                        _buildTextField("Hospital/MOH Area"),
                                        const SizedBox(height: 10),
                                        _buildTextField(
                                          "Hospital ID",
                                          type: TextInputType.number,
                                        ),
                                        const SizedBox(height: 20),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "TYPE",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            radioOption("New", "New"),
                                            radioOption(
                                              "Transferred",
                                              "Transferred",
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _buildTextField(
                                                "Ward No.",
                                                type: TextInputType.number,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: _buildTextField(
                                                "Bed No.",
                                                type: TextInputType.number,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        _buildDateField(
                                          "Date of Admit",
                                          dateOfAdmit,
                                          (val) =>
                                              setState(() => dateOfAdmit = val),
                                        ),
                                        const SizedBox(height: 20),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "GENDER",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            radioOption("Male", "Male"),
                                            radioOption("Female", "Female"),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        _buildDateField(
                                          "Date of Birth",
                                          dateOfBirth,
                                          (val) =>
                                              setState(() => dateOfBirth = val),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: TextFormField(
                                                controller: ageController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  hintText: "Age",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              flex: 2,
                                              child:
                                                  DropdownButtonFormField<
                                                    String
                                                  >(
                                                    value: ageUnit,
                                                    items: const [
                                                      DropdownMenuItem(
                                                        value: "Years",
                                                        child: Text("Years"),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: "Months",
                                                        child: Text("Months"),
                                                      ),
                                                    ],
                                                    onChanged: (val) =>
                                                        setState(
                                                          () => ageUnit = val!,
                                                        ),
                                                    decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        _buildTextField("Home Address"),
                                        const SizedBox(height: 10),
                                        _buildTextField("School/ Work Address"),
                                        const SizedBox(height: 10),
                                        _buildTextField(
                                          "Phone No.",
                                          type: TextInputType.phone,
                                        ),
                                        const SizedBox(height: 10),
                                        _buildTextField(
                                          "Email",
                                          type: TextInputType.emailAddress,
                                        ),
                                        const SizedBox(height: 10),
                                        _buildTextField("Guardian Name"),
                                        const SizedBox(height: 10),
                                        _buildTextField(
                                          "Guardian Contact No.",
                                          type: TextInputType.number,
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          controller: remarksController,
                                          maxLines: 4,
                                          decoration: InputDecoration(
                                            hintText: "Remarks",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          controller: medicineController,
                                          maxLines: null,
                                          minLines: 2,
                                          keyboardType: TextInputType.multiline,
                                          decoration: InputDecoration(
                                            hintText: "Prescribed Medicine",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: isPregnant,
                                              onChanged: (val) => setState(
                                                () => isPregnant = val!,
                                              ),
                                            ),
                                            const Text(
                                              "Pregnant",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _buildTextField(
                                                "Weeks Pregnant",
                                                type: TextInputType.number,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: _buildDateField(
                                                "Due Date",
                                                dueDate,
                                                (val) => setState(
                                                  () => dueDate = val,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF9A6AFF),
                                  ),
                                  onPressed: () {},
                                  child: const Text("SUBMIT"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navItem(String assetPath, {bool selected = false}) {
    return Container(
      color: selected ? Colors.black : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Image.asset(
        assetPath,
        width: 30,
        height: 30,
        color: Colors.white.withOpacity(selected ? 1.0 : 0.6),
      ),
    );
  }

  Widget radioOption(String value, String label) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: value == "Male" || value == "Female" ? gender : type,
          onChanged: (val) {
            setState(() {
              if (value == "Male" || value == "Female") {
                gender = val!;
              } else {
                type = val!;
              }
            });
          },
        ),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
