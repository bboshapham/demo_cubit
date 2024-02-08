import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Sự kiện để tăng/giảm giá trị
enum CounterEvent { increment, decrement }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo BLOC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) =>
            CounterCubit(), // Tạo một instance mới của CounterCubit
        child: const MyHomePage(), // truyền widget cho Cubit
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Center(child: 
              Text('DEMO BLOC', 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
              )),
              backgroundColor: Colors.blueAccent,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             const Expanded(child: SizedBox(height: 10)),
             Expanded(child: BlocBuilder<CounterCubit, int>(
                builder: (BuildContext context, int state) {
                  return Text(
                    '$state',
                    style: const TextStyle(
                        fontSize: 100, 
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                        ),
                  );
                },
              )
              ),
              const SizedBox(height: 150),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                ElevatedButton.icon(
                    onPressed: () {
                      context.read<CounterCubit>().onEvent(CounterEvent.increment);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Increment')),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                    onPressed: () {
                      context.read<CounterCubit>().onEvent(CounterEvent.decrement);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Decrement'))
              ]),
              const SizedBox(height: 10),
            ])
            )
            );
  }
}

// Cubit để quản lý trạng thái của biến đếm
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  // Phương thức để xử lý các sự kiện và cập nhật trạng thái tương ứng
  void onEvent(CounterEvent event) {
    switch (event) {
      case CounterEvent.increment:
        emit(state + 1);
        break;
      case CounterEvent.decrement:
        emit(state - 1);
        break;
    }
  }
}
