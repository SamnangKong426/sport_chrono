import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_chrono/viewmodels/results_viewmodel.dart';
import 'package:sport_chrono/widgets/bib_search_bar.dart';
import 'package:sport_chrono/themes/app_spacing.dart';
import 'package:sport_chrono/themes/app_colors.dart';

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
    final resultsViewModel = context.watch<ResultsViewModel>();
    final results = resultsViewModel.results;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            children: [
              //* Search Bar
              BIBSearchBar(onChanged: resultsViewModel.search),
              AppSpacing.gapH16,

              //* Results Table
              if (results.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'No participants found.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 800),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: DataTable(
                          headingRowColor: MaterialStateProperty.all(
                            // AppColors.background,
                            AppColors.primary,
                          ),
                          dataRowColor: MaterialStateProperty.all(
                            AppColors.primary.withOpacity(0.1),
                          ),
                          columnSpacing: 16,
                          columns: const [
                            DataColumn(
                              label: Text(
                                'BIB',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Swimming',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Cycling',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Running',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          rows:
                              results.map((result) {
                                return DataRow(
                                  cells: [
                                    //* BIB
                                    DataCell(Text(result.bib.toString())),
                                    //* Name
                                    DataCell(
                                      Text(
                                        result.name,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    //* Swimming Timer
                                    DataCell(
                                      Text(
                                        formatDuration(result.swimmingTimer),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 12),
                                      ),
                                    ),
                                    
                                    //* Cycling Timer
                                    DataCell(
                                      Text(
                                        formatDuration(result.cyclingTimer),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 12),
                                      ),
                                    ),
                                    //* Running Timer
                                    DataCell(
                                      Text(
                                        formatDuration(result.runningTimer),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 12),
                                      ),
                                    ),
                                    //* Total Timer
                                    DataCell(
                                      Text(
                                        formatDuration(result.totalTimer),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              AppSpacing.gapH16,
              OutlinedButton.icon(
                onPressed: () async {
                  try {
                    await resultsViewModel.exportResultsToFile();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Export successful!')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Export failed: $e')),
                    );
                  }
                },
                icon: const Icon(
                  Icons.upload_file,
                  color: AppColors.primaryDark,
                ),
                label: const Text(
                  'Export',
                  style: TextStyle(color: AppColors.primaryDark),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryDark),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 32.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              AppSpacing.gapH16,
            ],
          ),
        ),
      ),
    );
  }
}
