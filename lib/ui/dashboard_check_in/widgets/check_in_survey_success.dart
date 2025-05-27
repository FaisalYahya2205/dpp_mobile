// ignore_for_file: use_build_context_synchronously

import 'package:dpp_mobile/bloc/attendance/survey/survey_bloc.dart';
import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/survey.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/dialogs/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget that displays the success state of a check-in survey
class CheckInSurveySuccess extends StatelessWidget {
  final Survey questions;
  final int attendanceId;

  const CheckInSurveySuccess({
    super.key,
    required this.questions,
    required this.attendanceId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInSurveyBloc, CheckInSurveyState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: questions.questions?.length ?? 0,
                  itemBuilder: (context, index) {
                    final question = questions.questions![index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${question.sequence}. ${question.title}",
                            style: createBlackTextStyle(16),
                          ),
                          const SizedBox(height: 12),
                          ...List.generate(
                            question.answer!.length,
                            (answerIndex) {
                              final answer = question.answer![answerIndex];
                              return GestureDetector(
                                onTap: () {
                                  context.read<CheckInSurveyBloc>().add(
                                        SelectSurveyAnswer(
                                          questionId: question.id!,
                                          answer: answer,
                                        ),
                                      );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: answer.isSelected
                                        ? AppColors().primaryColor.withAlpha(25)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: answer.isSelected
                                          ? AppColors().primaryColor
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        answer.isSelected
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_unchecked,
                                        size: 20,
                                        color: answer.isSelected
                                            ? AppColors().primaryColor
                                            : Colors.grey.shade400,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          answer.value!,
                                          style: createBlackTextStyle(14),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors()
                                              .primaryColor
                                              .withAlpha(25),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          "Score: ${answer.answerScore}",
                                          style:
                                              createBlackTextStyle(12).copyWith(
                                            color: AppColors().primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // if (state.status.isLoading) return;
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext dialogContext) => AppDialog(
                          type: "loading",
                          title: "Memproses",
                          message: "Mohon tunggu...",
                          onOkPress: () {},
                        ),
                      );

                      context.read<CheckInSurveyBloc>().add(
                            SubmitSurvey(
                              attendanceId: attendanceId,
                              partnerId: localSession!.first[
                                  "partner_id"], // Replace with actual partner ID
                              userInputId: DateTime.now()
                                  .millisecondsSinceEpoch, // Generate unique ID
                            ),
                          );

                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                      });

                      // if (state.status.isSuccess &&
                      //     state.submitSuccess == true) {
                      //   showDialog(
                      //     barrierDismissible: false,
                      //     context: context,
                      //     builder: (BuildContext dialogContext) => AppDialog(
                      //       type: "success",
                      //       title: "Survey Berhasil Dikirim",
                      //       message: "mengalihkan ke dashboard...",
                      //       onOkPress: () {},
                      //     ),
                      //   );
                      //   Future.delayed(const Duration(seconds: 2), () {
                      //     context.pushReplacement("/dashboard");
                      //   });
                      // }

                      // if (state.status.isError) {
                      //   Navigator.of(context).pop();
                      //   // show error dialog
                      //   showDialog(
                      //     barrierDismissible: false,
                      //     context: context,
                      //     builder: (BuildContext dialogContext) => AppDialog(
                      //       type: "error",
                      //       title: "Check In Gagal",
                      //       message: "Terjadi kesalahan...",
                      //       onOkPress: () {
                      //         Navigator.of(context).pop();
                      //       },
                      //     ),
                      //   );
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors().primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: state.status.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            "Submit Survey",
                            style: createWhiteBoldTextStyle(16),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
