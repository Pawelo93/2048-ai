import 'dart:isolate';

class TestIsolates {

  void test() async {
    // setup
    List<int> input = [];
    for(var i = 0; i < 100000000; i++) {
      input.add(i);
    }

    final start = DateTime.now().millisecondsSinceEpoch;

    ReceivePort myReceivePort = ReceivePort();
    Isolate.spawn<IsolateModel>(heavyTask, IsolateModel(355000, 500, myReceivePort.sendPort));

    final int isolateResponse = await myReceivePort.first;
    print("FINAL TOTAL: $isolateResponse");

    final time = DateTime.now().millisecondsSinceEpoch - start;
    print('TIME : $time ms');
  }

  void heavyTask(IsolateModel model) async {
    int total = 0;


    /// Performs an iteration of the specified count
    for (int i = 1; i < model.iteration; i++) {

      /// Multiplies each index by the multiplier and computes the total
      total += (i * model.multiplier);
    }

    model.sendPort.send(total);
  }

}

class IsolateModel {
  IsolateModel(this.iteration, this.multiplier, this.sendPort);

  final int iteration;
  final int multiplier;
  final SendPort sendPort;
}