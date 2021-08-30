//@dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';


class SettingsScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopAppCubit.get(context).userModel;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopAppCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopAppLoadingUpdateUserState)
                    LinearProgressIndicator(),
                  const SizedBox(height: 20.0),
                  defaultTextField(
                    controller: nameController,
                    type: TextInputType.text,
                    label: 'Name',
                    prefix: Icons.person_outline,
                    suffix: Icons.edit_outlined,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  defaultTextField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Name',
                    prefix: Icons.mail_outline,
                    suffix: Icons.edit_outlined,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  defaultTextField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone',
                    prefix: Icons.phone_outlined,
                    suffix: Icons.edit_outlined,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'phone number must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30.0),
                  defaultButton(
                      text: 'update',
                      function: () {
                        if (formKey.currentState.validate()) {
                          ShopAppCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      }),
                  const SizedBox(height: 20.0),
                  defaultButton(
                      text: 'logout',
                      function: () {
                        signOut(context);
                      }),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
