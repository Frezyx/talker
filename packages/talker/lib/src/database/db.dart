import 'package:talker/objectbox.g.dart';
import 'package:talker/talker.dart';

class TalkerDataStore {
  late final Store store;
  late final Box<TalkerData> _talkerBox;
  late final Stream<List<TalkerData>> talkerDataStream;

  static final TalkerDataStore _instance = TalkerDataStore._internal();

  TalkerDataStore._internal() {
    create(); // Ensure this method can handle singleton logic
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<TalkerDataStore> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return TalkerDataStore._create(store);
  }

  factory TalkerDataStore() {
    return _instance;
  }

  TalkerDataStore._create(this.store) {
    _talkerBox = store.box<TalkerData>();
    // Create a query for all items, ordered by time descending
    final query = _talkerBox.query()
      ..order(TalkerData_.time, flags: Order.descending);

    // Create a stream from the query
    talkerDataStream =
        query.watch(triggerImmediately: true).map((query) => query.find());
  }

  // Store a single TalkerData
  void storeTalkerData(TalkerData data) {
    _talkerBox.put(data);
  }

  // Delete all TalkerData
  void deleteTalkerData() {
    _talkerBox.removeAll();
  }

  // Example usage when getting data from ObjectBox
  List<TalkerData> getTalkerDataWithReconstructedFields() {
    final results = _talkerBox.getAll();

    // Reconstruct transient fields for each result
    for (var talkerData in results) {
      talkerData.reconstructTransientFields();
    }

    return results;
  }

  // Clean up resources
  void dispose() {
    store.close();
  }
}
