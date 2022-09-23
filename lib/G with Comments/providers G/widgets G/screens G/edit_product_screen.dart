// import 'package:flutter/material.dart';
// import 'package:flutter_complete_guide/providers/product.dart';
// import 'package:provider/provider.dart';

// import '../providers/products.dart';

// class EditProductsScreen extends StatefulWidget {
//   const EditProductsScreen({Key key}) : super(key: key);

//   static const routeName = '/edit-products';

//   @override
//   State<EditProductsScreen> createState() => _EditProductsScreenState();
// }

// class _EditProductsScreenState extends State<EditProductsScreen> {
// //we want to manage the transition to a the next field by using the next button
// //on the soft keyboard after we have used the FocusNodes we need to dispose them
// //otherwise they will lead to a memory leak
//   final _priceFocsusNode = FocusNode();
//   final _descriptionFocusNode = FocusNode();
//   final _imageUrlController = TextEditingController();
//   final _imageUrlFocusNode = FocusNode();

//   //we are adding a property that we will store our user input, a product
//   var _editedProduct =
//       Product(id: null, title: '', description: '', price: 0, imageUrl: '');

//   var _isInit = true;
//   var _initValues = {
//     'title': '',
//     'description': '',
//     'price': '',
//     'imageUrl': '',
//   };

//   //we need a property to hold our key in order for us to be able to interact
//   //with the Form in our widget
//   final _form = GlobalKey<FormState>();

//   @override
//   void initState() {
//     _imageUrlFocusNode.addListener(_updateImageUrl);
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       final productId = ModalRoute.of(context).settings.arguments as String;
//       //we need to check if we have a product before we continue
//       if (productId != null) {
//         final product =
//             Provider.of<Products>(context, listen: false).findById(productId);
//         _editedProduct = product;
//         _initValues = {
//           'title': _editedProduct.title,
//           'description': _editedProduct.description,
//           'imageUrl': '',
//           //'imageUrl': _editedProduct.imageUrl,
//           'price': _editedProduct.price.toString(),
//         };
//         _imageUrlController.text = _editedProduct.imageUrl;
//       }
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }

// //after we have used the FocusNodes we need to dispose them
// //otherwise they will lead to a memory leak
//   @override
//   void dispose() {
//     _imageUrlFocusNode.removeListener(_updateImageUrl);
//     _priceFocsusNode.dispose();
//     _descriptionFocusNode.dispose();
//     _imageUrlController.dispose();
//     _imageUrlFocusNode.dispose();

//     super.dispose();
//   }

//   void _updateImageUrl() {
//     if (!_imageUrlFocusNode.hasFocus) {
//       if ((!_imageUrlController.text.startsWith('http') &&
//               !_imageUrlController.text.startsWith('https')) ||
//           (!_imageUrlController.text.endsWith('.png') &&
//               !_imageUrlController.text.endsWith('.jpg') &&
//               !_imageUrlController.text.endsWith('.jpeg'))) {
//         return;
//       }
//       setState(() {});
//     }
//   }

//   void _saveForm() {
//     final _isValid = _form.currentState.validate();
//     if (!_isValid) {
//       return;
//     }
//     _form.currentState.save();
//     if (_editedProduct.id != null) {
//       Provider.of<Products>(context, listen: false)
//           .updateProduct(_editedProduct.id, _editedProduct);
//     } else {
//       Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
//     }

//     Navigator.of(context).pop();

//     // print(_editedProduct.title);
//     // print(_editedProduct.description);
//     // print(_editedProduct..price);
//     // print(_editedProduct.imageUrl);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Edit Product',
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: () {
//               _saveForm;
//             },
//           )
//         ],
//       ),
//       //or we can use a ListView but we encounter the danger that when a widget moves out of screen
//       //the data might get lost, this is for long lists
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _form,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 TextFormField(
//                   initialValue: _initValues['title'],
//                   decoration: InputDecoration(
//                     labelText: 'Title',
//                   ),
//                   textInputAction: TextInputAction.next,
//                   //we are listening for the next press where we submit a form
//                   onFieldSubmitted: (_) {
//                     FocusScope.of(context).requestFocus(_priceFocsusNode);
//                   },
//                   //we need to validate the data in the form
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please provide a value';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _editedProduct = Product(
//                         id: _editedProduct.id,
//                         isFavorite: _editedProduct.isFavorite,
//                         title: value,
//                         description: _editedProduct.description,
//                         price: _editedProduct.price,
//                         imageUrl: _editedProduct.imageUrl);
//                   },
//                 ),
//                 TextFormField(
//                   initialValue: _initValues['price'],
//                   decoration: InputDecoration(
//                     labelText: 'Price',
//                   ),
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.number,
//                   //we assign the _priceFocusNode to the second field
//                   focusNode: _priceFocsusNode,
//                   onFieldSubmitted: (_) {
//                     FocusScope.of(context).requestFocus(_descriptionFocusNode);
//                   },
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'please provide a price';
//                     }
//                     if (double.tryParse(value) == null) {
//                       return "please enter a valid number";
//                     }
//                     if (double.parse(value) <= 0) {
//                       return "please enter a number grater than 0";
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _editedProduct = Product(
//                         id: _editedProduct.id,
//                         isFavorite: _editedProduct.isFavorite,
//                         title: _editedProduct.title,
//                         description: _editedProduct.description,
//                         price: double.parse(value),
//                         imageUrl: _editedProduct.imageUrl);
//                   },
//                 ),
//                 TextFormField(
//                   initialValue: _initValues['description'],
//                   decoration: InputDecoration(
//                     labelText: 'Description',
//                   ),
//                   maxLines: 3,
//                   keyboardType: TextInputType.multiline,
//                   //we are listening for the next press where we submit a form
//                   focusNode: _descriptionFocusNode,
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter a description';
//                     }
//                     if (value.length < 10) {
//                       return 'A description should be at least ten charachters';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _editedProduct = Product(
//                         id: _editedProduct.id,
//                         isFavorite: _editedProduct.isFavorite,
//                         title: _editedProduct.title,
//                         description: value,
//                         price: _editedProduct.price,
//                         imageUrl: _editedProduct.imageUrl);
//                   },
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: <Widget>[
//                     Container(
//                       width: 100,
//                       height: 100,
//                       margin: EdgeInsets.only(
//                         top: 8,
//                         right: 10,
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           width: 1,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       child: _imageUrlController.text.isEmpty
//                           ? Text('Enter a URL')
//                           : FittedBox(
//                               child: Image.network(_imageUrlController.text),
//                               fit: BoxFit.cover,
//                             ),
//                     ),
//                     Expanded(
//                       child: TextFormField(
//                         //initialValue: _initValues['imageUrl'],
//                         decoration: InputDecoration(labelText: 'Image Url'),
//                         keyboardType: TextInputType.url,
//                         textInputAction: TextInputAction.done,
//                         controller: _imageUrlController,
//                         //when we select another field we update the UI
//                         focusNode: _imageUrlFocusNode,
//                         validator: (value) {
//                           if (value.isEmpty) {
//                             return 'Please add an Image Url';
//                           }
//                           if (!value.startsWith('http') &&
//                               !value.startsWith('https')) {
//                             return 'Please enter a valid URL';
//                           }
//                           if (!value.endsWith('.jpg') &&
//                               !value.endsWith('.png') &&
//                               value.endsWith('.jpeg')) {
//                             return 'Please enter a valid image URL';
//                           }
//                           return null;
//                         },
//                         onFieldSubmitted: (_) {
//                           _saveForm();
//                         },
//                         onEditingComplete: () {
//                           setState(() {});
//                         },
//                         onSaved: (value) {
//                           _editedProduct = Product(
//                               id: _editedProduct.id,
//                               isFavorite: _editedProduct.isFavorite,
//                               title: _editedProduct.title,
//                               description: _editedProduct.description,
//                               price: _editedProduct.price,
//                               imageUrl: value);
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
