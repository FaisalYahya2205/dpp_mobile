import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardProfileLoading extends StatelessWidget {
  const DashboardProfileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final employeeBloc = BlocProvider.of<EmployeeBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: RefreshIndicator(
          onRefresh: () async => employeeBloc.add(GetEmployee()),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).viewPadding.top,
                ),
                const SizedBox(
                  height: 48,
                ),
                Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: 256,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.shade200,
                  ),
                  child: Text(
                    "",
                    style: createBlackTextStyle(20),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: 128,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.shade200,
                  ),
                  child: Text(
                    "",
                    style: createBlackThinTextStyle(14),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                const ProfileItem(),
                const SizedBox(
                  height: 16,
                ),
                const ProfileItem(),
                const SizedBox(
                  height: 16,
                ),
                const ProfileItem(),
                const SizedBox(
                  height: 16,
                ),
                const ProfileItem(),
                const SizedBox(
                  height: 16,
                ),
                const ProfileItem(),
                const SizedBox(
                  height: 16,
                ),
                const ProfileItem(),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: const SizedBox(
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 256,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  "",
                  style: createBlackMediumTextStyle(16),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                width: 128,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  "",
                  style: createBlackThinTextStyle(14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
