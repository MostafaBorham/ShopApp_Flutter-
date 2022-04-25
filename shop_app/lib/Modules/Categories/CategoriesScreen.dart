// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../Models/CategoryModel.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) =>
          buildCategoryListItem(categoryModel!.data!.data[index]),
      separatorBuilder: (context, index) => buildListSeparator(),
      itemCount: categoryModel!.data!.data.length,
    );
  }

  Widget buildCategoryListItem(CategoryDetailDataModel model) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              width: 100,
              height: 100,
              image: CachedNetworkImageProvider(model.image!,
                  errorListener: () {}),
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              model.name!,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
}
