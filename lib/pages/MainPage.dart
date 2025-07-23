import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kitaphana/pages/AdminPage.dart';
import 'package:url_launcher/url_launcher.dart';

// --- MODEL SINIFLARI ---

class Writer {
  final int id;
  final String username;
  final String image;

  Writer({required this.id, required this.username, required this.image});

  factory Writer.fromJson(Map<String, dynamic> json) {
    return Writer(
      id: json['id'],
      username: json['username_tm'],
      image: json['image'],
    );
  }
}

class Book {
  final int id;
  final String title;
  final String image;
  final String file;
  final int writerId;

  Book({
    required this.id,
    required this.title,
    required this.image,
    required this.file,
    required this.writerId,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title_tm'],
      image: json['image'],
      file: json['file'],
      writerId: json['writer'],
    );
  }
}

// --- SERVİSLER ---

class WriterService {
  static Future<List<Writer>> fetchWriters() async {
    final url = Uri.parse('https://kitaplar-backend.onrender.com/api/writers/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonList = json.decode(response.body);
      return jsonList.map((e) => Writer.fromJson(e)).toList();
    } else {
      throw Exception('Yazarlar yüklenemedi');
    }
  }
}

class BookService {
  static Future<List<Book>> fetchAllBooks() async {
    final url = Uri.parse('https://kitaplar-backend.onrender.com/api/books/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonList = json.decode(response.body);
      return jsonList.map((e) => Book.fromJson(e)).toList();
    } else {
      throw Exception('Kitaplar yüklenemedi');
    }
  }

  static Future<List<Book>> fetchBooksByWriter(int writerId) async {
    List<Book> allBooks = await fetchAllBooks();
    return allBooks.where((book) => book.writerId == writerId).toList();
  }
}

// --- ANA SAYFA ---

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> with TickerProviderStateMixin {
  late Future<List<Writer>> writersFuture;
  
  @override
  void initState() {
    super.initState();
    writersFuture = WriterService.fetchWriters();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Writer>>(
      future: writersFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final writers = snapshot.data!;
        final tabController = TabController(length: writers.length, vsync: this);

        return Scaffold(
          appBar: AppBar(
            actions: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Adminpage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.person, color: Colors.black,),
                ),
              )
            ],
            title: const Text('Yazarlar'),
            backgroundColor: Colors.white,
            elevation: 1,
            shadowColor: Colors.black,
            bottom: TabBar(
              controller: tabController,
              isScrollable: true,
              tabs: writers.map((writer) => Tab(text: writer.username)).toList(),
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: writers.map((writer) {
              return WriterBooksTab(writerId: writer.id);
            }).toList(),
          ),
        );
      },
    );
  }
}

// --- YAZAR KİTAPLARI TAB'I ---

class WriterBooksTab extends StatelessWidget {
  final int writerId;

  const WriterBooksTab({required this.writerId, super.key});

  void openPdf(BuildContext context, String url) async {
  final Uri uri = Uri.parse(url);

  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF açılamadı. Lütfen daha sonra tekrar deneyin.')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Hata: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: BookService.fetchBooksByWriter(writerId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${snapshot.error}'));
        }

        final books = snapshot.data!;
        if (books.isEmpty) {
          return const Center(child: Text('Bu yazara ait kitap yok.'));
        }

        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Image.network(book.image, width: 50, height: 50, fit: BoxFit.cover),
                title: Text(book.title),
                trailing: Icon(Icons.picture_as_pdf),
                onTap: () {
                  openPdf(context, book.file);
                },
              ),
            );
          },
        );
      },
    );
  }
}
