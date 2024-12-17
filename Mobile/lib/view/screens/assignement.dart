import 'package:flutter/material.dart';

void main() {
  runApp(const FileUploadApp());
}

class FileUploadApp extends StatelessWidget {
  const FileUploadApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Upload UI',
      home: Scaffold(
        backgroundColor: Color(0xFFEAF5FF),
        body: const Center(
          child: FileUploadCard(),
        ),
      ),
    );
  }
}

class FileUploadCard extends StatelessWidget {
  const FileUploadCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lesson or Assignment Information
          const Text(
            "Assignment: Linear Algebra Task",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Please upload your solutions and work files related to the Linear Algebra Task. Ensure that all calculations, steps, and final answers are included.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
          const Divider(
            height: 30,
            thickness: 1,
            color: Colors.grey,
          ),

          // Add Files Button
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.add_circle, color: Colors.blueAccent, size: 24),
                SizedBox(width: 10),
                Text(
                  "Add files",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // File Upload Progress Bars
          FileUploadItem(
            fileName: "equations_solution.pdf",
            progress: 0.4,
            icon: Icons.file_copy,
            iconColor: Colors.black54,
          ),
          const SizedBox(height: 15),
          FileUploadItem(
            fileName: "calculus_steps.docx",
            progress: 0.72,
            icon: Icons.note,
            iconColor: Colors.black54,
          ),
          const SizedBox(height: 15),

          // Completed File
          Row(
            children: [
              const Icon(Icons.insert_drive_file,
                  color: Colors.blueAccent, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Final_Report.pdf",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const Icon(Icons.check_circle,
                  color: Colors.blueAccent, size: 24),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget for File Upload Item
class FileUploadItem extends StatelessWidget {
  final String fileName;
  final double progress;
  final IconData icon;
  final Color iconColor;

  const FileUploadItem({
    Key? key,
    required this.fileName,
    required this.progress,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fileName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.shade300,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        const Icon(Icons.close, color: Colors.black26, size: 24),
      ],
    );
  }
}
