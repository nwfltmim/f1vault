import 'package:flutter/material.dart';
import '../repository/api_repository.dart';
import '../models/setup_model.dart';

class SearchUI extends StatefulWidget {
  const SearchUI({super.key});

  @override
  State<SearchUI> createState() => _SearchUIState();
}

class _SearchUIState extends State<SearchUI> {
  final ApiRepository _repo = ApiRepository();
  final TextEditingController _searchController = TextEditingController();
  List<SetupModel> _results = [];
  bool _isSearching = false;
  bool _hasSearched = false;

  void _performSearch() async {
    if (_searchController.text.isEmpty) return;
    setState(() { _isSearching = true; _hasSearched = true; });
    try {
      final response = await _repo.searchData(_searchController.text);
      setState(() => _results = response.data);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _isSearching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("DATABASE SEARCH", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // SEARCH BAR AREA
          Container(
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
              color: Color(0xFF1F1F1F),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Type Circuit Name (e.g. Monaco)...",
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: const Color(0xFF2C2C2C),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFE10600)),
                suffixIcon: IconButton(
                  // PERBAIKAN: Container tanpa const
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Color(0xFFE10600), shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ),
                  onPressed: _performSearch,
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              onSubmitted: (_) => _performSearch(),
            ),
          ),

          // RESULTS LIST AREA
          Expanded(
            child: _isSearching
                ? const Center(child: CircularProgressIndicator(color: Color(0xFFE10600)))
                : _results.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_hasSearched ? Icons.search_off : Icons.youtube_searched_for, size: 80, color: Colors.grey[800]),
                  const SizedBox(height: 15),
                  Text(_hasSearched ? "NO DATA FOUND" : "WAITING FOR INPUT...", style: TextStyle(color: Colors.grey[600], letterSpacing: 1)),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final data = _results[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.flag_rounded, color: Colors.blueAccent),
                    ),
                    title: Text(data.circuitName.toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text("ID RECORD: #${data.id}", style: TextStyle(color: Colors.grey[500], fontFamily: 'monospace')),
                    ),
                    trailing: const Icon(Icons.bar_chart, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}