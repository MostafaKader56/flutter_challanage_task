import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import '../../../../../core/error_handle/app_exception.dart';
import '../../../../../core/error_handle/error_type.dart';
import '../../model/product_model.dart';
import 'product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  @override
  Future<Either<AppException, ProductModel>> createProduct(
    ProductModel product,
  ) async {
    try {
      String? uploadedImageUrl;

      // Upload image to Firebase Storage if imagePath is not empty
      if (product.imagePath.isNotEmpty) {
        final File imageFile = File(product.imagePath);

        // Check if file exists
        if (!await imageFile.exists()) {
          return Left(
            AppException({'imageNotFound': ErrorType.unexpectedError}),
          );
        }

        // Create a unique filename using timestamp
        final String fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${path.basename(product.imagePath)}';

        // Reference to Firebase Storage
        final Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('product_images')
            .child(fileName);

        // Upload the file
        final UploadTask uploadTask = storageRef.putFile(imageFile);

        // Wait for upload to complete
        final TaskSnapshot snapshot = await uploadTask;

        // Get download URL
        uploadedImageUrl = await snapshot.ref.getDownloadURL();
      }

      // Create updated product model with the Firebase Storage URL
      final ProductModel updatedProduct = ProductModel(
        name: product.name,
        description: product.description,
        price: product.price,
        quantity: product.quantity,
        creator: product.creator,
        imagePath: uploadedImageUrl ?? product.imagePath,
        id: product.id,
      );

      // Save to Firestore
      await FirebaseFirestore.instance
          .collection('New Challange Product')
          .doc(updatedProduct.id)
          .set(updatedProduct.toJson());

      // Return success with the updated product
      return Right(updatedProduct);
    } on FirebaseException catch (e) {
      // Handle Firebase specific errors
      return Left(
        AppException({
          'firebaseError': ErrorType.unexpectedError,
        }, originalError: e),
      );
    } on SocketException catch (e) {
      // Handle network errors
      return Left(
        AppException({
          'networkError': ErrorType.unexpectedError,
        }, originalError: e),
      );
    } on FileSystemException catch (e) {
      // Handle local file system errors
      return Left(
        AppException({
          'fileSystemError': ErrorType.unexpectedError,
        }, originalError: e),
      );
    } catch (e) {
      // Catch any other errors
      return Left(
        AppException({
          'unknownError': ErrorType.unexpectedError,
        }, originalError: e),
      );
    }
  }

  @override
  Future<Either<AppException, List<ProductModel>>> getProducts() async {
    try {
      // Get all documents from the collection
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('New Challange Product')
          .get();

      // Convert documents to ProductModel list
      final List<ProductModel> products = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ProductModel.fromJson(data);
      }).toList();

      return Right(products);
    } on FirebaseException catch (e) {
      return Left(
        AppException({
          'firebaseError': ErrorType.unexpectedError,
        }, originalError: e),
      );
    } catch (e) {
      return Left(
        AppException({
          'firebaseError': ErrorType.unexpectedError,
        }, originalError: e),
      );
    }
  }

  @override
  Future<Either<AppException, void>> deleteProduct(ProductModel product) async {
    try {
      // 1️⃣ Delete image from Firebase Storage if it exists
      if (product.imagePath.isNotEmpty &&
          product.imagePath.startsWith("https")) {
        try {
          final Reference photoRef = FirebaseStorage.instance.refFromURL(
            product.imagePath,
          );
          await photoRef.delete();
        } catch (e) {
          // Image deletion error is not critical → still continue deleting product
        }
      }

      // 2️⃣ Delete product document from Firestore
      await FirebaseFirestore.instance
          .collection('New Challange Product')
          .doc(product.id)
          .delete();

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(
        AppException({
          'firebaseError': ErrorType.unexpectedError,
        }, originalError: e),
      );
    } on SocketException catch (e) {
      return Left(
        AppException({
          'networkError': ErrorType.unexpectedError,
        }, originalError: e),
      );
    } catch (e) {
      return Left(
        AppException({
          'unknownError': ErrorType.unexpectedError,
        }, originalError: e),
      );
    }
  }

  @override
  Future<Either<AppException, void>> updateProduct(ProductModel product) async {
    try {
      String updatedImageUrl = product.imagePath;

      // 1️⃣ If the imagePath is local → upload new image
      if (!product.imagePath.startsWith("https")) {
        final File imageFile = File(product.imagePath);

        if (await imageFile.exists()) {
          final String fileName =
              '${DateTime.now().millisecondsSinceEpoch}_${path.basename(product.imagePath)}';

          final Reference storageRef = FirebaseStorage.instance
              .ref()
              .child('product_images')
              .child(fileName);

          final UploadTask uploadTask = storageRef.putFile(imageFile);
          final TaskSnapshot snapshot = await uploadTask;

          updatedImageUrl = await snapshot.ref.getDownloadURL();
        } else {
          return Left(
            AppException({'imageNotFound': ErrorType.unexpectedError}),
          );
        }
      }

      // 2️⃣ Create updated model
      final ProductModel updatedModel = ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        quantity: product.quantity,
        creator: product.creator,
        imagePath: updatedImageUrl,
      );

      // 3️⃣ Update Firestore document
      await FirebaseFirestore.instance
          .collection("New Challange Product")
          .doc(product.id)
          .update(updatedModel.toJson());

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(
        AppException({
          'firebaseError': ErrorType.unexpectedError,
        }, originalError: e),
      );
    } on SocketException catch (e) {
      return Left(
        AppException({
          'networkError': ErrorType.unexpectedError,
        }, originalError: e),
      );
    } catch (e) {
      return Left(
        AppException({
          'unknownError': ErrorType.unexpectedError,
        }, originalError: e),
      );
    }
  }
}
