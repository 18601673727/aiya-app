// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approval.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Approval {
  String get fileName => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get actionType => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  int get fileId => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ApprovalCopyWith<Approval> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalCopyWith<$Res> {
  factory $ApprovalCopyWith(Approval value, $Res Function(Approval) then) =
      _$ApprovalCopyWithImpl<$Res, Approval>;
  @useResult
  $Res call(
      {String fileName,
      String userName,
      String actionType,
      String description,
      String createdAt,
      int fileId,
      int userId});
}

/// @nodoc
class _$ApprovalCopyWithImpl<$Res, $Val extends Approval>
    implements $ApprovalCopyWith<$Res> {
  _$ApprovalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileName = null,
    Object? userName = null,
    Object? actionType = null,
    Object? description = null,
    Object? createdAt = null,
    Object? fileId = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      fileId: null == fileId
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ApprovalCopyWith<$Res> implements $ApprovalCopyWith<$Res> {
  factory _$$_ApprovalCopyWith(
          _$_Approval value, $Res Function(_$_Approval) then) =
      __$$_ApprovalCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fileName,
      String userName,
      String actionType,
      String description,
      String createdAt,
      int fileId,
      int userId});
}

/// @nodoc
class __$$_ApprovalCopyWithImpl<$Res>
    extends _$ApprovalCopyWithImpl<$Res, _$_Approval>
    implements _$$_ApprovalCopyWith<$Res> {
  __$$_ApprovalCopyWithImpl(
      _$_Approval _value, $Res Function(_$_Approval) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileName = null,
    Object? userName = null,
    Object? actionType = null,
    Object? description = null,
    Object? createdAt = null,
    Object? fileId = null,
    Object? userId = null,
  }) {
    return _then(_$_Approval(
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      fileId: null == fileId
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Approval with DiagnosticableTreeMixin implements _Approval {
  const _$_Approval(
      {required this.fileName,
      required this.userName,
      required this.actionType,
      required this.description,
      required this.createdAt,
      required this.fileId,
      required this.userId});

  @override
  final String fileName;
  @override
  final String userName;
  @override
  final String actionType;
  @override
  final String description;
  @override
  final String createdAt;
  @override
  final int fileId;
  @override
  final int userId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Approval(fileName: $fileName, userName: $userName, actionType: $actionType, description: $description, createdAt: $createdAt, fileId: $fileId, userId: $userId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Approval'))
      ..add(DiagnosticsProperty('fileName', fileName))
      ..add(DiagnosticsProperty('userName', userName))
      ..add(DiagnosticsProperty('actionType', actionType))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('fileId', fileId))
      ..add(DiagnosticsProperty('userId', userId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Approval &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.fileId, fileId) || other.fileId == fileId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fileName, userName, actionType,
      description, createdAt, fileId, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ApprovalCopyWith<_$_Approval> get copyWith =>
      __$$_ApprovalCopyWithImpl<_$_Approval>(this, _$identity);
}

abstract class _Approval implements Approval {
  const factory _Approval(
      {required final String fileName,
      required final String userName,
      required final String actionType,
      required final String description,
      required final String createdAt,
      required final int fileId,
      required final int userId}) = _$_Approval;

  @override
  String get fileName;
  @override
  String get userName;
  @override
  String get actionType;
  @override
  String get description;
  @override
  String get createdAt;
  @override
  int get fileId;
  @override
  int get userId;
  @override
  @JsonKey(ignore: true)
  _$$_ApprovalCopyWith<_$_Approval> get copyWith =>
      throw _privateConstructorUsedError;
}
