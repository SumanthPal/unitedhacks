import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class RewardsPage extends StatelessWidget {
  final List<IconData> availableRewards = [
    MaterialCommunityIcons.code_braces,
    MaterialCommunityIcons.brush,
    MaterialCommunityIcons.gamepad_variant,
    MaterialCommunityIcons.headphones,
    MaterialCommunityIcons.movie,
    MaterialCommunityIcons.music,
    MaterialCommunityIcons.shopping,
    MaterialCommunityIcons.soccer_field,
    MaterialCommunityIcons.tshirt_crew,
  ];

  final List<IconData> obtainedRewards = [
    MaterialCommunityIcons.medal,
    MaterialCommunityIcons.medal_outline,
    MaterialCommunityIcons.trophy,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _buildRewardsSection()),
          SizedBox(height: 16),
          Expanded(child: _buildObtainedRewardsSection()),
        ],
      ),
    );
  }

  Widget _buildRewardsSection() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Color.fromARGB(255, 13, 125, 54),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Rewards',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  // TODO: Implement search functionality
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          TextFormField(
            // TODO: Implement search functionality
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search),
              hintText: 'Search rewards...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: availableRewards.length,
              itemBuilder: (context, index) {
                final reward = availableRewards[index];
                return Icon(reward, size: 40, color: Colors.white);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObtainedRewardsSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Obtained Rewards',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: obtainedRewards.length,
              itemBuilder: (context, index) {
                final reward = obtainedRewards[index];
                return Icon(reward, size: 40);
              },
            ),
          ),
        ],
      ),
    );
  }
}
