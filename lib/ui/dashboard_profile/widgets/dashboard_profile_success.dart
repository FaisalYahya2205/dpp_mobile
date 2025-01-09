import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class DashboardProfileSuccess extends StatelessWidget {
  const DashboardProfileSuccess({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    final employeeBloc = BlocProvider.of<EmployeeBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
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
                  color: AppColors().primaryColor.shade50.withAlpha(50),
                ),
                child: Image.network(
                  "https://dpp.tbdigitalindo.co.id/web/image?model=hr.employee&id=${employee.id}&field=image_128",
                  headers: {
                    'Cookie': 'session_id=${localSession!.first["id"]}',
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                employee.name!,
                style: createBlackTextStyle(20),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                employee.job_title!,
                style: createBlackThinTextStyle(14),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors().primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Ubah Profile",
                    style: createWhiteBoldTextStyle(14),
                  ),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              profileItem(
                Iconsax.user_tag,
                "NRP",
                employee.nrp!,
              ),
              const SizedBox(
                height: 16,
              ),
              profileItem(
                Iconsax.user_tag,
                "Nama",
                employee.name!,
              ),
              const SizedBox(
                height: 16,
              ),
              profileItem(
                Iconsax.call,
                "Work Mobile",
                employee.work_phone!,
              ),
              const SizedBox(
                height: 16,
              ),
              profileItem(
                Iconsax.sms,
                "Work Email",
                employee.work_email!,
              ),
              const SizedBox(
                height: 16,
              ),
              profileItem(
                Iconsax.building,
                "Work Location",
                employee.address_id!,
              ),
              const SizedBox(
                height: 16,
              ),
              profileItem(
                Iconsax.user_octagon,
                "Manager",
                employee.parent_id!,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
