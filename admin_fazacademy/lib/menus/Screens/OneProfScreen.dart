import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../controllers/controllers/profmodel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class OneProfScreen extends StatelessWidget {
  const OneProfScreen({super.key,required this.prof});
  final ProfModel prof;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherStatsController());

    return Scaffold(
      appBar: AppBar(
        title: Text("إحصائيات الأستاذ", style: GoogleFonts.readexPro(fontWeight: FontWeight.bold)),
      ),
      body: GetBuilder<TeacherStatsController>(
        builder: (c) {
          if (c.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRowProf(prof.prenom, "الإسم"),
                _infoRowProf(prof.nom, "اللقب"),
                _infoRowProf(prof.numero, "رقم الهاتف"),
                _infoRowProf("${prof.email}", "أيميل"),

                SizedBox(height: 10,),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _statCard("عدد الحصص", c.totalClasses.toString(), Icons.school),
                    _statCard("مجموع الأرباح", "${c.totalEarnings} دج", Icons.attach_money),
                    _statCard("الأرباح هذا الشهر", "${c.earningsThisMonth} دج", Icons.calendar_today),
                    _statCard("عدد التلاميذ", c.studentsTaught.toString(), Icons.person),
                  ],
                ),
                const SizedBox(height: 32),
                Text("نشاط الأسبوع", style: GoogleFonts.readexPro(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                SizedBox(height: 200, child: LineChart(c.getWeeklyActivityChart())),
                const SizedBox(height: 32),
                Text("مداخيل الأشهر", style: GoogleFonts.readexPro(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                SizedBox(height: 200, child: BarChart(c.getMonthlyRevenueChart())),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30, color: Colors.purple),
          const SizedBox(height: 10),
          Text(value, style: GoogleFonts.readexPro(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(title, style: GoogleFonts.readexPro(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}



class TeacherStatsController extends GetxController {
  bool isLoading = true;
  int totalClasses = 0;
  int totalEarnings = 0;
  int earningsThisMonth = 0;
  int studentsTaught = 0;

  List<int> weeklyActivity = []; // e.g. [3, 5, 2, 4, 6, 1, 3]
  List<int> monthlyEarnings = []; // e.g. [12000, 15000, 17000, 10000, ...]

  @override
  void onInit() {
    super.onInit();
    loadStats();
  }

  void loadStats() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate data load

    // Dummy data (replace with Firebase fetch logic)
    totalClasses = 0;
    totalEarnings = 0;
    earningsThisMonth = 0;
    studentsTaught = 0;

    weeklyActivity = [3, 5, 2, 4, 6, 1, 3];
    monthlyEarnings = [12000, 15000, 17000, 10000, 14000, 16000];

    isLoading = false;
    update();
  }
Future<int> loadtotalclasses() async {


    return 0;
}
  Map<ProfModel, List<String>> generateProfStatistics(List<ProfModel> allProfs) {
    final Map<ProfModel, List<String>> profStatsMap = {};
    int MonthDoneSessions = 0;
    int AllDoneSessios = 0 ;
    int ClassesFailedThisMonth = 0;

    for (final prof in allProfs) {
      // Get all classes this prof teaches
      final classes = AdminController.instance.MyClasses
          .where((classe) => classe.profID == prof.id)
          .toList();

      // Total students taught
      final totalStudents = classes.fold<int>(
        0,
            (sum, c) => sum + (c.listeleve.length ?? 0),
      );

        AllDoneSessios = classes.where((session) => session.pointed == true).length;
        MonthDoneSessions = classes
            .where((session) =>
            session.pointed == true &&
            session.dateTime.month == DateTime.now().month &&
            session.dateTime.year == DateTime.now().year)
            .length;
        ClassesFailedThisMonth = classes
            .where((session) =>
        session.pointed == false &&
            session.dateTime.isBefore(DateTime.now()) &&
            session.dateTime.month == DateTime.now().month &&
            session.dateTime.year == DateTime.now().year)
            .length;


      // Total income (assume prof.salary is monthly and fixed per class)
      final totalIncome = AllDoneSessios * (prof.CoupParClass ?? 0);

      // Create readable statistics
      final List<String> stats = [
        "${classes.length}",
        "$totalStudents",
        "${totalIncome}",
        "${MonthDoneSessions}",
        "${AllDoneSessios}"
      ];

      profStatsMap[prof] = stats;
    }

    return profStatsMap;
  }

  LineChartData getWeeklyActivityChart() {
    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            weeklyActivity.length,
                (index) => FlSpot(index.toDouble(), weeklyActivity[index].toDouble()),
          ),
          isCurved: true,
          barWidth: 3,
          color: Colors.orange,
          dotData: FlDotData(show: true),
        )
      ],
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, _) {
              const days = ['أحد', 'إثن', 'ثلا', 'أرب', 'خمي', 'جمع', 'سبت'];
              return Text(days[value.toInt() % 7], style: const TextStyle(fontSize: 10));
            },
          ),
        ),
      ),
    );
  }

  BarChartData getMonthlyRevenueChart() {
    return BarChartData(
      barGroups: List.generate(
        monthlyEarnings.length,
            (index) => BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(toY: monthlyEarnings[index].toDouble(), color: Colors.green, width: 14),
          ],
        ),
      ),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, _) {
              const months = ['جان', 'فيف', 'مار', 'أف', 'ماي', 'جوان', 'جوي', 'أوغ', 'سب', 'أكت', 'نوف', 'ديس'];
              return Text(months[value.toInt() % 12], style: const TextStyle(fontSize: 10));
            },
          ),
        ),
      ),
    );
  }
}

Widget _infoRowProf(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 5),
    child: Row(
      children: [
        // Value on the left - ellipsed
        Text(
          value,
          textAlign: TextAlign.right,
          style: GoogleFonts.readexPro(
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
        SizedBox(width: 16), // consistent spacing
        // Label on the right - bold and fixed
        Text(
          label,
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.readexPro(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      ],
    ),
  );
}