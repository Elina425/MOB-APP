import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const GradeCalculatorApp());
}

class GradeCalculatorApp extends StatelessWidget {
  const GradeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Grade Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const GradeCalculatorPage(),
    );
  }
}

class GradeCalculatorPage extends StatefulWidget {
  const GradeCalculatorPage({super.key});

  @override
  State<GradeCalculatorPage> createState() => _GradeCalculatorPageState();
}

class _GradeCalculatorPageState extends State<GradeCalculatorPage> {
  final TextEditingController participationController =
  TextEditingController(text: "100");
  final TextEditingController midterm1Controller =
  TextEditingController(text: "100");
  final TextEditingController midterm2Controller =
  TextEditingController(text: "100");
  final TextEditingController groupPresentationController =
  TextEditingController(text: "100");
  final TextEditingController finalProjectController =
  TextEditingController(text: "100");

  List<TextEditingController> homeworkControllers = [];

  double finalGrade = 0.0;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();

    participationController.text =
        (prefs.getDouble('participation') ?? 100).toString();
    midterm1Controller.text = (prefs.getDouble('midterm1') ?? 100).toString();
    midterm2Controller.text = (prefs.getDouble('midterm2') ?? 100).toString();
    groupPresentationController.text =
        (prefs.getDouble('groupPresentation') ?? 100).toString();
    finalProjectController.text =
        (prefs.getDouble('finalProject') ?? 100).toString();

    List<String>? savedHomeworks = prefs.getStringList('homeworks');
    if (savedHomeworks == null || savedHomeworks.isEmpty) {
      homeworkControllers = List.generate(
        4,
            (_) => TextEditingController(text: "100"),
      );
    } else {
      homeworkControllers = savedHomeworks
          .map((value) => TextEditingController(text: value))
          .toList();
    }

    setState(() {});
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(
        'participation', double.tryParse(participationController.text) ?? 0);
    await prefs.setDouble(
        'midterm1', double.tryParse(midterm1Controller.text) ?? 0);
    await prefs.setDouble(
        'midterm2', double.tryParse(midterm2Controller.text) ?? 0);
    await prefs.setDouble('groupPresentation',
        double.tryParse(groupPresentationController.text) ?? 0);
    await prefs.setDouble(
        'finalProject', double.tryParse(finalProjectController.text) ?? 0);

    List<String> homeworks =
    homeworkControllers.map((c) => c.text.trim()).toList();
    await prefs.setStringList('homeworks', homeworks);
  }

  void _calculateFinalGrade() {
    double participation =
        double.tryParse(participationController.text) ?? 0.0;
    double midterm1 = double.tryParse(midterm1Controller.text) ?? 0.0;
    double midterm2 = double.tryParse(midterm2Controller.text) ?? 0.0;
    double groupPresentation =
        double.tryParse(groupPresentationController.text) ?? 0.0;
    double finalProject =
        double.tryParse(finalProjectController.text) ?? 0.0;

    List<double> homeworkGrades = homeworkControllers
        .map((c) => double.tryParse(c.text) ?? 0.0)
        .toList();

    double avgHomework = homeworkGrades.isEmpty
        ? 0
        : homeworkGrades.reduce((a, b) => a + b) / homeworkGrades.length;

    finalGrade = participation * 0.1 +
        avgHomework * 0.2 +
        groupPresentation * 0.1 +
        midterm1 * 0.1 +
        midterm2 * 0.2 +
        finalProject * 0.3;

    _saveData();
    setState(() {});
  }

  void _addHomework() {
    setState(() {
      homeworkControllers.add(TextEditingController(text: "100"));
    });
  }

  void _resetHomeworks() {
    setState(() {
      homeworkControllers =
          List.generate(4, (_) => TextEditingController(text: "100"));
    });
  }

  Widget _buildHomeworkFields() {
    return Column(
      children: [
        for (int i = 0; i < homeworkControllers.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0), // Adds vertical spacing
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: homeworkControllers[i],
                    decoration: InputDecoration(
                      labelText: "Homework ${i + 1} (0-100)",
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      homeworkControllers.removeAt(i);
                    });
                  },
                ),
              ],
            ),
          ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: homeworkControllers.length < 4 ? _addHomework : null,
              child: const Text("Add Homework"),
            ),
            ElevatedButton(
              onPressed: _resetHomeworks,
              child: const Text("Reset Homeworks"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGradeField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "$label (0-100)",
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Grade Calculator'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildGradeField("Participation", participationController),
            const SizedBox(height: 10),
            _buildHomeworkFields(),
            const SizedBox(height: 10),
            _buildGradeField("Group Presentation", groupPresentationController),
            const SizedBox(height: 10),
            _buildGradeField("Midterm 1", midterm1Controller),
            const SizedBox(height: 10),
            _buildGradeField("Midterm 2", midterm2Controller),
            const SizedBox(height: 10),
            _buildGradeField("Final Project", finalProjectController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateFinalGrade,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
              ),
              child: const Text(
                "CALCULATE",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Final Grade: ${finalGrade.toStringAsFixed(2)}",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}
