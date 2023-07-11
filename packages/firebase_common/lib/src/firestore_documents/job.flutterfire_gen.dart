// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job.dart';

class ReadJob {
  const ReadJob._({
    required this.hostLocationId,
    required this.hostLocationReference,
    required this.hostId,
    required this.description,
    required this.place,
    required this.accessTypes,
    required this.createdAt,
    required this.updatedAt,
  });

  final String hostLocationId;
  final DocumentReference<ReadJob> hostLocationReference;
  final String hostId;
  final String description;
  final String place;
  final Set<AccessType> accessTypes;
  final SealedTimestamp createdAt;
  final SealedTimestamp updatedAt;

  factory ReadJob._fromJson(Map<String, dynamic> json) {
    return ReadJob._(
      hostLocationId: json['hostLocationId'] as String,
      hostLocationReference:
          json['hostLocationReference'] as DocumentReference<ReadJob>,
      hostId: json['hostId'] as String,
      description: json['description'] as String,
      place: json['place'] as String,
      accessTypes: json['accessTypes'] == null
          ? const <AccessType>{}
          : accessTypesConverter.fromJson(json['accessTypes'] as List<String>),
      createdAt: json['createdAt'] == null
          ? const ServerTimestamp()
          : sealedTimestampConverter.fromJson(json['createdAt'] as Object),
      updatedAt: json['updatedAt'] == null
          ? const ServerTimestamp()
          : alwaysUseServerTimestampSealedTimestampConverter
              .fromJson(json['updatedAt'] as Object),
    );
  }

  factory ReadJob.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadJob._fromJson(<String, dynamic>{
      ...data,
      'hostLocationId': ds.id,
      'hostLocationReference': ds.reference.parent.doc(ds.id).withConverter(
            fromFirestore: (ds, _) => ReadJob.fromDocumentSnapshot(ds),
            toFirestore: (obj, _) => throw UnimplementedError(),
          ),
    });
  }

  ReadJob copyWith({
    String? hostLocationId,
    DocumentReference<ReadJob>? hostLocationReference,
    String? hostId,
    String? description,
    String? place,
    Set<AccessType>? accessTypes,
    SealedTimestamp? createdAt,
    SealedTimestamp? updatedAt,
  }) {
    return ReadJob._(
      hostLocationId: hostLocationId ?? this.hostLocationId,
      hostLocationReference:
          hostLocationReference ?? this.hostLocationReference,
      hostId: hostId ?? this.hostId,
      description: description ?? this.description,
      place: place ?? this.place,
      accessTypes: accessTypes ?? this.accessTypes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CreateJob {
  const CreateJob({
    required this.hostId,
    required this.description,
    required this.place,
    this.accessTypes = const <AccessType>{},
    this.createdAt = const ServerTimestamp(),
    this.updatedAt = const ServerTimestamp(),
  });

  final String hostId;
  final String description;
  final String place;
  final Set<AccessType> accessTypes;
  final SealedTimestamp createdAt;
  final SealedTimestamp updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'hostId': hostId,
      'description': description,
      'place': place,
      'accessTypes': accessTypesConverter.toJson(accessTypes),
      'createdAt': sealedTimestampConverter.toJson(createdAt),
      'updatedAt':
          alwaysUseServerTimestampSealedTimestampConverter.toJson(updatedAt),
    };
  }
}

class UpdateJob {
  const UpdateJob({
    this.hostId,
    this.description,
    this.place,
    this.accessTypes,
    this.createdAt,
    this.updatedAt = const ServerTimestamp(),
  });

  final String? hostId;
  final String? description;
  final String? place;
  final Set<AccessType>? accessTypes;
  final SealedTimestamp? createdAt;
  final SealedTimestamp? updatedAt;

  Map<String, dynamic> toJson() {
    return {
      if (hostId != null) 'hostId': hostId,
      if (description != null) 'description': description,
      if (place != null) 'place': place,
      if (accessTypes != null)
        'accessTypes': accessTypesConverter.toJson(accessTypes!),
      if (createdAt != null)
        'createdAt': sealedTimestampConverter.toJson(createdAt!),
      'updatedAt': updatedAt == null
          ? const ServerTimestamp()
          : alwaysUseServerTimestampSealedTimestampConverter.toJson(updatedAt!),
    };
  }
}

/// A [CollectionReference] to jobs collection to read.
final readJobCollectionReference =
    FirebaseFirestore.instance.collection('jobs').withConverter<ReadJob>(
          fromFirestore: (ds, _) => ReadJob.fromDocumentSnapshot(ds),
          toFirestore: (obj, _) => throw UnimplementedError(),
        );

/// A [DocumentReference] to hostLocation document to read.
DocumentReference<ReadJob> readJobDocumentReference({
  required String hostLocationId,
}) =>
    readJobCollectionReference.doc(hostLocationId);

/// A [CollectionReference] to jobs collection to create.
final createJobCollectionReference =
    FirebaseFirestore.instance.collection('jobs').withConverter<CreateJob>(
          fromFirestore: (ds, _) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// A [DocumentReference] to hostLocation document to create.
DocumentReference<CreateJob> createJobDocumentReference({
  required String hostLocationId,
}) =>
    createJobCollectionReference.doc(hostLocationId);

/// A [CollectionReference] to jobs collection to update.
final updateJobCollectionReference =
    FirebaseFirestore.instance.collection('jobs').withConverter<UpdateJob>(
          fromFirestore: (ds, _) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// A [DocumentReference] to hostLocation document to update.
DocumentReference<UpdateJob> updateJobDocumentReference({
  required String hostLocationId,
}) =>
    updateJobCollectionReference.doc(hostLocationId);

/// A query manager to execute query against [Job].
class JobQuery {
  /// Fetches [ReadJob] documents.
  Future<List<ReadJob>> fetchDocuments({
    GetOptions? options,
    Query<ReadJob>? Function(Query<ReadJob> query)? queryBuilder,
    int Function(ReadJob lhs, ReadJob rhs)? compare,
  }) async {
    Query<ReadJob> query = readJobCollectionReference;
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

  /// Subscribes [Job] documents.
  Stream<List<ReadJob>> subscribeDocuments({
    Query<ReadJob>? Function(Query<ReadJob> query)? queryBuilder,
    int Function(ReadJob lhs, ReadJob rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    Query<ReadJob> query = readJobCollectionReference;
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

  /// Fetches a specified [ReadJob] document.
  Future<ReadJob?> fetchDocument({
    required String hostLocationId,
    GetOptions? options,
  }) async {
    final ds = await readJobDocumentReference(
      hostLocationId: hostLocationId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes a specified [Job] document.
  Future<Stream<ReadJob?>> subscribeDocument({
    required String hostLocationId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) async {
    var streamDs = readJobDocumentReference(
      hostLocationId: hostLocationId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Creates a [Job] document.
  Future<DocumentReference<CreateJob>> create({
    required CreateJob createJob,
  }) =>
      createJobCollectionReference.add(createJob);

  /// Sets a [Job] document.
  Future<void> set({
    required String hostLocationId,
    required CreateJob createJob,
    SetOptions? options,
  }) =>
      createJobDocumentReference(
        hostLocationId: hostLocationId,
      ).set(createJob, options);

  /// Updates a specified [Job] document.
  Future<void> update({
    required String hostLocationId,
    required UpdateJob updateJob,
  }) =>
      updateJobDocumentReference(
        hostLocationId: hostLocationId,
      ).update(updateJob.toJson());
}