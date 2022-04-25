// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/ShopCubit.dart';
import '../../Bloc/ShopStates.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formedKey = GlobalKey<FormState>();

  SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          titleSpacing: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formedKey,
            child: Column(
              children: [
                buildTextFormField(
                    controller: searchController,
                    label: 'Search',
                    prefix: Icons.search,
                    inputType: TextInputType.text,
                    validatorFun: (input) {
                      if (input!.isEmpty) {
                        return 'keyword should be exist';
                      }
                      return null;
                    },
                    onSubmittedFun: (input) {
                      if (formedKey.currentState!.validate()) {
                        ShopCubit.getInstance(context).searchInProducts(input);
                      }
                    }),
                Expanded(
                  child: ConditionalBuilder(
                    condition: state is! ShopLoadingState,
                    builder: (context) => searchModel != null
                        ? ListView.separated(
                            itemBuilder: (context, index) =>
                                buildSearchItem(index, context),
                            separatorBuilder: (context, index) =>
                                buildListSeparator(),
                            itemCount: searchModel!.data!.data.length)
                        : const Center(
                            child: Text(
                            'Start Searching Above For Show Results Here',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          )),
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearchItem(index, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              image: CachedNetworkImageProvider(
                  searchModel!.data!.data[index].image!,
                  errorListener: () {}),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      searchModel!.data!.data[index].name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          '${searchModel!.data!.data[index].price.round()!} LE',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: appColor, fontSize: 12, height: 1.1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
