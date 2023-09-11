import 'package:flutter/material.dart';
import 'package:newsapp/auth_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   String? userRole;
  final _future = Supabase.instance.client
      .from('news')
      .select<List<Map<String, dynamic>>>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentUserRole();
    });
  }

  Future<void> getCurrentUserRole() async {
    // final authSubscription =
    //     Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    //   final AuthChangeEvent event = data.event;
    //   final Session? session = data.session;
    //   final user = session?.user;
    //   if (user != null) {
    //     userRole = user.appMetadata['role'];
    //   }
    // });
    final role = await Supabase.instance.client.rpc(
      'get_my_claim',
      params: {'claim': 'role'},
    );
    setState(() {
      userRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Feed'),
        actions: [
          IconButton(
            onPressed: () {
              Supabase.instance.client.auth.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) {
                  return const AuthScreen();
                },
              ));
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: userRole == null
          ? const Text('user role is null')
          : userRole! == 'admin'
              ? Padding(
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
                )
              : const Center(
                  child: Text(
                    'You are not admin. You are not authorized to view this content',
                    textAlign: TextAlign.center,
                  ),
                ),
    );
  }
}
