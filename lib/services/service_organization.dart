import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kicker_app/models/organization.dart';

final _collection = FirebaseFirestore.instance
    .collection("organization")
    .withConverter<Organization>(
      fromFirestore: (snap, _) {
        return Organization.fromFirestore(snap.data() ?? {});
      },
      toFirestore: (_, __) => {},
    );

class OrganizationService {
  static Stream<DocumentSnapshot<Organization>> stream(String orgId) {
    return _collection.doc(orgId).snapshots();
  }
}
