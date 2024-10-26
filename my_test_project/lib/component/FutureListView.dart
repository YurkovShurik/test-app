import 'package:flutter/material.dart';
import 'package:my_test_project/snapshot/ReloadableAsyncSnapshot.dart';

class FutureListView<T> extends StatelessWidget {

  final ReloadableAsyncSnapshot<List<T>> snapshot;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  const FutureListView({
    super.key,
    required this.snapshot,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (snapshot.isWaiting) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.indigoAccent),
            SizedBox(height: 10),
            Text("Loading"),
          ],
        ),
      );
    }
    if (snapshot.hasError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text("ERROR", style: TextStyle(color: Colors.red.shade300, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                constraints: const BoxConstraints(maxHeight: 300),
                child: SingleChildScrollView(
                  child: Text(snapshot.error.toString(), style: const TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: snapshot.fetch,
            icon: const Icon(Icons.refresh_rounded, size: 40, color: Colors.indigoAccent),
          ),
        ],
      );
    }
    if (!snapshot.hasData) {
      return const SizedBox.shrink();
    }
    return ListView.separated(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) => itemBuilder(context, snapshot.data![index], index),
      separatorBuilder: (context, index) => const SizedBox(height: 0),
    );
  }
}
