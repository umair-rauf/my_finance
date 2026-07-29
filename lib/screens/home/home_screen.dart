import 'package:flutter/material.dart';
import '../../services/expense_service.dart';
import '../../services/income_service.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/dashboard_card.dart';
import '../../widgets/bottom_nav.dart';
import '../add_expense/add_expense_screen.dart';
import '../income/add_income_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  Future<void> _refresh() async {
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;

      case 1:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Income screen coming soon 🚀")),
        );
        break;

      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Reports screen coming soon 📊")),
        );
        break;

      case 3:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile screen coming soon 👤")),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double income = IncomeService.totalIncome;
    final double expense = ExpenseService.totalExpense;
    final double balance = income - expense;

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

              const Text(
                "Recent Expenses",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ExpenseService.expenses.isEmpty
                    ? const Center(
                        child: Text(
                          "No expenses yet",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: ExpenseService.expenses.length,
                        itemBuilder: (context, index) {
                          final item = ExpenseService.expenses[index];

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
                              title: Text(item.title),
                              subtitle: Text(
                                "${item.category}\n${item.description}",
                              ),
                              isThreeLine: true,
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
            heroTag: "income",
            backgroundColor: Colors.green,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddIncomeScreen()),
              );

              _refresh();
            },
            child: const Icon(Icons.add),
          ),

          const SizedBox(height: 15),

          FloatingActionButton(
            heroTag: "expense",
            backgroundColor: Colors.red,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
              );

              _refresh();
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
