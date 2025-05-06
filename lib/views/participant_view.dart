import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/viewmodels/participant_viewmodel.dart';
import 'package:sport_chrono/widgets/participant_list_item_widgets_views.dart';

class ParticipantView extends StatefulWidget {
  const ParticipantView({Key? key}) : super(key: key);

  @override
  State<ParticipantView> createState() => _ParticipantViewtate();
}

class _ParticipantViewtate extends State<ParticipantView> {
  late final ParticipantViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<ParticipantViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Triathlon',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Participants',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const Text(
                'add participants to start the race',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 16),
              _buildParticipantInputRow(),
              const SizedBox(height: 16),
              _buildParticipantListHeader(),
              Expanded(child: _buildParticipantList()),
              const SizedBox(height: 16),
              _buildNextButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildParticipantInputRow() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextField(
            controller: _viewModel.bibController,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(
              hintText: 'BIB #',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: TextField(
            controller: _viewModel.nameController,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(
              hintText: 'Participant Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: () {
            setState(() {
              _viewModel.addParticipant();
            });
          },
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _viewModel.addParticipant();
              });
            },
            mini: true,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            SizedBox(width: 16),
            Text(
              'BIB',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 36),
            Text(
              'Name',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () async {
            await _viewModel.deleteAll(); // wait until the DB is cleared
            setState(() {}); // then rebuild & refire the FutureBuilder
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Color(0xFFD0312D), width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Delete All',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantList() {
    return FutureBuilder<List<Participant>>(
      future: _viewModel.getParticipants(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No participants found.'));
        } else {
          final participants = snapshot.data!;
          return ListView.builder(
            itemCount: participants.length,
            itemBuilder: (context, index) {
              final participant = participants[index];
              return ParticipantListItem(
                participant: participant,
                onDelete: () async {
                  await _viewModel.deleteParticipant(participant.bib);
                  setState(() {}); // Refresh the list after deletion
                },
              );
            },
          );
        }
      },
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _viewModel.navigateToNextScreen,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF283593),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow, color: Colors.white),
            SizedBox(width: 8),
            Text('Next', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Result'),
      ],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      backgroundColor: const Color(0xFF283593),
    );
  }
}
