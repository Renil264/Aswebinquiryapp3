import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key, required int initialTabIndex}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'DM Sans',
            fontSize: 16
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        
        children: [
          
          // Tab Bar - Separated from AppBar
          Container(
            
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: const Color(0xFFFF8500),
              indicator: BoxDecoration(
                color: const Color(0xFFFF8500),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _tabController.index == 0 
                          ? const Color(0xFFFF8500) 
                          : Colors.white,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: const Text(
                      'General Message',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _tabController.index == 1 
                          ? const Color(0xFFFF8500)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: const Text(
                      'Message for Vendors',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
              onTap: (index) {
                setState(() {});
              },
            ),
          ),
          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // General Message Tab
                _buildGeneralMessageTab(screenSize),
                
                // Vendor Message Tab
                _buildVendorMessageTab(screenSize),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildGeneralMessageTab(Size screenSize) {
    return Container(
      color: const Color(0xFFF1EDE8),
      child: ListView.builder(
        itemCount: 1, // Sample message count
        itemBuilder: (context, index) {
          return _buildMessageCard(
            title: 'Message From Market',
            time: '10 AM',
            message: 'Big Market Days Ahead! Join the Mega Flea Market Festival!!!',
            isUnread: index == 0,
          );
        },
      ),
    );
  }
  
  Widget _buildVendorMessageTab(Size screenSize) {
    return Container(
      color: const Color(0xFFF1EDE8),
      child: ListView.builder(
        itemCount: 1, // Sample message count
        itemBuilder: (context, index) {
          return _buildMessageCard(
            title: 'Message From Vendors',
            time: '10 AM',
            message: 'Big Market Days Ahead! Join the Mega Flea Market Festival!!!',
            isUnread: index == 0,
          );
        },
      ),
    );
  }
  
  Widget _buildMessageCard({
    required String title, 
    required String time, 
    required String message,
    bool isUnread = false,
    bool showViewMore = true,
  }) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          // Handle message tap - open message detail
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2D3142),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2D3142),
                  height: 1.5,
                ),
              ),
              if (showViewMore)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // View more action
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFFF8500),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: Size.zero,
                      ),
                      child: const Text('View more'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}