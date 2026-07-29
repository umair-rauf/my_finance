import 'package:flutter/material.dart';

import '../../services/expense_service.dart';
import '../../services/income_service.dart';
import '../../widgets/bottom_nav.dart';
import '../add_expense/add_expense_screen.dart';
import '../income/add_income_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color backgroundColor = Color(0xFF070B0E);
  static const Color cardColor = Color(0xFF11171B);
  static const Color borderColor = Color(0xFF263036);
  static const Color goldColor = Color(0xFFFFC947);
  static const Color greenColor = Color(0xFF25D366);
  static const Color redColor = Color(0xFFFF4D4D);

  int selectedIndex = 0;

  void _refreshDashboard() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  void _showComingSoonMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        selectedIndex = 0;
      });
      return;
    }

    switch (index) {
      case 1:
        _showComingSoonMessage("Spend screen coming soon 💳");
        break;

      case 2:
        _showComingSoonMessage("Insights screen coming soon 📊");
        break;

      case 3:
        _showComingSoonMessage("Profile screen coming soon 👤");
        break;
    }

    setState(() {
      selectedIndex = 0;
    });
  }

  Future<void> _openIncomeScreen() async {
    final bool? incomeAdded = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const AddIncomeScreen()),
    );

    if (!mounted) {
      return;
    }

    if (incomeAdded == true) {
      _refreshDashboard();
    }
  }

  Future<void> _openExpenseScreen() async {
    final bool? expenseAdded = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
    );

    if (!mounted) {
      return;
    }

    if (expenseAdded == true) {
      _refreshDashboard();
    }
  }

  String _getGreeting() {
    final int hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    }

    if (hour < 17) {
      return "Good Afternoon";
    }

    return "Good Evening";
  }

  String _formatDate(DateTime date) {
    const List<String> weekdays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];

    const List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return "${weekdays[date.weekday - 1]}, "
        "${date.day} ${months[date.month - 1]} ${date.year}";
  }

  IconData _getExpenseIcon(String category) {
    switch (category.toLowerCase()) {
      case "food":
        return Icons.restaurant_rounded;

      case "transport":
        return Icons.directions_car_rounded;

      case "shopping":
        return Icons.shopping_bag_rounded;

      case "bills":
        return Icons.receipt_long_rounded;

      case "health":
        return Icons.medical_services_rounded;

      case "entertainment":
        return Icons.movie_rounded;

      case "education":
        return Icons.school_rounded;

      default:
        return Icons.payments_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double income = IncomeService.totalIncome;
    final double expense = ExpenseService.totalExpense;
    final double balance = income - expense;

    final expenses = ExpenseService.expenses.reversed.toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "MyFinance",
          style: TextStyle(color: goldColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showComingSoonMessage("Notifications coming soon 🔔");
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: goldColor,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _refreshDashboard();
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            children: [
              Text(
                _getGreeting(),
                style: const TextStyle(color: Colors.white60, fontSize: 15),
              ),

              const SizedBox(height: 4),

              const Text(
                "Umair 👋",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                _formatDate(DateTime.now()),
                style: const TextStyle(color: Colors.white54, fontSize: 13),
              ),

              const SizedBox(height: 24),

              _BalanceCard(balance: balance),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      title: "Total Income",
                      amount: income,
                      icon: Icons.south_west_rounded,
                      color: greenColor,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _SummaryCard(
                      title: "Total Expense",
                      amount: expense,
                      icon: Icons.north_east_rounded,
                      color: redColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              const Text(
                "Quick Actions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _QuickActionButton(
                      title: "Add Income",
                      icon: Icons.add_rounded,
                      color: greenColor,
                      onTap: _openIncomeScreen,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _QuickActionButton(
                      title: "Add Expense",
                      icon: Icons.remove_rounded,
                      color: redColor,
                      onTap: _openExpenseScreen,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _QuickActionButton(
                      title: "Reports",
                      icon: Icons.bar_chart_rounded,
                      color: goldColor,
                      onTap: () {
                        _showComingSoonMessage("Reports screen coming soon 📊");
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent Expenses",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${expenses.length} items",
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              if (expenses.isEmpty)
                const _EmptyExpenses()
              else
                ...expenses.take(5).map((item) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: borderColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: redColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            _getExpenseIcon(item.category),
                            color: redColor,
                          ),
                        ),

                        const SizedBox(width: 13),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                item.category,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 13,
                                ),
                              ),

                              if (item.description.isNotEmpty) ...[
                                const SizedBox(height: 3),
                                Text(
                                  item.description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white38,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          "- Rs. ${item.amount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: redColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

              if (expenses.length > 5)
                TextButton(
                  onPressed: () {
                    _showComingSoonMessage(
                      "Full expense history coming soon 💳",
                    );
                  },
                  child: const Text(
                    "View all expenses",
                    style: TextStyle(color: goldColor),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final double balance;

  const _BalanceCard({required this.balance});

  @override
  Widget build(BuildContext context) {
    final bool isPositive = balance >= 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: isPositive
              ? const [Color(0xFF075E2D), Color(0xFF0D8A43)]
              : const [Color(0xFF7D1717), Color(0xFFB52A2A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: isPositive
              ? _HomeScreenState.greenColor.withOpacity(0.50)
              : _HomeScreenState.redColor.withOpacity(0.50),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.white,
                size: 22,
              ),
              SizedBox(width: 9),
              Text(
                "Current Balance",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            "Rs. ${balance.toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 31,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "MyFinance",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  isPositive ? "Healthy Balance" : "Negative Balance",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: _HomeScreenState.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _HomeScreenState.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, color: color, size: 19),
          ),

          const SizedBox(height: 13),

          Text(
            title,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),

          const SizedBox(height: 5),

          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              "Rs. ${amount.toStringAsFixed(2)}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _HomeScreenState.cardColor,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: _HomeScreenState.borderColor),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon, color: color),
              ),

              const SizedBox(height: 9),

              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyExpenses extends StatelessWidget {
  const _EmptyExpenses();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 42),
      decoration: BoxDecoration(
        color: _HomeScreenState.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _HomeScreenState.borderColor),
      ),
      child: const Column(
        children: [
          Icon(Icons.receipt_long_outlined, color: Colors.white38, size: 52),
          SizedBox(height: 13),
          Text(
            "No expenses yet",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Add your first expense to begin tracking.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white38, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
