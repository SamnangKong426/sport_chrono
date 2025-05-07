import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/timer_viewmodel.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // provide the VM to the subtree
    return ChangeNotifierProvider(
      create: (_) => TimerViewModel(),
      child: Consumer<TimerViewModel>(
        builder: (context, vm, _) {
          const Color darkBlue = Color(0xFF1A2C70);
          const Color mediumBlue = Color(0xFF3D5AA8);
          const Color lightBlue = Color(0xFFABB9E8);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                'Timer',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Column(
              children: [
                // Main timer display
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  decoration: BoxDecoration(
                    color: darkBlue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    vm.timerText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Activity selection buttons
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        Activity.values.map((act) {
                          final isSel = vm.selectedActivity == act;
                          final col =
                              (act == Activity.Swimming)
                                  ? darkBlue
                                  : (act == Activity.Cycling)
                                  ? mediumBlue
                                  : lightBlue;
                          return GestureDetector(
                            onTap: () => vm.selectActivity(act),
                            child: _buildActivityButton(
                              act.name,
                              act == Activity.Swimming
                                  ? Icons.pool
                                  : act == Activity.Cycling
                                  ? Icons.directions_bike
                                  : Icons.directions_run,
                              col,
                              isSelected: isSel,
                            ),
                          );
                        }).toList(),
                  ),
                ),

                // Range selector
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: vm.previousPage,
                          child: Container(
                            height: 40,
                            decoration: const BoxDecoration(
                              color: lightBlue,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(8),
                              ),
                            ),
                            child: const Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      ...vm.pageLabels.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final lbl = entry.value;
                        final isCurrent = idx == vm.pageIndex;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => vm.goToPage(idx),
                            child: Container(
                              height: 40,
                              color: isCurrent ? mediumBlue : lightBlue,
                              alignment: Alignment.center,
                              child: Text(
                                lbl,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      Expanded(
                        child: GestureDetector(
                          onTap: vm.nextPage,
                          child: Container(
                            height: 40,
                            decoration: const BoxDecoration(
                              color: lightBlue,
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(8),
                              ),
                            ),
                            child: const Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Participant toggles
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // two columns
                            childAspectRatio: 3, // wider tiles
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: vm.currentParticipants.length,
                      itemBuilder: (context, idx) {
                        final part = vm.currentParticipants[idx];
                        final isSel = part.status;
                        return GestureDetector(
                          onTap: () => vm.toggleParticipantStatus(part.bib),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSel ? mediumBlue : lightBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              part.bib.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Bottom navigation (unchanged)
                Container(
                  height: 60,
                  color: darkBlue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem('Home', Icons.home),
                      _buildNavItem('Race', Icons.flag),
                      _buildNavItem('Timer', Icons.timer, isSelected: true),
                      _buildNavItem('Result', Icons.assignment),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!vm.isRunning)
                  FloatingActionButton(
                    onPressed: vm.start,
                    child: const Icon(Icons.play_arrow),
                  )
                else
                  FloatingActionButton(
                    onPressed: vm.pause,
                    child: const Icon(Icons.pause),
                  ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  onPressed: vm.reset,
                  child: const Icon(Icons.replay),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActivityButton(
    String label,
    IconData icon,
    Color color, {
    bool isSelected = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  Widget _buildIntervalTile({
    required int number,
    String? time,
    required bool isSelected,
    required Color bgColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number < 10 ? '0$number' : '$number',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          if (time != null)
            Text(
              time,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, {bool isSelected = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: isSelected ? 28 : 24),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: isSelected ? 12 : 10),
        ),
      ],
    );
  }
}
