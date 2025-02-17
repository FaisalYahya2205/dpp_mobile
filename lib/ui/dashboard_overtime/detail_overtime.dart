import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/models/overtime.dart';
import 'package:dpp_mobile/repository/odoo_repository.dart';
import 'package:dpp_mobile/services/odoo_service.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class DetailOvertime extends StatelessWidget {
  const DetailOvertime({
    super.key,
    required this.overtime,
  });

  final Overtime overtime;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => OdooRepository(service: OdooService()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EmployeeBloc>(
            create: (context) => EmployeeBloc(
              odooRepository: context.read<OdooRepository>(),
            )..add(GetEmployee()),
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(false);
              },
              child: const Icon(
                Iconsax.arrow_left_2,
                color: Colors.black,
              ),
            ),
            title: Text(
              "Detail Overtime",
              style: createBlackTextStyle(18),
            ),
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          overtime.name!,
                          style: createBlackMediumTextStyle(18),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Request Validation",
                            style: createPrimaryBoldTextStyle(14),
                          ),
                        ),
                      ],
                    ),
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
                        elevation: 0,
                      ),
                      child: Text(
                        "Ubah Profile",
                        style: createWhiteBoldTextStyle(14),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          overtime.name!,
                          style: createBlackMediumTextStyle(18),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Request Validation",
                            style: createPrimaryBoldTextStyle(14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
