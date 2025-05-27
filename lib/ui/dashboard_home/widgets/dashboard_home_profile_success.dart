import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DashboardHomeProfileSuccess extends StatelessWidget {
  const DashboardHomeProfileSuccess({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 48,
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.shade200,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  "${dotenv.env['URL']}/web/image?model=hr.employee&id=${employee.id!}&field=image_128",
                  headers: {
                    'Cookie': 'session_id=${localSession!.first["session_id"]}',
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - (48 + 66),
                  child: Text(
                    employee.id! == 0
                        ? localSession!.first["user_name"]
                        : employee.name!,
                    style: createBlackTextStyle(20),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: employee.id! == 0 ? 0 : 8,
                ),
                employee.id! == 0
                    ? const SizedBox()
                    : Text(
                        employee.jobTitle!,
                        style: createBlackThinTextStyle(14),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
