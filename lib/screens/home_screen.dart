import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../widgets/active_game_bar.dart';
import '../widgets/field_listings_tab.dart';
import '../widgets/pickups_tab.dart';
import '../widgets/create_match_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, appState, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'FutFinds',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Fields'),
                Tab(text: 'Pick-ups'),
                Tab(text: 'Create-a-Match'),
              ],
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
            ),
          ),
          body: Column(
            children: [
              // Active game bar
              if (appState.activeMatch != null)
                ActiveGameBar(match: appState.activeMatch!),
              
              // Tab content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Fields tab
                    const FieldListingsTab(),
                    
                    // Pickups tab
                    const PickupsTab(),
                    
                    // Create-a-Match tab
                    const CreateMatchTab(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
