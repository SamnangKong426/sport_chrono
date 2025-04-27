import 'package:flutter/material.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/widgets/sport_type_button.dart';

class RaceView extends StatefulWidget {
  const RaceView({super.key});

  @override
  State<RaceView> createState() => _RaceViewState();
}

class _RaceViewState extends State<RaceView> {
  String _selectedSport = 'Swimming'; // default selected sport
  List<Participant> participants = [
    Participant(
      bib: '001',
      name: 'John Doe',
      timer: Duration.zero,
      status: false,
    ),
    Participant(
      bib: '002',
      name: 'Jane Smith',
      timer: Duration.zero,
      status: false,
    ),
    Participant(
      bib: '003',
      name: 'Alice Johnson',
      timer: Duration.zero,
      status: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Race',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    print('Race Started');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      'Start',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Timer Display
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: const Text(
                  '00:00:00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Type of Triton sports (swimming, cycling, running)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SportTypeButton(
                  sportType: 'Swimming',
                  iconData: Icons.pool,
                  isSelected: _selectedSport == 'Swimming',
                  onTap: () {
                    setState(() => _selectedSport = 'Swimming');
                    print('Swimming selected');
                  },
                ),
                const Spacer(),
                SportTypeButton(
                  sportType: 'Cycling',
                  iconData: Icons.directions_bike,
                  isSelected: _selectedSport == 'Cycling',
                  onTap: () {
                    setState(() => _selectedSport = 'Cycling');
                    print('Cycling selected');
                  },
                ),
                const Spacer(),
                SportTypeButton(
                  sportType: 'Running',
                  iconData: Icons.run_circle_outlined,
                  isSelected: _selectedSport == 'Running',
                  onTap: () {
                    setState(() => _selectedSport = 'Running');
                    print('Running selected');
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Search Bar
            SearchBar(
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 16.0),
              ),
              leading: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.secondary,
              ),
              hintText: "Search participants by BIB...",
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              onChanged: (query) {
                // Handle search query changes
                print('Search query: $query');
              },
            ),

            const SizedBox(height: 20),
            // Status guide
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Theme.of(context).colorScheme.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Untrack',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 16,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Track',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Table of participants
            ParticipantTable(participants: participants),
          ],
        ),
      ),
    );
  }
}

class ParticipantTable extends StatelessWidget {
  const ParticipantTable({super.key, required this.participants});

  final List<Participant> participants;

  @override
  Widget build(BuildContext context) {
    return Table(
      // border: TableBorder.all(color: kPrimaryColor),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'BIB',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Name',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Timer',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Status',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        ...participants.map((participant) {
          return TableRow(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  participant.bib.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  participant.name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  participant.timer
                      .toString()
                      .split('.')
                      .first, // Format Duration
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  participant.status ? 'Track' : 'Untrack',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}
