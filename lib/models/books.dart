import 'package:books_finder/books_finder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FirebaseBooks {
  late int availability;
  late String title = '';
  late List<String> authors;
  late String publisher;
  late String publishedDate;
  late String description;
  late int pageCount;
  late List<String> categories;
  late double averageRating;
  late List<String> industryIdentifier = [];
  late List<String> imageLinks;
  late String language;

  FirebaseBooks();

  static FirebaseBooks getFirebaseFromBook(Book book) {
    FirebaseBooks firebaseBooks = FirebaseBooks();
    firebaseBooks.title = book.info.title;
    firebaseBooks.authors = book.info.authors;
    firebaseBooks.publisher = book.info.publisher;
    firebaseBooks.publishedDate = book.info.publishedDate.toString();
    firebaseBooks.description = book.info.description;
    firebaseBooks.pageCount = book.info.pageCount;
    firebaseBooks.categories = book.info.categories;
    firebaseBooks.averageRating = book.info.averageRating;
    for (var isbn in book.info.industryIdentifier) {
      firebaseBooks.industryIdentifier.add(isbn.toString());
    }
    firebaseBooks.imageLinks = [];
    for (var uri in book.info.imageLinks.values) {
      firebaseBooks.imageLinks.add(uri.toString());
    }
    firebaseBooks.language = book.info.language;
    return firebaseBooks;
  }

  static FirebaseBooks getBookFromFirebase(QueryDocumentSnapshot bookSnapshot) {
    FirebaseBooks firebaseBooks = FirebaseBooks();
    final Map<String, dynamic> data = bookSnapshot.data();
    firebaseBooks.availability = data['availability'];
    firebaseBooks.title = data['title'];
    firebaseBooks.authors = List<String>.from(data['authors']);
    firebaseBooks.publisher = data['publisher'];
    firebaseBooks.publishedDate = data['publishedDate'];
    firebaseBooks.description = data['description'];
    firebaseBooks.pageCount = data['pageCount'];
    firebaseBooks.categories = List<String>.from(data['categories']);
    firebaseBooks.averageRating = data['averageRating'];
    firebaseBooks.industryIdentifier =
        List<String>.from(data['industryIdentifier']);
    // print('here');
    // try {
    //   print(firebaseBooks.industryIdentifier);
    // } catch (e) {
    //   print('err');
    // }
    firebaseBooks.imageLinks = List<String>.from(data['imageLinks']);
    firebaseBooks.language = data['language'];
    return firebaseBooks;
  }
}

// class AllFirebaseBooks extends ChangeNotifier {
//   List<FirebaseBooks> firebaseBooksList = [];

//   Future<void> fetchAllFirebaseBooks() async {
//     await for (var snapshot
//         in FirebaseFirestore.instance.collection("books").snapshots()) {
//       for (var doc in snapshot.docs) {
//         firebaseBooksList.add(FirebaseBooks.getBookFromFirebase(doc));
//       }
//     }
//     notifyListeners();
//   }
// }
