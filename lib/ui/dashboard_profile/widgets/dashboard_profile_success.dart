import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iconsax/iconsax.dart';

class DashboardProfileSuccess extends StatelessWidget {
  const DashboardProfileSuccess({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    final employeeBloc = BlocProvider.of<EmployeeBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: employee.id != 0
          ? RefreshIndicator(
              onRefresh: () async => employeeBloc.add(const GetEmployee()),
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          "${dotenv.env['URL']}/web/image?model=hr.employee&id=${employee.id!}&field=image_128",
                          headers: {
                            'Cookie':
                                'session_id=${localSession!.first["session_id"]}',
                          },
                        ),
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
                      employee.jobTitle!,
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
                            borderRadius: BorderRadius.circular(16),
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
                    ProfileItem(
                      icon: Iconsax.user_tag,
                      title: "NRP",
                      value: employee.nrp!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ProfileItem(
                      icon: Iconsax.user_tag,
                      title: "Nama",
                      value: employee.name!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ProfileItem(
                      icon: Iconsax.call,
                      title: "Work Mobile",
                      value: employee.workPhone!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ProfileItem(
                      icon: Iconsax.sms,
                      title: "Work Email",
                      value: employee.workEmail!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ProfileItem(
                      icon: Iconsax.building,
                      title: "Work Location",
                      value: employee.addressId!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ProfileItem(
                      icon: Iconsax.user_octagon,
                      title: "Manager",
                      value: employee.parentId!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: () async => employeeBloc.add(const GetEmployee()),
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
                          'Cookie':
                              'session_id=${localSession!.first["session_id"]}',
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      localSession!.first["user_name"],
                      style: createBlackTextStyle(20),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(
                        child: Text(
                          "Anda belum terdaftar sebagai karyawan.\nBila masih terjadi kendala harap hubungi Admin untuk info lebih lanjut...",
                          style: createBlackThinTextStyle(14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors().primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Icon(
              icon,
              color: AppColors().primaryColor,
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: createBlackMediumTextStyle(16),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                value,
                style: createBlackThinTextStyle(14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
