import 'package:flutter/material.dart';
import '../repository/api_repository.dart';
import '../models/setup_model.dart';
import '../params/mechanic_log_param.dart';

class PostLogUI extends StatefulWidget {
  const PostLogUI({super.key});

  @override
  State<PostLogUI> createState() => _PostLogUIState();
}

class _PostLogUIState extends State<PostLogUI> {
  final ApiRepository _repo = ApiRepository();
  final _formKey = GlobalKey<FormState>();

  String? _selectedSetupId;
  final _mechanicController = TextEditingController();
  final _noteController = TextEditingController();

  List<SetupModel> _setupList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSetups();
  }

  void _loadSetups() async {
    final list = await _repo.getDropdownList();
    setState(() => _setupList = list);
  }

  void _saveLog() async {
    if (_formKey.currentState!.validate() && _selectedSetupId != null) {
      setState(() => _isLoading = true);
      final param = MechanicLogParam(
        setupId: _selectedSetupId!,
        mechanicName: _mechanicController.text,
        note: _noteController.text,
      );

      final success = await _repo.postLog(param);
      setState(() => _isLoading = false);

      if (success) {
        if(!mounted) return;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(backgroundColor: Colors.green, content: Text("✓ Log Report Successfully Uploaded!"))
        );
      } else {
        if(!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(backgroundColor: Colors.red, content: Text("⚠ Failed to connect to Server."))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("NEW LOG ENTRY", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // INFO BANNER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              color: const Color(0xFF1F1F1F),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.grey, size: 20),
                  SizedBox(width: 10),
                  Expanded(child: Text("Isi laporan mekanik untuk disimpan ke database server (Relasi Table).", style: TextStyle(color: Colors.grey, fontSize: 12))),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("TARGET CIRCUIT"),
                    DropdownButtonFormField<String>(
                      dropdownColor: const Color(0xFF2C2C2C),
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecor("Select Related Circuit", Icons.map),
                      items: _setupList.map((s) => DropdownMenuItem(value: s.id, child: Text(s.circuitName))).toList(),
                      onChanged: (v) => setState(() => _selectedSetupId = v),
                      validator: (v) => v == null ? "Required field" : null,
                    ),

                    const SizedBox(height: 25),

                    _buildLabel("MECHANIC ON DUTY"),
                    TextFormField(
                      controller: _mechanicController,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecor("Enter Name", Icons.person_outline),
                      validator: (v) => v!.isEmpty ? "Required field" : null,
                    ),

                    const SizedBox(height: 25),

                    _buildLabel("TECHNICAL NOTES"),
                    TextFormField(
                      controller: _noteController,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecor("Describe issue or updates...", Icons.notes),
                      validator: (v) => v!.isEmpty ? "Required field" : null,
                    ),

                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveLog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE10600),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 10,
                          shadowColor: const Color(0xFFE10600).withOpacity(0.4),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("UPLOAD TO SERVER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.5)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5),
      child: Text(text, style: const TextStyle(color: Color(0xFFE10600), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.5)),
    );
  }

  InputDecoration _inputDecor(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[600]),
      prefixIcon: Icon(icon, color: Colors.grey),
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE10600), width: 1.5)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent)),
    );
  }
}