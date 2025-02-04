import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/bloc/list_attendances_bloc.dart';
import 'package:dpp_mobile/repository/odoo_repository.dart';
import 'package:dpp_mobile/services/odoo_service.dart';
import 'package:dpp_mobile/ui/attendance_history/widgets/attendance_history_error.dart';
import 'package:dpp_mobile/ui/attendance_history/widgets/attendance_history_loading.dart';
import 'package:dpp_mobile/ui/attendance_history/widgets/attendance_history_success.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class AttendanceHistory extends StatelessWidget {
  const AttendanceHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => OdooRepository(service: OdooService()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AttendanceBloc>(
            create: (context) => AttendanceBloc(
              odooRepository: context.read<OdooRepository>(),
            )..add(GetAttendance()),
          ),
          BlocProvider<EmployeeBloc>(
            create: (context) => EmployeeBloc(
              odooRepository: context.read<OdooRepository>(),
            )..add(GetEmployee()),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Iconsax.arrow_left_2,
                color: Colors.black,
              ),
            ),
            title: Text(
              "Riwayat Kehadiran",
              style: createBlackTextStyle(18),
            ),
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
                if (state.status.isLoading) {
                  return const AttendanceHistoryLoading();
                }
                if (state.status.isSuccess) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        AttendanceHistorySuccess(
                          attendanceList: state.attendances,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  );
                }
                return const AttendanceHistoryError();
              },
            ),
          ),
        ),
      ),
    );
  }
}
