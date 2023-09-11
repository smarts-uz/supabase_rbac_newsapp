import 'package:flutter/material.dart';
import 'package:newsapp/auth_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _future = Supabase.instance.client
      .from('news')
      .select<List<Map<String, dynamic>>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Feed'),
        actions: [
          IconButton(onPressed: (){
            Supabase.instance.client.auth.signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) {
                return const AuthScreen();
              },)
            );
          }, icon: const Icon(Icons.logout_rounded),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final news = snapshot.data!;
            return ListView.builder(
              itemCount: news.length,
              itemBuilder: ((context, index) {
                final newsItem = news[index];
                return ListTile(
                  title: Text(newsItem['title']),
                  subtitle: Text(newsItem['description']),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
