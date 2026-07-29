import 'package:flutter/material.dart';

import '../../services/expense_service.dart';
import '../../services/income_service.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/dashboard_card.dart';
import '../add_expense/add_expense_screen.dart';
import '../income/add_income_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      ..showSnackBar(SnackBar(content: Text(message)));
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
        _showComingSoonMessage("Income screen coming soon 🚀");
        break;

      case 2:
        _showComingSoonMessage("Reports screen coming soon 📊");
        break;

      case 3:
        _showComingSoonMessage("Profile screen coming soon 👤");
        break;
    }

    // Keep the Home icon selected until the other pages are created.
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

  @override
  Widget build(BuildContext context) {
    final double income = IncomeService.totalIncome;
    final double expense = ExpenseService.totalExpense;
    final double balance = income - expense;

    final expenses = ExpenseService.expenses.reversed.toList();

    return Scaffold(
      appBar: AppBar(title: const Text("MyFinance"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello Umair 👋",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              BalanceCard(balance: balance),

              const SizedBox(height: 20),

              DashboardCard(
                title: "Total Income",
                value: "Rs. ${income.toStringAsFixed(2)}",
                color: Colors.green,
                icon: Icons.trending_up,
              ),

              const SizedBox(height: 15),

              DashboardCard(
                title: "Total Expenses",
                value: "Rs. ${expense.toStringAsFixed(2)}",
                color: Colors.red,
                icon: Icons.trending_down,
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent Expenses",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${expenses.length} items",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Expanded(
                child: expenses.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 60,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 12),
                            Text(
                              "No expenses yet",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          final item = expenses[index];

                          final String subtitle = item.description.isEmpty
                              ? item.category
                              : "${item.category}\n${item.description}";

                          return Card(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.red.shade100,
                                child: const Icon(
                                  Icons.receipt_long,
                                  color: Colors.red,
                                ),
                              ),
                              title: Text(
                                item.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(subtitle),
                              isThreeLine: item.description.isNotEmpty,
                              trailing: Text(
                                "Rs. ${item.amount.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
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
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "incomeButton",
            backgroundColor: Colors.green,
            onPressed: _openIncomeScreen,
            tooltip: "Add income",
            child: const Icon(Icons.add, color: Colors.white),
          ),

          const SizedBox(height: 15),

          FloatingActionButton(
            heroTag: "expenseButton",
            backgroundColor: Colors.red,
            onPressed: _openExpenseScreen,
            tooltip: "Add expense",
            child: const Icon(Icons.remove, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
