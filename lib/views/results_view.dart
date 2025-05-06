import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_chrono/viewmodels/results_viewmodel.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({Key? key}) : super(key: key);

  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ResultsViewModel>();
    final results = vm.results;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              // Title
              const Text(
                'Results',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Search bar
              TextField(
                controller: _searchController,
                onChanged: vm.search,
                decoration: InputDecoration(
                  hintText: 'Search participant by BIB...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
              const SizedBox(height: 16),
              // Table header
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 8.0,
                ),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 40,
                      child: Text(
                        'BIB',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Swimming',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Running',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Cycling',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey[300]),
              // Results list or empty state
              if (results.isEmpty)
                const Expanded(
                  child: Center(child: Text('No participants found.')),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final result = results[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 8.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: Text(result.bib.toString()),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                result.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                result.swimmingTimer != Duration.zero
                                    ? result.swimmingTimer
                                        .toString()
                                        .split('.')
                                        .first
                                        .padLeft(8, '0')
                                    : '00:00:00',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                result.runningTimer != Duration.zero
                                    ? result.runningTimer
                                        .toString()
                                        .split('.')
                                        .first
                                        .padLeft(8, '0')
                                    : '00:00:00',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                result.cyclingTimer != Duration.zero
                                    ? result.cyclingTimer
                                        .toString()
                                        .split('.')
                                        .first
                                        .padLeft(8, '0')
                                    : '00:00:00',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                result.totalTimer != Duration.zero
                                    ? result.totalTimer
                                        .toString()
                                        .split('.')
                                        .first
                                        .padLeft(8, '0')
                                    : '00:00:00',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              // Export button
              ElevatedButton.icon(
                onPressed: () {
                  // Here you would implement your export functionality
                },
                icon: const Icon(Icons.upload_file),
                label: const Text('Export'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A459B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
