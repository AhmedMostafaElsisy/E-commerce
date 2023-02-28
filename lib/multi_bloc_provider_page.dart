import 'package:captien_omda_customer/features/Categories_feature/presentation/logic/category_cubit.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/logic/home_product_cubit/home_product_cubit.dart';
import 'package:captien_omda_customer/features/cart_feature/presenation/logic/cart_cubit.dart';
import 'package:captien_omda_customer/features/general_prodcut_feature/presentation/logic/Filter_cubit/filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/Connectivity_Cubit/connectivity_cubit.dart';
import 'core/Language_Cubit/language_cubit.dart';
import 'core/form_builder_feature/presentation/logic/form_builder_cubit.dart';
import 'core/location_feature/presentation/logic/pick_location_cubit.dart';
import 'core/presentation/search_filter_cubit/search_filet_cubit.dart';
import 'core/setting_feature/Logic/setting_cubit.dart';
import 'core/tags_feature/presentation/logic/tags_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Login_Cubit/login_cubit.dart';
import 'features/Auth_feature/Presentation/logic/OTP_Cubit/otp_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Password_Cubit/password_cubit.dart';
import 'features/Auth_feature/Presentation/logic/Sign_Up_Cubit/sign_up_cubit.dart';
import 'features/Home_feature/presentation/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import 'features/Home_feature/presentation/logic/home_cubit/home_cubit.dart';
import 'features/Profile_feature/presentation/logic/Profile_Cubit/profile_cubit.dart';
import 'features/edit_product_feature/presentation/logic/edit_product/edit_product_cubit.dart';
import 'features/favorite_feature/presentation/logic/favorite_cubit.dart';
import 'features/general_prodcut_feature/presentation/logic/product_details_cubit/product_details_cubit.dart';
import 'features/general_prodcut_feature/presentation/logic/product_list_cubit/product_list_cubit.dart';
import 'features/notification_feature/data/reposiroty/notification_repository.dart';
import 'features/notification_feature/presentation/logic/notification_cubit.dart';
import 'features/order_feature/presentation/logic/order_cubit.dart';
import 'features/plans_feature/presentation/logic/plans_cubit.dart';
import 'features/rating_feature/presentation/logic/rating_cubit.dart';
import 'features/store_feature/presentation/logic/edit_my_store/edit_my_store_cubit.dart';
import 'features/store_feature/presentation/logic/general_stores_cubit/general_stores_cubit.dart';
import 'features/store_feature/presentation/logic/my_stores_cubit/store_cubit.dart';
import 'features/store_feature/presentation/logic/single_store_cubit/my_store_cubit.dart';
import 'features/store_product/presentation/logic/product_cubit.dart';
import 'injection_container.dart' as di;

class MultiBlocProvidersPage extends StatefulWidget {
  final Widget body;

  const MultiBlocProvidersPage({Key? key, required this.body})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiBlocProvidersPageState();
}

class _MultiBlocProvidersPageState extends State<MultiBlocProvidersPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LangCubit>(
            lazy: false, create: (_) => LangCubit()..getLang()),
        BlocProvider<ConnectivityCubit>(
            lazy: false, create: (_) => ConnectivityCubit()..initConnection()),
        BlocProvider<LoginCubit>(
            lazy: false, create: (_) => di.sl<LoginCubit>()),
        BlocProvider<SignUpCubit>(create: (_) => di.sl<SignUpCubit>()),
        BlocProvider<OtpCubit>(create: (_) => di.sl<OtpCubit>()),
        BlocProvider<PasswordCubit>(create: (_) => di.sl<PasswordCubit>()),
        BlocProvider<ProfileCubit>(create: (_) => di.sl<ProfileCubit>()),
        BlocProvider<NotificationCubit>(
            create: (_) => NotificationCubit(NotificationListRepository())),
        BlocProvider<BottomNavCubit>(create: (_) => BottomNavCubit()),
        BlocProvider<BannersCubit>(create: (_) => di.sl<BannersCubit>()),
        BlocProvider<CategoriesCubit>(create: (_) => di.sl<CategoriesCubit>()),
        BlocProvider<SettingCubit>(create: (_) => di.sl<SettingCubit>()),
        BlocProvider<RatingCubit>(create: (_) => di.sl<RatingCubit>()),
        BlocProvider<FavoriteCubit>(create: (_) => di.sl<FavoriteCubit>()),
        BlocProvider<StoreCubit>(create: (_) => di.sl<StoreCubit>()),
        BlocProvider<MyStoreCubit>(create: (_) => di.sl<MyStoreCubit>()),
        BlocProvider<ProductCubit>(create: (_) => di.sl<ProductCubit>()),
        BlocProvider<PickLocationCubit>(
            create: (_) => di.sl<PickLocationCubit>()),
        BlocProvider<GeneralStoresCubit>(
            create: (_) => di.sl<GeneralStoresCubit>()),
        BlocProvider<PickLocationCubit>(
            create: (_) => di.sl<PickLocationCubit>()),
        BlocProvider<TagsCubit>(create: (_) => di.sl<TagsCubit>()),
        BlocProvider<AllFilterCubit>(create: (_) => di.sl<AllFilterCubit>()),
        BlocProvider<EditStoreCubit>(create: (_) => di.sl<EditStoreCubit>()),
        BlocProvider<PlansCubit>(create: (_) => di.sl<PlansCubit>()),
        BlocProvider<EditProductCubit>(
            create: (_) => di.sl<EditProductCubit>()),
        BlocProvider<HomeProductCubit>(
            create: (_) => di.sl<HomeProductCubit>()),
        BlocProvider<ProductListCubitWithFilter>(
            create: (_) => di.sl<ProductListCubitWithFilter>()),
        BlocProvider<ProductDetailsCubit>(
            create: (_) => di.sl<ProductDetailsCubit>()),
        BlocProvider<FilterCubit>(create: (_) => di.sl<FilterCubit>()),
        BlocProvider<FormBuilderCubit>(
            create: (_) => di.sl<FormBuilderCubit>()),
        BlocProvider<CartCubit>(create: (_) => di.sl<CartCubit>()),
        BlocProvider<OrderCubit>(create: (_) => di.sl<OrderCubit>()),
      ],
      child: widget.body,
    );
  }
}
