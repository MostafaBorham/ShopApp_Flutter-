import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/ShopCubit.dart';
import '../../Bloc/ShopStates.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  ShopCubit? cubit;
  @override
  Widget build(BuildContext context) {
    cubit = ShopCubit.getInstance(context);
    cubit!.getFavouriteData();

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: favoriteModel != null,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildFavoriteItem(index),
              separatorBuilder: (context, index) => buildListSeparator(),
              itemCount: favoriteModel!.data!.data.length,
            ),
          );
        },
        fallback: (context) {
          return (state is ShopEmptyFavoriteModelState ||
                  state is ShopFailGetFavouritesDataState)
              ? const Center(
                  child: Text(
                    'No Favorites Added',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  /////////////////////////////////////////////////////////////HelperMethods
  Widget buildFavoriteItem(index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: CachedNetworkImageProvider(
                      favoriteModel!.data!.data[index].product!.image!,
                      errorListener: () {}),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                if (favoriteModel!.data!.data[index].product!.discount != 0)
                  Container(
                      padding: const EdgeInsets.all(2),
                      color: Colors.red,
                      child: const Text(
                        'Discount',
                        style: TextStyle(color: Colors.white),
                      )),
              ],
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
                      favoriteModel!.data!.data[index].product!.name!,
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
                          '${favoriteModel!.data!.data[index].product!.price.round()!} LE',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: appColor, fontSize: 12, height: 1.1),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (favoriteModel!
                                .data!.data[index].product!.discount !=
                            0)
                          Text(
                            '${favoriteModel!.data!.data[index].product!.old_price.round()!}LE',
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
                              ShopCubit.getInstance(context).removeFavoriteItem(
                                  favoriteModel!.data!.data[index]);
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )),
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
