import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:solar_system/constants/app_urls.dart';
import 'package:solar_system/pages/detailPage.dart';
import 'package:solar_system/widgets/customDrawer.dart';
import 'package:solar_system/widgets/solarCard.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Map<String, dynamic>> solarItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSolarData();
  }

  Future<void> fetchSolarData() async {
    try {
      final response = await http.get(Uri.parse('${AppURLs.baseApiUrl}solar'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          solarItems = data.map((item) {
            return {
              'id': item['id'],
              'image': item['image'],
              'name': item['name'],
              'description': item['description'],
            };
          }).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load solar data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('النظام الشمسي'),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : solarItems.isEmpty
              ? const Center(child: Text('No solar data available.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: solarItems.length,
                  itemBuilder: (context, index) {
                    final item = solarItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              imagePath: item['image'],
                              title: item['name'],
                              description: item['description'],
                            ),
                          ),
                        );
                      },
                      child: SolarCard(
                        imagePath: item['image'],
                        name: item['name'],
                      ),
                    );
                  },
                ),
    );
  }
}
