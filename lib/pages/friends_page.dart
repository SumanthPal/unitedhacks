import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildFriendsSection(),
          SizedBox(
            height: 16,
          ),
          _buildLeaderboardSection(),
        ],
      ),
    );
  }

  Widget _buildFriendsSection() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Color.fromARGB(255, 13, 125, 54),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Friends',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  // TODO: Implement add friend functionality
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildFriendItem('John Doe', Icons.person),
          Divider(
            thickness: 0.5, // Set the thickness of the line
            color: Colors.grey, // Set the color of the line
          ),
          SizedBox(height: 8),
          _buildFriendItem('Jane Smith', Icons.person),
          SizedBox(height: 8),
          Divider(
            thickness: 0.5, // Set the thickness of the line
            color: Colors.grey, // Set the color of the line
          ),
          _buildFriendItem('Mark Johnson', Icons.person),
          SizedBox(height: 8),
          Divider(
            thickness: 0.5, // Set the thickness of the line
            color: Colors.grey, // Set the color of the line
          ),
          _buildFriendItem('Sarah Davis', Icons.person),
          SizedBox(height: 8),
          Divider(
            thickness: 0.5, // Set the thickness of the line
            color: Colors.grey, // Set the color of the line
          ),
          _buildFriendItem('Michael Wilson', Icons.person),
          SizedBox(height: 16),
          Divider(
            thickness: 0.5, // Set the thickness of the line
            color: Colors.grey, // Set the color of the line
          ),
          Text(
            'Find Friends',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            // TODO: Implement find friends functionality
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search),
              hintText: 'Search friends...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendItem(String name, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 40,
          color: Colors.white,
        ),
        SizedBox(width: 8),
        Text(
          name,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        Icon(Icons.check_circle, color: Colors.blue, size: 12)
      ],
    );
  }

  Widget _buildLeaderboardSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Leaderboard',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _buildLeaderboardItem(1, 'John Doe', Icons.person),
          SizedBox(height: 8),
          _buildLeaderboardItem(2, 'Jane Smith', Icons.person),
          SizedBox(height: 8),
          _buildLeaderboardItem(3, 'Mark Johnson', Icons.person),
          SizedBox(height: 8),
          _buildLeaderboardItem(4, 'Sarah Davis', Icons.person),
          SizedBox(height: 8),
          _buildLeaderboardItem(5, 'Michael Wilson', Icons.person),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(int position, String name, IconData icon) {
    return Row(
      children: [
        Text(
          '$position.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(width: 8),
        Icon(
          icon,
          size: 30,
        ),
        SizedBox(width: 8),
        Text(
          name,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
