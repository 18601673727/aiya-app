// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approvals.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Approvals _$ApprovalsFromJson(Map<String, dynamic> json) {
  return _Approvals.fromJson(json);
}

/// @nodoc
mixin _$Approvals {
  List<Approval> get approvalList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApprovalsCopyWith<Approvals> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalsCopyWith<$Res> {
  factory $ApprovalsCopyWith(Approvals value, $Res Function(Approvals) then) =
      _$ApprovalsCopyWithImpl<$Res, Approvals>;
  @useResult
  $Res call({List<Approval> approvalList});
}

/// @nodoc
class _$ApprovalsCopyWithImpl<$Res, $Val extends Approvals>
    implements $ApprovalsCopyWith<$Res> {
  _$ApprovalsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? approvalList = null,
  }) {
    return _then(_value.copyWith(
      approvalList: null == approvalList
          ? _value.approvalList
          : approvalList // ignore: cast_nullable_to_non_nullable
              as List<Approval>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ApprovalsCopyWith<$Res> implements $ApprovalsCopyWith<$Res> {
  factory _$$_ApprovalsCopyWith(
          _$_Approvals value, $Res Function(_$_Approvals) then) =
      __$$_ApprovalsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Approval> approvalList});
}

/// @nodoc
class __$$_ApprovalsCopyWithImpl<$Res>
    extends _$ApprovalsCopyWithImpl<$Res, _$_Approvals>
    implements _$$_ApprovalsCopyWith<$Res> {
  __$$_ApprovalsCopyWithImpl(
      _$_Approvals _value, $Res Function(_$_Approvals) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? approvalList = null,
  }) {
    return _then(_$_Approvals(
      approvalList: null == approvalList
          ? _value._approvalList
          : approvalList // ignore: cast_nullable_to_non_nullable
              as List<Approval>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Approvals implements _Approvals {
  const _$_Approvals({required final List<Approval> approvalList})
      : _approvalList = approvalList;

  factory _$_Approvals.fromJson(Map<String, dynamic> json) =>
      _$$_ApprovalsFromJson(json);

  final List<Approval> _approvalList;
  @override
  List<Approval> get approvalList {
    if (_approvalList is EqualUnmodifiableListView) return _approvalList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_approvalList);
  }

  @override
  String toString() {
    return 'Approvals(approvalList: $approvalList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Approvals &&
            const DeepCollectionEquality()
                .equals(other._approvalList, _approvalList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_approvalList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ApprovalsCopyWith<_$_Approvals> get copyWith =>
      __$$_ApprovalsCopyWithImpl<_$_Approvals>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ApprovalsToJson(
      this,
    );
  }
}

abstract class _Approvals implements Approvals {
  const factory _Approvals({required final List<Approval> approvalList}) =
      _$_Approvals;

  factory _Approvals.fromJson(Map<String, dynamic> json) =
      _$_Approvals.fromJson;

  @override
  List<Approval> get approvalList;
  @override
  @JsonKey(ignore: true)
  _$$_ApprovalsCopyWith<_$_Approvals> get copyWith =>
      throw _privateConstructorUsedError;
}
