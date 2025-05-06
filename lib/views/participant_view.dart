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
              Text(
                'Triathlon',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Participants',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 4),
              Text(
                'add participants to start the race',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              _buildParticipantInputRow(),
              const SizedBox(height: 16),
              _buildParticipantListHeader(),
              const SizedBox(height: 16),
              Expanded(child: _buildParticipantList()),
              const SizedBox(height: 16),
              _buildNextButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParticipantInputRow() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextField(
            controller: _viewModel.bibController,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: const InputDecoration(hintText: 'BIB #'),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: TextField(
            controller: _viewModel.nameController,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: const InputDecoration(hintText: 'Participant Name'),
          ),
        ),
        const SizedBox(width: 8),
        FloatingActionButton(
          mini: true,
          onPressed: () async {
            final added = await _viewModel.addParticipant();
            if (!added) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('BIB already exists')),
              );
            } else {
              setState(() { /* rebuild list */ });
            }
          },
          child: const Icon(Icons.add),
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
            await _viewModel.deleteAll();
            setState(() {});
          },
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            'Delete All',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white),
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
}
