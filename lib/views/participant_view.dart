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
  List<Map<String, dynamic>> notifications = [];
  int notificationCount = 1; // You can make this dynamic
    void addFinishNotification(String participantName, String finishTime) {
    setState(() {
      notifications.insert(0, {
        'title': 'Race Finished',
        'message': '$participantName finished in $finishTime',
        'time': DateTime.now(),
        'icon': Icons.flag,
      });
      notificationCount = notifications.length;
    });
  }
  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
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
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TRIATHLON',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A2C70),
                      ),
                    ),
                    const SizedBox(width: 250),
                    Stack(
                      children: [
IconButton(
                          iconSize: 30,
                          icon: const Icon(Icons.notifications),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Race Notifications'),
                                  content: SizedBox(
                                    width: double.maxFinite,
                                    child:
                                        notifications.isEmpty
                                            ? const Center(
                                              child: Text(
                                                'No notifications yet',
                                              ),
                                            )
                                            : ListView.separated(
                                              shrinkWrap: true,
                                              itemCount: notifications.length,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const Divider(),
                                              itemBuilder: (context, index) {
                                                final notification =
                                                    notifications[index];
                                                return ListTile(
                                                  leading: Icon(
                                                    notification['icon']
                                                        as IconData,
                                                  ),
                                                  title: Text(
                                                    notification['title'],
                                                  ),
                                                  subtitle: Text(
                                                    notification['message'],
                                                  ),
                                                  trailing: Text(
                                                    _formatTime(
                                                      notification['time']
                                                          as DateTime,
                                                    ),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    // Handle tap if needed
                                                  },
                                                );
                                              },
                                            ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          notifications.clear();
                                          notificationCount = 0;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Clear All'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          color: const Color(0xFF1A2C70),
                        ),
                        if (notificationCount > 0)
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 14,
                                minHeight: 14,
                              ),
                              child: Text(
                                '$notificationCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildParticipantInputRow(),
              const SizedBox(height: 16),
              _buildParticipantListHeader(),
              const SizedBox(height: 16),
              Expanded(child: _buildParticipantList()),
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
}
