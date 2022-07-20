import 'package:dbms_project/utils/utils.dart';
import 'package:flutter/scheduler.dart';

import '../notifiers/notifiers.dart';
import '../../../widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer(builder: (context, ref, child) {
        final homeNotifier = ref.read(homeStateNotifier.notifier);
        final state = ref.watch(homeStateNotifier);
        if (state is LoadingHome) {
          SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
            homeNotifier.fetchData();
          });
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        } else if (state is ReadyHome) {
          return Padding(
            padding: EdgeInsets.only(
              top: smallVP,
            ),
            child: ListView.builder(
              itemCount: state.scholarships.length,
              itemBuilder: (context, index) => Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: smallHP,
                    vertical: smallVP / 2,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: smallHP,
                      vertical: smallVP / 2,
                    ),
                    height: size.height * 0.4,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Scholarship Id: " +
                              state.scholarships[index].schid.toString(),
                          style: defaultTextStyle,
                        ),
                        Text(
                          "Season: " + state.scholarships[index].season,
                          style: defaultTextStyle,
                        ),
                        Text(
                          "Funding: " +
                              (state.scholarships[index].funding ?? "-"),
                          style: defaultTextStyle,
                        ),
                        Text(
                          "Eligibility: " +
                              state.scholarships[index].eligibility,
                          style: defaultTextStyle,
                        ),
                        Text(
                          "Applicable for gender: " +
                              state.scholarships[index].gender,
                          style: defaultTextStyle,
                        ),
                        Text(
                          "Max Age: " +
                              state.scholarships[index].maxAge.toString(),
                          style: defaultTextStyle,
                        ),
                        GoodButton(
                          text: state.scholarships[index].applied
                              ? "Already applied"
                              : "Apply",
                          borderColor: state.scholarships[index].applied
                              ? Colors.grey
                              : null,
                          bgColor: state.scholarships[index].applied
                              ? Colors.grey
                              : Colors.green,
                          textColor: Colors.white,
                          onTap: () {
                            if (!state.scholarships[index].applied) {
                              homeNotifier.apply(index);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Column(
              children: [
                Icon(
                  Icons.warning,
                  size: size.width * 0.2,
                ),
                SizedBox(
                  height: smallVP,
                ),
                GoodButton(
                  text: "Retry",
                  onTap: () async {
                    homeNotifier.retry();
                  },
                  borderColor: Colors.white,
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
