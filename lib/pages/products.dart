import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';
import '../widgets/ui_elements/logout_list_tile.dart';
import '../scoped-models/main.dart';


class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {  
  Widget appBarTitle = new Text("EasyList", style: new TextStyle(color: Colors.white),);
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<Products> _list;
  bool _IsSearching;
  String _searchText = "";

//  _ProductsPageState() {
//     _searchQuery.addListener(() {
//       if (_searchQuery.text.isEmpty) {
//         setState(() {
          
//           _IsSearching = false;
//           _searchText = "";
//         });
//       }
//       else {
//         setState(() {
//           _IsSearching = true;
//           _searchText = _searchQuery.text;
//           print(_searchText);
//           return ScopedModelDescendant<MainModel>(
//       builder: (BuildContext context, Widget child, MainModel model) {
//           model.toggleSearchMode(_searchText);
//       });
          
//         });
//       }
//     });
//   }

   @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();

    _searchQuery.addListener(_printLatestValue);
    //print("Second text field: ${_searchQuery.text}");
   
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _searchQuery.removeListener(_printLatestValue);
    _searchQuery.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${_searchQuery.text}");
    
  }

  // @override
  // initState() {
  //   widget.model.fetchProducts();
  //   super.initState();
  //   _IsSearching = false;
  // }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Personel Yönetimi'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin_personel');
            },
          ),
          Divider(),
          LogoutListTile()
        ],
      ),
    );
  }

  Widget _buildProductSearchList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(child: Text('Aranıyor!'));
        if (model.displayedProducts.length> 0 && !model.isLoading) {
          
          content = Products();
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(onRefresh: model.fetchProducts, child: content,) ;
      },
    );
  }

  Widget _buildProductsList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(child: Text('No Products Found!'));
        if (model.displayedProducts.length > 0 && !model.isLoading) {
          content = Products();
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(onRefresh: model.fetchProducts, child: content,) ;
      },
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      new Text("Kolay Liste", style: new TextStyle(color: Colors.white),);
      _IsSearching = false;
      //_searchQuery.clear();
    });
  }

  void _hanleChanged() {
      setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close, color: Colors.white,);
                this.appBarTitle = new TextField(
                  controller: _searchQuery,
                  style: new TextStyle(
                    color: Colors.white,

                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white)
                  ),
                );
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: appBarTitle,
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
              icon: Icon(model.displaySearchsOnly
                    ? Icons.close
                    : Icons.search), 
              onPressed: () {
                _hanleChanged();
                print("dugme basiliyor");
                model.toggleSearchMode(_searchQuery.text);
              },
              );
            },
          ),
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.displayFavoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              );
            },
          )
        ],
      ),
      body:_buildProductsList(),
    );
  }
}
