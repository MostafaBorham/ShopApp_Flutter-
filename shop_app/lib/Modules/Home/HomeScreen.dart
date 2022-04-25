// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/ShopCubit.dart';
import '../../Bloc/ShopStates.dart';
import '../../Models/CategoryModel.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cubit = ShopCubit.getInstance(context);
    getHomeData();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: homeModel != null && categoryModel != null,
        builder: (context) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CarouselSlider(
                  items: homeModel!.data!.banners
                      .map((e) => Image(
                            image: CachedNetworkImageProvider(e.image!,
                                errorListener: () {}),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayInterval: const Duration(seconds: 5),
                    height: 200,
                    reverse: false,
                    viewportFraction: 1,
                    scrollDirection: Axis.horizontal,
                    initialPage: 0,
                  )),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildCategoryItem(categoryModel!.data!.data[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 20,
                        ),
                        itemCount: categoryModel!.data!.data.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'New Products',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 0.5,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(homeModel!.data!.products.length,
                      (index) => buildProductItem(index, context)),
                ),
              ),
            ],
          ),
        ),
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  //////////////////////////////////////////////Helper Methods
  Widget buildProductItem(int index, context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: CachedNetworkImageProvider(
                      homeModel!.data!.products[index].image!,
                      errorListener: () {}),
                  width: double.infinity,
                  height: 200,
                ),
                if (homeModel!.data!.products[index].discount != 0)
                  Container(
                      padding: const EdgeInsets.all(2),
                      color: Colors.red,
                      child: const Text(
                        'Discount',
                        style: TextStyle(color: Colors.white),
                      )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homeModel!.data!.products[index].name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, height: 1.1),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        '${homeModel!.data!.products[index].price.round()!} LE',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: appColor, fontSize: 12, height: 1.1),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (homeModel!.data!.products[index].discount != 0)
                        Text(
                          '${homeModel!.data!.products[index].oldPrice.round()!}LE',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            height: 1.1,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.getInstance(context).changeFavoriteIcon(
                                homeModel!.data!.products[index]);
                          },
                          icon: Icon(
                            homeModel!.data!.products[index].inFavorites
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCategoryItem(CategoryDetailDataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image:
                CachedNetworkImageProvider(model.image!, errorListener: () {}),
            fit: BoxFit.cover,
            height: 150,
            width: 150,
          ),
          Container(
              width: 150,
              color: Colors.black.withOpacity(0.6),
              child: Text(
                model.name ?? 'Non Category',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
        ],
      );
  void getHomeData() {
    if (homeModel == null) cubit!.getProductData();
    if (categoryModel == null) cubit!.getCategoryData();
  }
  //////////////////////////////////////////////end
}
