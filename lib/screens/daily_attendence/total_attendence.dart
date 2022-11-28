import 'package:flutter/material.dart';
import 'package:wage_management/screens/daily_attendence/widgets/custom_animation_container.dart';
import 'package:wage_management/screens/daily_attendence/widgets/floating_card.dart';

class TotalAttendenceScreen extends StatelessWidget {
  const TotalAttendenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
        
            children: [
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: (() {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );
                  // Get.to(DatePickerDialog(
                  //   initialDate: DateTime.now(),
                  //   firstDate: DateTime(2000),
                  //   lastDate: DateTime(2100),
                  // ));
                }),
                child: Container(
                  width: 120,
                  height: 40,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const CustomCard(),
               const SizedBox(
                height: 50,
              ),
              CustomAnimationContainer()
             
        
            ],
          ),
        ),
      ),
    );
  }
}
