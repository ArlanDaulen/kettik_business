import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/custom_app_bar.dart';

class HelpScreen extends StatefulWidget {
  HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  List<String> questions = [
    'What is this app for?',
    'Why Ali damn it?',
    'Is Asylzhan a lot of people?',
    'And what about Spat?',
  ];

  List<String> answers = [
    'Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
    'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ',
  ];

  List<bool> isAnswerVisible = List.generate(4, (index) => false);

  setAnswersVisibility(int index) {
    setState(() {
      isAnswerVisible[index] = !isAnswerVisible[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Help',
        isWithBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(40),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Text(
              'Frequently asked Questions',
              style: TextStyle(
                fontSize: getProportionateScreenHeight(42),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: questions.length,
                separatorBuilder: (_, index) => SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                itemBuilder: (_, index) => InkWell(
                  onTap: () => setAnswersVisibility(index),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            questions[index],
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(32),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SvgPicture.asset(
                            isAnswerVisible[index]
                                ? AppSvgImages.minus_ic
                                : AppSvgImages.plus_ic,
                            width: getProportionateScreenWidth(
                                isAnswerVisible[index] ? 10 : 30),
                            height: getProportionateScreenHeight(
                                isAnswerVisible[index] ? 6 : 30),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      isAnswerVisible[index]
                          ? Text(
                              answers[index],
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(28),
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          : const SizedBox(),
                      const Divider(
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
