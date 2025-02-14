import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePickerWidget extends StatefulWidget {
  final Function(DateTimeRange) onDateRangeSelected;
  final VoidCallback onSearch;

  const DateRangePickerWidget({
    super.key,
    required this.onDateRangeSelected,
    required this.onSearch,
  });

  @override
  State<DateRangePickerWidget> createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  final DateFormat displayFormat = DateFormat('MM/dd/yyyy');
  bool isExpanded = false;
  List<DateTimeRange> monthRanges = [];
  DateTimeRange? selectedRange;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _generateMonthRanges();
    selectedRange = monthRanges.first;
  }

  void _generateMonthRanges() {
    DateTime start = DateTime(2020, 1, 1);
    DateTime end = DateTime.now();
    DateTime current = start;

    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      DateTime firstDay = DateTime(current.year, current.month, 1);
      DateTime lastDay = DateTime(current.year, current.month + 1, 0);
      monthRanges.add(DateTimeRange(start: firstDay, end: lastDay));
      current = DateTime(current.year, current.month + 1, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_today, size: 20, color: Colors.grey.shade600),
              const SizedBox(width: 25),
              Expanded(
                child: Text(
                  selectedRange != null
                      ? '${displayFormat.format(selectedRange!.start)} - ${displayFormat.format(selectedRange!.end)}'
                      : 'Select Date Range',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                  if (isExpanded) {
                    widget.onSearch();
                  }
                },
                child: const Icon(
                  Icons.search,
                  size: 24,
                  color: Color(0xFF00CF9D),
                ),
              ),
            ],
          ),
        ),
        if (isExpanded) ...[
          const SizedBox(height: 4),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: monthRanges.length,
                    itemBuilder: (context, index) {
                      final range = monthRanges[index];
                      final isSelected = selectedRange == range;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedRange = range;
                          });
                          widget.onDateRangeSelected(range);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 35), // Add space from left
                              Expanded(
                                child: Text(
                                  '${displayFormat.format(range.start)} - ${displayFormat.format(range.end)}',
                                  textAlign: TextAlign.center, // Center the text
                                  style: TextStyle(
                                    color: isSelected ? Colors.blue : Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 100), // Add space from right
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isExpanded = false;
                          });
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.close, size: 18, color: Colors.red,),
                            SizedBox(width: 4),
                            Text('Close', style: TextStyle(color: Colors.red,)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}