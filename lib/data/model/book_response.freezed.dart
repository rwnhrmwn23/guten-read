// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookResponse _$BookResponseFromJson(Map<String, dynamic> json) {
  return _BookResponse.fromJson(json);
}

/// @nodoc
mixin _$BookResponse {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<BookModel> get results => throw _privateConstructorUsedError;

  /// Serializes this BookResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookResponseCopyWith<BookResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookResponseCopyWith<$Res> {
  factory $BookResponseCopyWith(
          BookResponse value, $Res Function(BookResponse) then) =
      _$BookResponseCopyWithImpl<$Res, BookResponse>;
  @useResult
  $Res call(
      {int count, String? next, String? previous, List<BookModel> results});
}

/// @nodoc
class _$BookResponseCopyWithImpl<$Res, $Val extends BookResponse>
    implements $BookResponseCopyWith<$Res> {
  _$BookResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = null,
  }) {
    return _then(_value.copyWith(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<BookModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookResponseImplCopyWith<$Res>
    implements $BookResponseCopyWith<$Res> {
  factory _$$BookResponseImplCopyWith(
          _$BookResponseImpl value, $Res Function(_$BookResponseImpl) then) =
      __$$BookResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int count, String? next, String? previous, List<BookModel> results});
}

/// @nodoc
class __$$BookResponseImplCopyWithImpl<$Res>
    extends _$BookResponseCopyWithImpl<$Res, _$BookResponseImpl>
    implements _$$BookResponseImplCopyWith<$Res> {
  __$$BookResponseImplCopyWithImpl(
      _$BookResponseImpl _value, $Res Function(_$BookResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = null,
  }) {
    return _then(_$BookResponseImpl(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<BookModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookResponseImpl implements _BookResponse {
  const _$BookResponseImpl(
      {required this.count,
      this.next,
      this.previous,
      required final List<BookModel> results})
      : _results = results;

  factory _$BookResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookResponseImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<BookModel> _results;
  @override
  List<BookModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'BookResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookResponseImpl &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.previous, previous) ||
                other.previous == previous) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, count, next, previous,
      const DeepCollectionEquality().hash(_results));

  /// Create a copy of BookResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookResponseImplCopyWith<_$BookResponseImpl> get copyWith =>
      __$$BookResponseImplCopyWithImpl<_$BookResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookResponseImplToJson(
      this,
    );
  }
}

abstract class _BookResponse implements BookResponse {
  const factory _BookResponse(
      {required final int count,
      final String? next,
      final String? previous,
      required final List<BookModel> results}) = _$BookResponseImpl;

  factory _BookResponse.fromJson(Map<String, dynamic> json) =
      _$BookResponseImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<BookModel> get results;

  /// Create a copy of BookResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookResponseImplCopyWith<_$BookResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
