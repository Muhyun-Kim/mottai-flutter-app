// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'worker.dart';

class ReadWorker {
  const ReadWorker._({
    required this.workerId,
    required this.workerReference,
    required this.displayName,
    required this.imageUrl,
  });

  final String workerId;
  final DocumentReference<ReadWorker> workerReference;
  final String displayName;
  final String? imageUrl;

  factory ReadWorker._fromJson(Map<String, dynamic> json) {
    return ReadWorker._(
      workerId: json['workerId'] as String,
      workerReference: json['workerReference'] as DocumentReference<ReadWorker>,
      displayName: json['displayName'] as String,
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  factory ReadWorker.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadWorker._fromJson(<String, dynamic>{
      ...data,
      'workerId': ds.id,
      'workerReference': ds.reference.parent.doc(ds.id).withConverter(
            fromFirestore: (ds, _) => ReadWorker.fromDocumentSnapshot(ds),
            toFirestore: (obj, _) => throw UnimplementedError(),
          ),
    });
  }

  ReadWorker copyWith({
    String? workerId,
    DocumentReference<ReadWorker>? workerReference,
    String? displayName,
    String? imageUrl,
  }) {
    return ReadWorker._(
      workerId: workerId ?? this.workerId,
      workerReference: workerReference ?? this.workerReference,
      displayName: displayName ?? this.displayName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class CreateWorker {
  const CreateWorker({
    required this.displayName,
    this.imageUrl,
  });

  final String displayName;
  final String? imageUrl;

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'imageUrl': imageUrl,
    };
  }
}

class UpdateWorker {
  const UpdateWorker({
    this.displayName,
    this.imageUrl,
  });

  final String? displayName;
  final String? imageUrl;

  Map<String, dynamic> toJson() {
    return {
      if (displayName != null) 'displayName': displayName,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }
}

/// A [CollectionReference] to workers collection to read.
final readWorkerCollectionReference =
    FirebaseFirestore.instance.collection('workers').withConverter<ReadWorker>(
          fromFirestore: (ds, _) => ReadWorker.fromDocumentSnapshot(ds),
          toFirestore: (obj, _) => throw UnimplementedError(),
        );

/// A [DocumentReference] to worker document to read.
DocumentReference<ReadWorker> readWorkerDocumentReference({
  required String workerId,
}) =>
    readWorkerCollectionReference.doc(workerId);

/// A [CollectionReference] to workers collection to create.
final createWorkerCollectionReference = FirebaseFirestore.instance
    .collection('workers')
    .withConverter<CreateWorker>(
      fromFirestore: (ds, _) => throw UnimplementedError(),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// A [DocumentReference] to worker document to create.
DocumentReference<CreateWorker> createWorkerDocumentReference({
  required String workerId,
}) =>
    createWorkerCollectionReference.doc(workerId);

/// A [CollectionReference] to workers collection to update.
final updateWorkerCollectionReference = FirebaseFirestore.instance
    .collection('workers')
    .withConverter<UpdateWorker>(
      fromFirestore: (ds, _) => throw UnimplementedError(),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// A [DocumentReference] to worker document to update.
DocumentReference<UpdateWorker> updateWorkerDocumentReference({
  required String workerId,
}) =>
    updateWorkerCollectionReference.doc(workerId);

/// A query manager to execute query against [Worker].
class WorkerQuery {
  /// Fetches [ReadWorker] documents.
  Future<List<ReadWorker>> fetchDocuments({
    GetOptions? options,
    Query<ReadWorker>? Function(Query<ReadWorker> query)? queryBuilder,
    int Function(ReadWorker lhs, ReadWorker rhs)? compare,
  }) async {
    Query<ReadWorker> query = readWorkerCollectionReference;
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final qs = await query.get(options);
    final result = qs.docs.map((qds) => qds.data()).toList();
    if (compare != null) {
      result.sort(compare);
    }
    return result;
  }

  /// Subscribes [Worker] documents.
  Stream<List<ReadWorker>> subscribeDocuments({
    Query<ReadWorker>? Function(Query<ReadWorker> query)? queryBuilder,
    int Function(ReadWorker lhs, ReadWorker rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    Query<ReadWorker> query = readWorkerCollectionReference;
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    var streamQs =
        query.snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamQs = streamQs.where((qs) => !qs.metadata.hasPendingWrites);
    }
    return streamQs.map((qs) {
      final result = qs.docs.map((qds) => qds.data()).toList();
      if (compare != null) {
        result.sort(compare);
      }
      return result;
    });
  }

  /// Fetches a specified [ReadWorker] document.
  Future<ReadWorker?> fetchDocument({
    required String workerId,
    GetOptions? options,
  }) async {
    final ds = await readWorkerDocumentReference(
      workerId: workerId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes a specified [Worker] document.
  Future<Stream<ReadWorker?>> subscribeDocument({
    required String workerId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) async {
    var streamDs = readWorkerDocumentReference(
      workerId: workerId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Creates a [Worker] document.
  Future<DocumentReference<CreateWorker>> create({
    required CreateWorker createWorker,
  }) =>
      createWorkerCollectionReference.add(createWorker);

  /// Sets a [Worker] document.
  Future<void> set({
    required String workerId,
    required CreateWorker createWorker,
    SetOptions? options,
  }) =>
      createWorkerDocumentReference(
        workerId: workerId,
      ).set(createWorker, options);

  /// Updates a specified [Worker] document.
  Future<void> update({
    required String workerId,
    required UpdateWorker updateWorker,
  }) =>
      updateWorkerDocumentReference(
        workerId: workerId,
      ).update(updateWorker.toJson());
}
