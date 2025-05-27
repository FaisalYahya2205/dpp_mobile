// ignore_for_file: use_build_context_synchronously

import 'package:dpp_mobile/bloc/attendance/survey/survey_bloc.dart';
import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/repository/attendance_repository.dart';
import 'package:dpp_mobile/repository/employee_repository.dart';
import 'package:dpp_mobile/services/attendance_service.dart';
import 'package:dpp_mobile/services/employee_service.dart';
import 'package:dpp_mobile/ui/dashboard_check_in/widgets/check_in_survey_error.dart';
import 'package:dpp_mobile/ui/dashboard_check_in/widgets/check_in_survey_loading.dart';
import 'package:dpp_mobile/ui/dashboard_check_in/widgets/check_in_survey_success.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:translator/translator.dart';

class DashboardHomeCheckInSurvey extends StatelessWidget {
  final int attendanceId;

  const DashboardHomeCheckInSurvey({super.key, required this.attendanceId});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AttendanceRepository>(
          create: (_) => AttendanceRepository(
            service: AttendanceService(),
          ),
        ),
        RepositoryProvider<EmployeeRepository>(
          create: (_) => EmployeeRepository(
            service: EmployeeService(translator: GoogleTranslator()),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EmployeeBloc>(
            create: (context) => EmployeeBloc(
              employeeRepository: context.read<EmployeeRepository>(),
            )..add(const GetEmployee()),
          ),
          BlocProvider<CheckInSurveyBloc>(
            create: (context) => CheckInSurveyBloc(
              attendanceRepository: context.read<AttendanceRepository>(),
            )..add(const GetCheckInSurvey()),
          ),
        ],
        child: _DashboardHomeCheckInSurveyView(
          attendanceId: attendanceId,
        ),
      ),
    );
  }
}

class _DashboardHomeCheckInSurveyView extends StatelessWidget {
  const _DashboardHomeCheckInSurveyView({required this.attendanceId});

  final int attendanceId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Survey Check In",
          style: createBlackTextStyle(18),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: BlocBuilder<CheckInSurveyBloc, CheckInSurveyState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const CheckInSurveyLoading();
            }
            if (state.status.isSuccess) {
              return CheckInSurveySuccess(
                attendanceId: attendanceId,
                questions: state.surveyQuestions,
              );
            }
            return CheckInSurveyError(
              onRetry: () {
                context.read<CheckInSurveyBloc>().add(const GetCheckInSurvey());
              },
            );
          },
        ),
      ),
    );
  }
}
