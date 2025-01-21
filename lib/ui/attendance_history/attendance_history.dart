import 'package:dpp_mobile/bloc/attendance_bloc.dart';
import 'package:dpp_mobile/repository/odoo_repository.dart';
import 'package:dpp_mobile/services/odoo_service.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/attendance_latest_list_item.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
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
                        ListView.builder(
                          itemCount: state.attendances.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            return latestAttendanceListItem(
                              state.attendances[index],
                              context,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  );
                } else if (state.status.isError) {
                  return Center(
                    child: Text(
                      'Terjadi Kesalahan',
                      style: createBlackTextStyle(14),
                    ),
                  );
                } else if (state.status.isLoading) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: SizedBox(
                        width: 64,
                        child: LinearProgressIndicator(
                          color: AppColors().primaryColor,
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
