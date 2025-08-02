import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class AdminMetricsPanelWidget extends StatelessWidget {
  final Map<String, dynamic> metrics;

  const AdminMetricsPanelWidget({
    Key? key,
    required this.metrics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Organization Overview',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
          ),
          SizedBox(height: 2.h),

          // Metrics Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 3.w,
            mainAxisSpacing: 2.h,
            childAspectRatio: 1.5,
            children: [
              _buildMetricCard(
                context,
                'Total Funds',
                '₹${_formatNumber(metrics['totalFundsRaised'])}',
                Icons.account_balance_wallet,
                const Color(0xFF4CAF50),
              ),
              _buildMetricCard(
                context,
                'Active Campaigns',
                '${metrics['activeCampaigns']}',
                Icons.campaign,
                const Color(0xFF2196F3),
              ),
              _buildMetricCard(
                context,
                'Users',
                '${metrics['userRegistrations']}',
                Icons.people,
                const Color(0xFFFF6B6B),
              ),
              _buildMetricCard(
                context,
                'Conversion Rate',
                '${metrics['conversionRate']}%',
                Icons.trending_up,
                const Color(0xFFFF9800),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Chart Section
          Container(
            height: 25.h,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(4.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fundraising Trends',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 2.h),
                Expanded(
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            const FlSpot(0, 3),
                            const FlSpot(1, 1),
                            const FlSpot(2, 4),
                            const FlSpot(3, 2),
                            const FlSpot(4, 5),
                            const FlSpot(5, 3),
                            const FlSpot(6, 7),
                          ],
                          isCurved: true,
                          color: const Color(0xFFFF6B6B),
                          barWidth: 3,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color:
                                const Color(0xFFFF6B6B).withValues(alpha: 0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 6.w),
              Container(
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: color,
                  size: 4.w,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double number) {
    if (number >= 100000) {
      return '${(number / 100000).toStringAsFixed(1)}L';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }
}
