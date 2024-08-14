import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';

class FirestoreService {
  CollectionReference events = FirebaseFirestore.instance.collection('events');
  CollectionReference initialEvent =
      FirebaseFirestore.instance.collection('initialEvent');
  CollectionReference visits = FirebaseFirestore.instance.collection('visits');

  Future<void> addEvent(League event) async {
    await events.doc(event.id).set(event.toJson());
  }

  Future<List<League>> getEvents() async {
    List<League> eventsList = [];
    await events.orderBy('date', descending: true).get().then((event) {
      for (var doc in event.docs) {
        eventsList.add(League.fromJson(doc));
      }
    });
    return eventsList;
  }

  Future<void> updateEvent(League event) async {
    await events.doc(event.id).update(event.toJson());
  }

  Future<void> deleteEvent(String id) async {
    await events.doc(id).delete();
  }

  Future<void> setInitialEvent(League event) async {
    await initialEvent.doc('Initial_event').set(event.toJson());
  }

  Future<League> getInitialEvent() async {
    dynamic data;
    League event;
    await initialEvent
        .doc('Initial_event')
        .get()
        .then<dynamic>((DocumentSnapshot snapshot) async {
      data = snapshot.data();
    });
    event = League.fromJson(data);
    return event;
  }

  Future<List> getVisitsList(int month, int year) async {
    String id = '$month-$year';
    List v = [];
    var doc = await visits.doc(id).get();
    if (doc.exists) {
      await visits.doc(id).get().then((value) async {
        final docs = value.data()!;
        final data = docs as Map<String, dynamic>;
        v = data['visits'] as List;
      });
      return v;
    }
    return [];
  }

  Future<int> getMonthVisits() async {
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    String id = '$month-$year';
    List v = [];
    num x = 0;
    var doc = await visits.doc(id).get();
    if (doc.exists) {
      await visits.doc(id).get().then((value) async {
        final docs = value.data()!;
        final data = docs as Map<String, dynamic>;
        v = data['visits'] as List;
      });
      for (var i = 0; i < v.length; i++) {
        x += v[i];
      }
      return x.toInt();
    }
    return 0;
  }

  Future<int> countEvents() async {
    AggregateQuerySnapshot query = await events.count().get();
    int i;
    if (query.count != null) {
      i = query.count!;
      return i;
    }
    return 0;
  }
}
