// import 'package:flutter/material.dart';
// import 'package:flutter_complete_guide/providers/product.dart';
// import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
// import 'package:provider/provider.dart';

// import '../providers/products.dart';

// class UserProductItem extends StatelessWidget {
//   final String id;
//   final String title;
//   final String imageUrl;

//   UserProductItem({
//     @required this.id,
//     @required this.title,
//     @required this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(title),
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(imageUrl),
//       ),
//       trailing: Container(
//         width: 100,
//         child: Row(
//           children: <Widget>[
//             IconButton(
//               onPressed: () {
//                 Navigator.of(context)
//                     .pushNamed(EditProductsScreen.routeName, arguments: id);
//               },
//               icon: Icon(Icons.edit),
//               color: Theme.of(context).primaryColor,
//             ),
//             IconButton(
//               onPressed: () {
//                 Provider.of<Products>(context, listen: false).deleteProduct(id);
//               },
//               icon: Icon(Icons.delete),
//               color: Theme.of(context).errorColor,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
