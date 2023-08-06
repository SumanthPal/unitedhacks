import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TrendsPage extends StatefulWidget {
  @override
  _TrendsPageState createState() => _TrendsPageState();
}

class _TrendsPageState extends State<TrendsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> categories = [
    'Groceries',
    'Home Improvement',
    'Clothing',
    'Purchase History'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        labelColor: Color.fromARGB(255, 13, 125, 54),
        controller: _tabController,
        tabs: [
          Tab(icon: Icon(Icons.shopping_cart), text: 'Groceries'),
          Tab(icon: Icon(Icons.home), text: 'Home Improvement'),
          Tab(icon: Icon(Icons.shopping_bag), text: 'Clothing'),
          Tab(icon: Icon(Icons.history), text: 'Purchase History'),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTrendsTab('Groceries'),
          _buildTrendsTab('Home Improvement'),
          _buildTrendsTab('Clothing'),
          _buildPurchaseHistoryTab(),
        ],
      ),
    );
  }

  Widget _buildTrendsTab(String category) {
    final List<FlSpot> data = _generateRandomData(7);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.insights, color: Color.fromARGB(255, 13, 125, 54)),
          SizedBox(height: 16),
          Text(
            'AI Insights',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.all(16),
            width: double.infinity,
            height: 200,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: data,
                    isCurved: true,
                    barWidth: 4,
                    color: Color.fromARGB(
                        255, 13, 125, 54), // Replace with your desired color
                  ),
                ],
                minX: 0,
                maxX: data.length.toDouble() - 1,
                minY: 0,
                maxY: _getMaxValue(data),
                titlesData: FlTitlesData(),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Spending Habits',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          _buildExampleConservationWidget(category),
          SizedBox(
              height:
                  200), // Add additional spacing at the bottom for scrolling
        ],
      ),
    );
  }

  List<FlSpot> _generateRandomData(int count) {
    final random = Random();
    final List<FlSpot> data = [];

    for (int i = 0; i < count; i++) {
      final x = i.toDouble();
      final y = random.nextDouble() * 100;
      data.add(FlSpot(x, y));
    }

    return data;
  }

  double _getMaxValue(List<FlSpot> data) {
    double max = 0;
    for (final spot in data) {
      if (spot.y > max) {
        max = spot.y;
      }
    }
    return max;
  }

  Widget _buildExampleConservationWidget(String category) {
    String conservationBenefit = '';

    if (category == 'Groceries') {
      conservationBenefit = 'Save \$50 per month';
    } else if (category == 'Home Improvement') {
      conservationBenefit = 'Equivalent to reducing 50 kg of CO2 emissions';
    } else if (category == 'Clothing') {
      conservationBenefit = 'Donate unused clothes to reduce waste';
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              color: Color.fromARGB(255, 13, 125, 54),
              child: Icon(Icons.eco, color: Colors.white),
            ),
            SizedBox(width: 16),
            Text(
              'Conservation Benefit',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          conservationBenefit,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildPurchaseHistoryTab() {
    // Generate purchase history data (Replace this with your actual CSV data)
    final List<PurchaseHistory> purchaseHistory = generatePurchaseHistoryData();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: purchaseHistory.map((purchase) {
          return _buildPurchaseCard(purchase);
        }).toList(),
      ),
    );
  }

  // Dummy purchase history data for demonstration purposes

  List<PurchaseHistory> generatePurchaseHistoryData() {
    return [
      PurchaseHistory(
        itemName: 'Plastic Water Bottles',
        cost: 8,
        alternatives: ['Stainless Steel Water Bottle', 'Glass Water Bottle'],
      ),
      PurchaseHistory(
        itemName: 'Non-Biodegradable Smartphone Case',
        cost: 10,
        alternatives: ['Biodegradable Phone Case', 'Recycled Phone Case'],
      ),
      PurchaseHistory(
        itemName: 'Incandescent Light Bulbs',
        cost: 5,
        alternatives: ['LED Light Bulbs', 'Energy-Saving Bulbs'],
      ),
      PurchaseHistory(
        itemName: 'Single-Use Plastic Bags',
        cost: 3,
        alternatives: ['Reusable Grocery Bags', 'Cotton Tote Bags'],
      ),
      PurchaseHistory(
        itemName: 'Polystyrene Food Containers',
        cost: 15,
        alternatives: ['Compostable Food Containers', 'Biodegradable Plates'],
      ),
      PurchaseHistory(
        itemName: 'Conventional Vegetable Seeds',
        cost: 2,
        alternatives: ['Organic Vegetable Seeds', 'Heirloom Seeds'],
      ),
      PurchaseHistory(
        itemName: 'Paper Napkins',
        cost: 6,
        alternatives: ['Cloth Napkins', 'Linen Napkins'],
      ),
    ];
  }

  Widget _buildPurchaseCard(PurchaseHistory purchase) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              purchase.itemName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${purchase.cost}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Alternatives: ${purchase.alternatives.join(", ")}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class PurchaseHistory {
  final String itemName;
  final double cost;
  final List<String> alternatives;

  PurchaseHistory({
    required this.itemName,
    required this.cost,
    required this.alternatives,
  });
}
