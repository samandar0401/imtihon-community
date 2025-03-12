import 'package:categorylogin/core/utils.dart';
import 'package:categorylogin/recipe_app/categories/data/state/categories_cubit.dart';
import 'package:categorylogin/recipe_app/categories/data/state/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/presentation/widgets/recipe_app_bar.dart';
import '../../../common/presentation/widgets/recipe_bottom_navigation_bar.dart';
import '../../../common/presentation/widgets/recipe_icon_button_container.dart';
import '../widget/category_item.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key
  });


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) => RefreshIndicator(
        onRefresh:() async => context.read<CategoriesBloc>().add(CategoriesLoading()),
        child: Scaffold(
          backgroundColor: AppColors.bacround,
          extendBody: true,
          appBar: RecipeAppBar(
            title: "Categories",
            actions: [
              RecipeIconButtonContainer(
                image: "assets/icons/notification.svg",
                iconWidth: 14,
                iconHeight: 19,
                callback: () {},
              ),
              SizedBox(width: 5),
              RecipeIconButtonContainer(
                image: "assets/icons/search.svg",
                iconWidth: 12,
                iconHeight: 18,
                callback: () {},
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              if (state.mainCategory != null)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  sliver: SliverToBoxAdapter(
                    child: CategoryItem(category: state.mainCategory!),
                  ),
                ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 36, right: 36, top: 16, bottom: 90),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.categories.length,
                        (context, index) => CategoryItem(category: state.categories[index]),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 172,
                    mainAxisSpacing: 8,
                    childAspectRatio: 172 / 160,
                    crossAxisSpacing: 39,
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: RecipeBottomNavigationBar(),
        ),
      ),
    );
  }
}
