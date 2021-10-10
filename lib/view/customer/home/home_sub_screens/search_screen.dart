import 'package:admin_grad_pro/lviewmodels/search_view_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchViewModel>(
      init: SearchViewModel(),
      builder: (searchController) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Flexible(
                      flex: 7,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade200,
                        ),
                        child: TextField(
                          controller: searchController.searchTextController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefix: SizedBox(width: 20),
                            // prefixIcon: Icon(
                            //   Icons.search,
                            //   color: Colors.black,
                            //   size: 28,
                            // ),
                            hintText: 'search for desire product',
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: IconButton(
                        onPressed: () {
                          if (searchController.searchTextController.text !=
                              null) {
                            searchController.queryData();
                            FocusScope.of(context).unfocus();
                          }
                        },
                        icon: Icon(
                          Icons.search,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: searchController.productModels.length == 0
                    ? Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/gradpro-cf1aa.appspot.com/o/images%2Fcategories%2FIcon_Gaming.png?alt=media&token=cda2503e-1759-4e71-90d3-ee66b75ab866',
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CustomGridView(
                          productsList: searchController.productModels,
                        ),
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(
            Icons.clear,
          ),
          onPressed: () {
            searchController.clearing();
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }
}
