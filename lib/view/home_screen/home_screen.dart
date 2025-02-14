import 'package:antiquewebemquiry/view/hamburger.dart';
import 'package:antiquewebemquiry/view/salesreport.dart';
import 'package:antiquewebemquiry/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../report_screen/report_screen.dart';

class HomeScreen extends StatefulWidget {
  // ignore: use_super_parameters
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedFilter = 'Daily';
  bool _showReport = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  final Map<String, Map<String, String>> statistics = {
    'Daily': {
      'totalItems': '135',
      'totalSales': '\$345.97'
    },
    'Monthly': {
      'totalItems': '325',
      'totalSales': '\$11,985'
    },
    'Yearly': {
      'totalItems': '3897',
      'totalSales': '\$89,000'
    }
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleReport() {
    setState(() {
      _showReport = !_showReport;
      if (_showReport) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: const DrawerMenu(),
        backgroundColor: const Color(0xFFF1EDE8),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // App Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Text(
                          ' Home',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Stack(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.notifications_outlined),
                                  color: Colors.black,
                                  onPressed: () {},
                                ),
                                Positioned(
                                  right: 8,
                                  top: 8,
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
                                    child: const Text(
                                      '1',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.menu),
                              color: Colors.black,
                              onPressed: () {
                                _scaffoldKey.currentState?.openEndDrawer();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 90),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            
                            // Welcome Section
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hi Jack',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2D3142),
                                        ),
                                      ),
                                      Text(
                                        'Welcome back!',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2D3142),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Image.asset(
                                      'assets/welcome.png',
                                      height: 92.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Filter Buttons
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  _buildFilterButton('Daily'),
                                  const SizedBox(width: 12),
                                  _buildFilterButton('Monthly'),
                                  const SizedBox(width: 12),
                                  _buildFilterButton('Yearly'),
                                ],
                              ),
                            ),

                            const SizedBox(height: 22),

                            // View Report Button
                            Center(
                              child: SizedBox(
                                width: 147,
                                height: 43,
                                child: ElevatedButton(
                                  onPressed: _toggleReport,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF6B00),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text(
                                    'View Report',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Statistics Cards
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildStatCard(
                                      'Total Items Sold',
                                      statistics[selectedFilter]!['totalItems']!
                                    )
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildStatCard(
                                      'Total Sales Amount',
                                      statistics[selectedFilter]!['totalSales']!
                                    )
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Chart Section
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: _buildChartSection(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom Navigation
                  _buildBottomNavBar(),
                ],
              ),
              
              // Animated Sales Report Overlay
              if (_showReport)
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Positioned(
                      top: _animation.value * MediaQuery.of(context).padding.top,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(_animation),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, -5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: SalesReport(
                                  filterType: selectedFilter,
                                  onClose: _toggleReport,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Rest of the widget methods remain the same
  Widget _buildFilterButton(String text) {
    bool isSelected = selectedFilter == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = text;
        });
      },
      child: Container(
        width: 110,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF8500) : Colors.grey,
          borderRadius: BorderRadius.circular(1),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      height: 118,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF11AB86),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3142),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFA6).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/trending.png',
                  width: 25,
                  height: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
    final Map<String, Map<String, dynamic>> chartConfigs = {
      'Daily': {
        'labels': ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
        'maxY': 1000.0,
        'interval': 100.0,
        'spots': const [
          FlSpot(0, 200),
          FlSpot(1, 400),
          FlSpot(2, 300),
          FlSpot(3, 600),
          FlSpot(4, 500),
          FlSpot(5, 700),
          FlSpot(6, 450),
        ],
      },
      'Monthly': {
        'labels': ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
        'maxY': 10000.0,
        'interval': 1000.0,
        'spots': const [
          FlSpot(0, 2000),
          FlSpot(1, 4000),
          FlSpot(2, 7000),
          FlSpot(3, 5000),
        ],
      },
      'Yearly': {
        'labels': ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        'maxY': 100000.0,
        'interval': 10000.0,
        'spots': const [
          FlSpot(0, 15000),
          FlSpot(1, 25000),
          FlSpot(2, 45000),
          FlSpot(3, 35000),
          FlSpot(4, 55000),
          FlSpot(5, 75000),
          FlSpot(6, 65000),
          FlSpot(7, 85000),
          FlSpot(8, 70000),
          FlSpot(9, 90000),
          FlSpot(10, 80000),
          FlSpot(11, 95000),
        ],
      },
    };

    var currentConfig = chartConfigs[selectedFilter]!;
    
    double chartWidth = selectedFilter == 'Yearly' 
        ? MediaQuery.of(context).size.width * 3.5
        : MediaQuery.of(context).size.width - 32;

    Widget chartWidget = SizedBox(
      width: chartWidth,
      height: 350,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: true,
              getDrawingHorizontalLine: (value) {
                return const FlLine(
                  color: Color(0xFFE5E5E5),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return const FlLine(
                  color: Color(0xFFE5E5E5),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 60,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        value.toInt().toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    );
                  },
                  interval: currentConfig['interval'],
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 35,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() >= currentConfig['labels'].length) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        currentConfig['labels'][value.toInt()],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  interval: 1,
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xFFE5E5E5)),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: currentConfig['spots'],
                isCurved: true,
                color: const Color(0xFF00BFA6),
                barWidth: 3,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 6,
                      color: Colors.white,
                      strokeWidth: 3,
                      strokeColor: const Color(0xFF00BFA6),
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: const Color(0xFF00BFA6).withOpacity(0.1),
                ),
              ),
            ],
            minX: 0,
            maxX: (currentConfig['labels'].length - 1).toDouble(),
            minY: 0,
            maxY: currentConfig['maxY'],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.black.withOpacity(0.8),
                tooltipRoundedRadius: 8,
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    return LineTooltipItem(
                      '${currentConfig['labels'][touchedSpot.x.toInt()]}\n${touchedSpot.y.toInt()}',
                      const TextStyle(color: Colors.white, fontSize: 12),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'OVERVIEW',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF9A9A9A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$selectedFilter Sales',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF8500),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 500,
            child: selectedFilter == 'Yearly'
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: chartWidget,
                  )
                : chartWidget,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem('assets/home.png', 'Home', true),
          _buildNavItem('assets/report.png', 'Reports', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (label == 'Reports') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ReportsPage()),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF8500),
            ),
          ),
        ],
      ),
    );
  }
}


