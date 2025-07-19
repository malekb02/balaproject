import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../components/common/appBar.dart';
import '../../../controllers/controllers/updateuserNameController.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/validators/validators.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text("Change Name",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.defaultspace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Use real name for easy verification, This name will appear on several pages.",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: AppSizes.spaceBtwSections,),

            Form(
              key: controller.updateNameForm,
                child: Column(
                    children: [
                      TextFormField(
                        controller: controller.firstName,
                        validator: (value)=> AppValidator.validateEmptyText("First name", value),
                        expands: false,
                        decoration: InputDecoration(labelText: "First Name",prefixIcon: Icon(Iconsax.user)),
                      ),
                      SizedBox(height: AppSizes.spaceBtwinputFields,),
                      TextFormField(
                        controller: controller.lastName,
                        validator: (value)=> AppValidator.validateEmptyText("Last name", value),
                        expands: false,
                        decoration: InputDecoration(labelText: "Last Name",prefixIcon: Icon(Iconsax.user)),
                      ),

                      SizedBox(height: AppSizes.spaceBtwSections,),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: ()=> controller.updateUserName(),child: Text("Save"),),
                      )
                    ],
                )
            )
          ],
        ),
      ),
    );
  }
}
