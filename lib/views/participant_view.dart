import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/viewmodels/participant_viewmodel.dart';
import 'package:sport_chrono/widgets/participant_list_item_widgets_views.dart';
// import 'package:sport_chrono/themes/app_colors.dart';
import 'package:sport_chrono/themes/app_spacing.dart';
// import 'package:sport_chrono/themes/app_text_styles.dart';

class ParticipantView extends StatefulWidget {
  const ParticipantView({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'TRIATHLON',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              AppSpacing.gapH16,
              _buildParticipantInputRow(),
              AppSpacing.gapH16,
              _buildParticipantListHeader(),
              AppSpacing.gapH16,
              Expanded(child: _buildParticipantList()),
              AppSpacing.gapH16,
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
        AppSpacing.gapW8,
        Expanded(
          flex: 2,
          child: TextField(
            controller: _viewModel.nameController,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: const InputDecoration(hintText: 'Participant Name'),
          ),
        ),
        AppSpacing.gapW8,
        FloatingActionButton(
          mini: true,
          onPressed: () async {
            final added = await _viewModel.addParticipant();
            if (!added) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('BIB already exists')),
              );
            } else {
              setState(() {});
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
        Row(
          children: [
            AppSpacing.gapW16,
            Text('BIB', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(width: 36),
            Text('Name', style: Theme.of(context).textTheme.titleMedium),
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
                  setState(() {});
                },
              );
            },
          );
        }
      },
    );
  }
}
