import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/bloc/overtime_bloc.dart';
import 'package:dpp_mobile/ui/dashboard_overtime/add_edit_overtime.dart';
import 'package:dpp_mobile/ui/dashboard_overtime/widgets/dashboard_home_overtime_error.dart';
import 'package:dpp_mobile/ui/dashboard_overtime/widgets/dashboard_home_overtime_loading.dart';
import 'package:dpp_mobile/ui/dashboard_overtime/widgets/dashboard_home_overtime_success.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class DashboardOvertime extends StatefulWidget {
  const DashboardOvertime({super.key});

  @override
  State<DashboardOvertime> createState() => _DashboardOvertimeState();
}

class _DashboardOvertimeState extends State<DashboardOvertime> {
  TextEditingController searchOvertimeTextController = TextEditingController();
  String selectedState = "";

  @override
  void initState() {
    super.initState();
    selectedState = "draft";
  }

  void refreshData() {
    BlocProvider.of<EmployeeBloc>(context).add(
      GetEmployee(),
    );
    BlocProvider.of<OvertimeBloc>(context).add(
      GetOvertimeList(overtimeState: selectedState),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top + 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Text(
                  "Overtime",
                  style: createBlackMediumTextStyle(20),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    bool success = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddEditOvertime(),
                      ),
                    );

                    if (success) {
                      refreshData();
                    }
                  },
                  child: const Icon(
                    Iconsax.add_square,
                    color: Colors.black54,
                    size: 24,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Iconsax.setting_4,
                    color: Colors.black54,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
          //   child: TextFormField(
          //     controller: searchOvertimeTextController,
          //     decoration: InputDecoration(
          //       enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(16),
          //         borderSide: BorderSide(
          //           color: Colors.grey.shade200,
          //           width: 1,
          //         ),
          //       ),
          //       focusedBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(16),
          //         borderSide: BorderSide(
          //           color: AppColors().primaryColor,
          //           width: 1,
          //         ),
          //       ),
          //       errorBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(16),
          //         borderSide: const BorderSide(
          //           color: Colors.red,
          //           width: 1,
          //         ),
          //       ),
          //       hintText: "",
          //       contentPadding: const EdgeInsets.all(16.0),
          //       label: const Text("Search..."),
          //       labelStyle: createGreyThinTextStyle(14),
          //       suffixIcon: const Icon(Iconsax.search_normal_1),
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 16,
          // ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedState = "draft";
                      });
                      BlocProvider.of<OvertimeBloc>(context).add(
                        GetOvertimeList(overtimeState: selectedState),
                      );
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: selectedState == "draft"
                            ? AppColors().primaryColor
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        "Draft",
                        style: selectedState == "draft"
                            ? createWhiteThinTextStyle(14)
                            : createBlackThinTextStyle(14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedState = "f_approved";
                      });
                      BlocProvider.of<OvertimeBloc>(context).add(
                        GetOvertimeList(overtimeState: selectedState),
                      );
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: selectedState == "f_approved"
                            ? AppColors().primaryColor
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        "Waiting",
                        style: selectedState == "f_approved"
                            ? createWhiteThinTextStyle(14)
                            : createBlackThinTextStyle(14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedState = "approved";
                      });
                      BlocProvider.of<OvertimeBloc>(context).add(
                        GetOvertimeList(overtimeState: selectedState),
                      );
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: selectedState == "approved"
                            ? AppColors().primaryColor
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        "Approved",
                        style: selectedState == "approved"
                            ? createWhiteThinTextStyle(14)
                            : createBlackThinTextStyle(14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: BlocBuilder<EmployeeBloc, EmployeeState>(
                builder: (context, state) {
                  if (state.status.isSuccess && state.employee.id == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(
                        child: Text(
                          "Anda belum terdaftar sebagai karyawan.\nBila masih terjadi kendala harap hubungi Admin untuk info lebih lanjut...",
                          style: createBlackThinTextStyle(14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async => refreshData(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16.0,
                            ),
                            BlocBuilder<OvertimeBloc, OvertimeState>(
                              builder: (context, state) {
                                if (state.status.isLoading) {
                                  return const DashboardHomeOvertimeLoading();
                                }
                                if (state.status.isError) {
                                  return const DashboardHomeOvertimeError();
                                }

                                debugPrint("Overtimes => ${state.overtimes}");
                                return DashboardHomeOvertimeSuccess(
                                  overtimes: state.overtimes,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 96.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
