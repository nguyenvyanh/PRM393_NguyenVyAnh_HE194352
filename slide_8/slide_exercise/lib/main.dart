import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Demo81App());
}

class Demo81App extends StatelessWidget {
  const Demo81App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo 8.1 - Simple GET Request',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const SimpleGetScreen(),
    );
  }
}

class SimpleGetScreen extends StatefulWidget {
  const SimpleGetScreen({super.key});

  @override
  State<SimpleGetScreen> createState() => _SimpleGetScreenState();
}

class _SimpleGetScreenState extends State<SimpleGetScreen> {
  String title = '';
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchFirstPost() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      title = '';
    });

    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        setState(() {
          title = data[0]['title'];
        });
      } else {
        setState(() {
          errorMessage = 'Request failed: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Lỗi: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFirstPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo 8.1 - GET Request'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : errorMessage != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: fetchFirstPost,
                          child: const Text('Retry'),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Title của post đầu tiên:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: fetchFirstPost,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reload'),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}