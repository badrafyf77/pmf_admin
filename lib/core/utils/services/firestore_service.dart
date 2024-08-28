import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmf_admin/core/utils/models/player_model.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/users/data/models/users_model.dart';

class FirestoreService {
  CollectionReference leagues =
      FirebaseFirestore.instance.collection('leagues');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference visits = FirebaseFirestore.instance.collection('visits');

  Future<List<UserInformation>> getUsers() async {
    List<UserInformation> usersList = [];
    await users.orderBy('joinedDate', descending: true).get().then((user) {
      for (var doc in user.docs) {
        usersList.add(UserInformation.fromJson(doc));
      }
    });
    return usersList;
  }

  Future<void> addLeague(League league, List<UserInformation> usersList) async {
    await leagues.doc(league.id).set(league.toJson());
    for (var element in usersList) {
      Player p = Player(
        id: element.id,
        displayName: element.displayName,
        played: 0,
        wins: 0,
        draws: 0,
        losses: 0,
        scored: 0,
        conceded: 0,
        goalDef: 0,
        pts: 0,
      );
      await leagues.doc(league.id).collection("players").doc(p.id).set(p.toJson());
    }
  }

  // Future<List<League>> getEvents() async {
  //   List<League> eventsList = [];
  //   await events.orderBy('date', descending: true).get().then((event) {
  //     for (var doc in event.docs) {
  //       eventsList.add(League.fromJson(doc));
  //     }
  //   });
  //   return eventsList;
  // }

  // Future<void> updateEvent(League event) async {
  //   await events.doc(event.id).update(event.toJson());
  // }

  // Future<void> deleteEvent(String id) async {
  //   await events.doc(id).delete();
  // }

  // Future<void> setInitialEvent(League event) async {
  //   await initialEvent.doc('Initial_event').set(event.toJson());
  // }

  // Future<League> getInitialEvent() async {
  //   dynamic data;
  //   League event;
  //   await initialEvent
  //       .doc('Initial_event')
  //       .get()
  //       .then<dynamic>((DocumentSnapshot snapshot) async {
  //     data = snapshot.data();
  //   });
  //   event = League.fromJson(data);
  //   return event;
  // }

  // Future<List> getVisitsList(int month, int year) async {
  //   String id = '$month-$year';
  //   List v = [];
  //   var doc = await visits.doc(id).get();
  //   if (doc.exists) {
  //     await visits.doc(id).get().then((value) async {
  //       final docs = value.data()!;
  //       final data = docs as Map<String, dynamic>;
  //       v = data['visits'] as List;
  //     });
  //     return v;
  //   }
  //   return [];
  // }

  // Future<int> getMonthVisits() async {
  //   int year = DateTime.now().year;
  //   int month = DateTime.now().month;
  //   String id = '$month-$year';
  //   List v = [];
  //   num x = 0;
  //   var doc = await visits.doc(id).get();
  //   if (doc.exists) {
  //     await visits.doc(id).get().then((value) async {
  //       final docs = value.data()!;
  //       final data = docs as Map<String, dynamic>;
  //       v = data['visits'] as List;
  //     });
  //     for (var i = 0; i < v.length; i++) {
  //       x += v[i];
  //     }
  //     return x.toInt();
  //   }
  //   return 0;
  // }

  // Future<int> countEvents() async {
  //   AggregateQuerySnapshot query = await events.count().get();
  //   int i;
  //   if (query.count != null) {
  //     i = query.count!;
  //     return i;
  //   }
  //   return 0;
  // }
}
