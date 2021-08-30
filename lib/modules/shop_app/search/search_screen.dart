//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppSearchCubit(),
      child: BlocConsumer<ShopAppSearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultTextField(
                          label: 'Search',
                          type: TextInputType.text,
                          prefix: Icons.search_outlined,
                          controller: searchController,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'enter text to search';
                            }
                            return null;
                          },
                          onSubmit: (String text) {
                            ShopAppSearchCubit.get(context).search(text);
                          }),
                      const SizedBox(
                        height: 5.0,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(),
                      const SizedBox(
                        height: 5.0,
                      ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildListProduct(
                              ShopAppSearchCubit.get(context)
                                  .model
                                  .data
                                  .data[index],
                              context,
                              isOldPrice: false,
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10.0,
                            ),
                            itemCount: ShopAppSearchCubit.get(context)
                                .model
                                .data
                                .data
                                .length,
                          ),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
