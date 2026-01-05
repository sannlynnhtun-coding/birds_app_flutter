import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/bird_provider.dart';
import 'bird_detail_screen.dart';
import 'bird_form_screen.dart';
import 'login_screen.dart';

class BirdsListScreen extends StatefulWidget {
  const BirdsListScreen({super.key});

  @override
  State<BirdsListScreen> createState() => _BirdsListScreenState();
}

class _BirdsListScreenState extends State<BirdsListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch birds when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BirdProvider>(context, listen: false).fetchBirds();
    });
  }

  Future<void> _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  Future<void> _deleteBird(int birdId, String birdName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Bird'),
        content: Text('Are you sure you want to delete "$birdName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final birdProvider = Provider.of<BirdProvider>(context, listen: false);
      final success = await birdProvider.deleteBird(birdId);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Bird deleted successfully' : 'Failed to delete bird',
            ),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Birds Collection'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<BirdProvider>(context, listen: false).fetchBirds();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Consumer<BirdProvider>(
        builder: (context, birdProvider, child) {
          if (birdProvider.isLoading && birdProvider.birds.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (birdProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    birdProvider.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => birdProvider.fetchBirds(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (birdProvider.birds.isEmpty) {
            return const Center(
              child: Text('No birds found. Add some birds!'),
            );
          }

          return RefreshIndicator(
            onRefresh: () => birdProvider.fetchBirds(),
            child: ListView.builder(
              itemCount: birdProvider.birds.length,
              itemBuilder: (context, index) {
                final bird = birdProvider.birds[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        bird.birdEnglishName[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(bird.birdEnglishName),
                    subtitle: Text(
                      bird.birdMyanmarName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BirdFormScreen(bird: bird),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteBird(
                            bird.id,
                            bird.birdEnglishName,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BirdDetailScreen(bird: bird),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BirdFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

