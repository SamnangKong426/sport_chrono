import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_chrono/viewmodels/results_viewmodel.dart';
import 'package:sport_chrono/widgets/bib_search_bar.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({Key? key}) : super(key: key);

  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  final TextEditingController _searchController = TextEditingController();

  String formatDuration(Duration d) =>
      d != Duration.zero
          ? d.toString().split('.').first.padLeft(8, '0')
          : '00:00:00';

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ResultsViewModel>();
    final results = vm.results;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BIBSearchBar(onChanged: vm.search),
              const SizedBox(height: 16),
              if (results.isEmpty)
                const Expanded(
                  child: Center(child: Text('No participants found.')),
                )
              else
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 800,
                      ), // Ensure enough width for all columns
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(
                          const Color(0xFFEFEFEF),
                        ),
                        columnSpacing: 16,
                        columns: const [
                          DataColumn(label: Text('BIB')),
                          DataColumn(label: Text('Name')),
                          DataColumn(
                            label: Text(
                              'Swimming',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Running',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Cycling',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Total',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                        rows:
                            results.map((result) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(result.bib.toString())),
                                  DataCell(
                                    Text(
                                      result.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      formatDuration(result.swimmingTimer),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      formatDuration(result.runningTimer),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      formatDuration(result.cyclingTimer),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      formatDuration(result.totalTimer),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
                ElevatedButton.icon(
                onPressed: () async {
                  final vm = context.read<ResultsViewModel>();
                  try {
                  await vm.exportResultsToFile();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Export successful!')),
                  );
                  } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Export failed: $e')),
                  );
                  }
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
