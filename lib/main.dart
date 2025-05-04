import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const TimerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Colors used in the design
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
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 25),
            decoration: BoxDecoration(
              color: darkBlue,
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            child: const Text(
              '00:00:00',
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Activity selection buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActivityButton('Swimming', Icons.pool, darkBlue),
                _buildActivityButton('Cycling', Icons.directions_bike, mediumBlue, isSelected: false),
                _buildActivityButton('Running', Icons.directions_run, lightBlue, isSelected: false),
              ],
            ),
          ),
          
          // Range selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
                    ),
                    child: const Icon(Icons.chevron_left, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    color: mediumBlue,
                    alignment: Alignment.center,
                    child: const Text(
                      '01 - 28',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    color: lightBlue,
                    alignment: Alignment.center,
                    child: const Text(
                      '29 - 56',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    color: lightBlue,
                    alignment: Alignment.center,
                    child: const Text(
                      '57 - 84',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
                    ),
                    child: const Icon(Icons.chevron_right, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          
          // Grid of interval tiles
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 28,
                itemBuilder: (context, index) {
                  final itemNumber = index + 1;
                  // Define which items should be dark blue (selected)
                  final isDarkBlue = [3, 7, 8, 14, 16, 18, 20, 22, 24, 26, 28].contains(itemNumber);
                  
                  return _buildIntervalTile(
                    number: itemNumber,
                    time: itemNumber < 3 || (itemNumber > 3 && itemNumber < 7) || itemNumber > 8
                        ? '00:3${itemNumber < 10 ? index+2 : index}:${itemNumber < 5 ? '2' : itemNumber < 10 ? '5' : '1'}${itemNumber % 3}'
                        : null,
                    isSelected: isDarkBlue,
                    bgColor: isDarkBlue ? darkBlue : lightBlue,
                  );
                },
              ),
            ),
          ),
          
          // Bottom navigation
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
    );
  }
  
  Widget _buildActivityButton(String label, IconData icon, Color color, {bool isSelected = true}) {
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
          Text(
            label,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
  
  Widget _buildIntervalTile({
    required int number, 
    String? time, 
    required bool isSelected, 
    required Color bgColor
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(String label, IconData icon, {bool isSelected = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: isSelected ? 28 : 24,
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: isSelected ? 12 : 10,
          ),
        ),
      ],
    );
  }
}