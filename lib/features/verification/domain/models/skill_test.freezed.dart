// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skill_test.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SkillTest {

// ignore: invalid_annotation_target
@JsonKey(name: '_id') String get id; String get skillId; String get level; int get passingScore; List<TestQuestion> get questions;
/// Create a copy of SkillTest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillTestCopyWith<SkillTest> get copyWith => _$SkillTestCopyWithImpl<SkillTest>(this as SkillTest, _$identity);

  /// Serializes this SkillTest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkillTest&&(identical(other.id, id) || other.id == id)&&(identical(other.skillId, skillId) || other.skillId == skillId)&&(identical(other.level, level) || other.level == level)&&(identical(other.passingScore, passingScore) || other.passingScore == passingScore)&&const DeepCollectionEquality().equals(other.questions, questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,skillId,level,passingScore,const DeepCollectionEquality().hash(questions));

@override
String toString() {
  return 'SkillTest(id: $id, skillId: $skillId, level: $level, passingScore: $passingScore, questions: $questions)';
}


}

/// @nodoc
abstract mixin class $SkillTestCopyWith<$Res>  {
  factory $SkillTestCopyWith(SkillTest value, $Res Function(SkillTest) _then) = _$SkillTestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String id, String skillId, String level, int passingScore, List<TestQuestion> questions
});




}
/// @nodoc
class _$SkillTestCopyWithImpl<$Res>
    implements $SkillTestCopyWith<$Res> {
  _$SkillTestCopyWithImpl(this._self, this._then);

  final SkillTest _self;
  final $Res Function(SkillTest) _then;

/// Create a copy of SkillTest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? skillId = null,Object? level = null,Object? passingScore = null,Object? questions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,skillId: null == skillId ? _self.skillId : skillId // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,passingScore: null == passingScore ? _self.passingScore : passingScore // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<TestQuestion>,
  ));
}

}


/// Adds pattern-matching-related methods to [SkillTest].
extension SkillTestPatterns on SkillTest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkillTest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkillTest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkillTest value)  $default,){
final _that = this;
switch (_that) {
case _SkillTest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkillTest value)?  $default,){
final _that = this;
switch (_that) {
case _SkillTest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String id,  String skillId,  String level,  int passingScore,  List<TestQuestion> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkillTest() when $default != null:
return $default(_that.id,_that.skillId,_that.level,_that.passingScore,_that.questions);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String id,  String skillId,  String level,  int passingScore,  List<TestQuestion> questions)  $default,) {final _that = this;
switch (_that) {
case _SkillTest():
return $default(_that.id,_that.skillId,_that.level,_that.passingScore,_that.questions);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String id,  String skillId,  String level,  int passingScore,  List<TestQuestion> questions)?  $default,) {final _that = this;
switch (_that) {
case _SkillTest() when $default != null:
return $default(_that.id,_that.skillId,_that.level,_that.passingScore,_that.questions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkillTest implements SkillTest {
  const _SkillTest({@JsonKey(name: '_id') required this.id, required this.skillId, required this.level, required this.passingScore, required final  List<TestQuestion> questions}): _questions = questions;
  factory _SkillTest.fromJson(Map<String, dynamic> json) => _$SkillTestFromJson(json);

// ignore: invalid_annotation_target
@override@JsonKey(name: '_id') final  String id;
@override final  String skillId;
@override final  String level;
@override final  int passingScore;
 final  List<TestQuestion> _questions;
@override List<TestQuestion> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of SkillTest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkillTestCopyWith<_SkillTest> get copyWith => __$SkillTestCopyWithImpl<_SkillTest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkillTestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkillTest&&(identical(other.id, id) || other.id == id)&&(identical(other.skillId, skillId) || other.skillId == skillId)&&(identical(other.level, level) || other.level == level)&&(identical(other.passingScore, passingScore) || other.passingScore == passingScore)&&const DeepCollectionEquality().equals(other._questions, _questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,skillId,level,passingScore,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'SkillTest(id: $id, skillId: $skillId, level: $level, passingScore: $passingScore, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$SkillTestCopyWith<$Res> implements $SkillTestCopyWith<$Res> {
  factory _$SkillTestCopyWith(_SkillTest value, $Res Function(_SkillTest) _then) = __$SkillTestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String id, String skillId, String level, int passingScore, List<TestQuestion> questions
});




}
/// @nodoc
class __$SkillTestCopyWithImpl<$Res>
    implements _$SkillTestCopyWith<$Res> {
  __$SkillTestCopyWithImpl(this._self, this._then);

  final _SkillTest _self;
  final $Res Function(_SkillTest) _then;

/// Create a copy of SkillTest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? skillId = null,Object? level = null,Object? passingScore = null,Object? questions = null,}) {
  return _then(_SkillTest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,skillId: null == skillId ? _self.skillId : skillId // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,passingScore: null == passingScore ? _self.passingScore : passingScore // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<TestQuestion>,
  ));
}


}


/// @nodoc
mixin _$TestQuestion {

 String get question; List<String> get options;
/// Create a copy of TestQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestQuestionCopyWith<TestQuestion> get copyWith => _$TestQuestionCopyWithImpl<TestQuestion>(this as TestQuestion, _$identity);

  /// Serializes this TestQuestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestQuestion&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'TestQuestion(question: $question, options: $options)';
}


}

/// @nodoc
abstract mixin class $TestQuestionCopyWith<$Res>  {
  factory $TestQuestionCopyWith(TestQuestion value, $Res Function(TestQuestion) _then) = _$TestQuestionCopyWithImpl;
@useResult
$Res call({
 String question, List<String> options
});




}
/// @nodoc
class _$TestQuestionCopyWithImpl<$Res>
    implements $TestQuestionCopyWith<$Res> {
  _$TestQuestionCopyWithImpl(this._self, this._then);

  final TestQuestion _self;
  final $Res Function(TestQuestion) _then;

/// Create a copy of TestQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? options = null,}) {
  return _then(_self.copyWith(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TestQuestion].
extension TestQuestionPatterns on TestQuestion {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestQuestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestQuestion() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestQuestion value)  $default,){
final _that = this;
switch (_that) {
case _TestQuestion():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestQuestion value)?  $default,){
final _that = this;
switch (_that) {
case _TestQuestion() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String question,  List<String> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestQuestion() when $default != null:
return $default(_that.question,_that.options);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String question,  List<String> options)  $default,) {final _that = this;
switch (_that) {
case _TestQuestion():
return $default(_that.question,_that.options);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String question,  List<String> options)?  $default,) {final _that = this;
switch (_that) {
case _TestQuestion() when $default != null:
return $default(_that.question,_that.options);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestQuestion implements TestQuestion {
  const _TestQuestion({required this.question, required final  List<String> options}): _options = options;
  factory _TestQuestion.fromJson(Map<String, dynamic> json) => _$TestQuestionFromJson(json);

@override final  String question;
 final  List<String> _options;
@override List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of TestQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestQuestionCopyWith<_TestQuestion> get copyWith => __$TestQuestionCopyWithImpl<_TestQuestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestQuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestQuestion&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other._options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'TestQuestion(question: $question, options: $options)';
}


}

/// @nodoc
abstract mixin class _$TestQuestionCopyWith<$Res> implements $TestQuestionCopyWith<$Res> {
  factory _$TestQuestionCopyWith(_TestQuestion value, $Res Function(_TestQuestion) _then) = __$TestQuestionCopyWithImpl;
@override @useResult
$Res call({
 String question, List<String> options
});




}
/// @nodoc
class __$TestQuestionCopyWithImpl<$Res>
    implements _$TestQuestionCopyWith<$Res> {
  __$TestQuestionCopyWithImpl(this._self, this._then);

  final _TestQuestion _self;
  final $Res Function(_TestQuestion) _then;

/// Create a copy of TestQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? options = null,}) {
  return _then(_TestQuestion(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$QuizSubmissionResponse {

 int get score; bool get passed; String? get verification;
/// Create a copy of QuizSubmissionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizSubmissionResponseCopyWith<QuizSubmissionResponse> get copyWith => _$QuizSubmissionResponseCopyWithImpl<QuizSubmissionResponse>(this as QuizSubmissionResponse, _$identity);

  /// Serializes this QuizSubmissionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizSubmissionResponse&&(identical(other.score, score) || other.score == score)&&(identical(other.passed, passed) || other.passed == passed)&&(identical(other.verification, verification) || other.verification == verification));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,score,passed,verification);

@override
String toString() {
  return 'QuizSubmissionResponse(score: $score, passed: $passed, verification: $verification)';
}


}

/// @nodoc
abstract mixin class $QuizSubmissionResponseCopyWith<$Res>  {
  factory $QuizSubmissionResponseCopyWith(QuizSubmissionResponse value, $Res Function(QuizSubmissionResponse) _then) = _$QuizSubmissionResponseCopyWithImpl;
@useResult
$Res call({
 int score, bool passed, String? verification
});




}
/// @nodoc
class _$QuizSubmissionResponseCopyWithImpl<$Res>
    implements $QuizSubmissionResponseCopyWith<$Res> {
  _$QuizSubmissionResponseCopyWithImpl(this._self, this._then);

  final QuizSubmissionResponse _self;
  final $Res Function(QuizSubmissionResponse) _then;

/// Create a copy of QuizSubmissionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? score = null,Object? passed = null,Object? verification = freezed,}) {
  return _then(_self.copyWith(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,verification: freezed == verification ? _self.verification : verification // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizSubmissionResponse].
extension QuizSubmissionResponsePatterns on QuizSubmissionResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizSubmissionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizSubmissionResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizSubmissionResponse value)  $default,){
final _that = this;
switch (_that) {
case _QuizSubmissionResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizSubmissionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _QuizSubmissionResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int score,  bool passed,  String? verification)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizSubmissionResponse() when $default != null:
return $default(_that.score,_that.passed,_that.verification);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int score,  bool passed,  String? verification)  $default,) {final _that = this;
switch (_that) {
case _QuizSubmissionResponse():
return $default(_that.score,_that.passed,_that.verification);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int score,  bool passed,  String? verification)?  $default,) {final _that = this;
switch (_that) {
case _QuizSubmissionResponse() when $default != null:
return $default(_that.score,_that.passed,_that.verification);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizSubmissionResponse implements QuizSubmissionResponse {
  const _QuizSubmissionResponse({required this.score, required this.passed, this.verification});
  factory _QuizSubmissionResponse.fromJson(Map<String, dynamic> json) => _$QuizSubmissionResponseFromJson(json);

@override final  int score;
@override final  bool passed;
@override final  String? verification;

/// Create a copy of QuizSubmissionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizSubmissionResponseCopyWith<_QuizSubmissionResponse> get copyWith => __$QuizSubmissionResponseCopyWithImpl<_QuizSubmissionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizSubmissionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizSubmissionResponse&&(identical(other.score, score) || other.score == score)&&(identical(other.passed, passed) || other.passed == passed)&&(identical(other.verification, verification) || other.verification == verification));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,score,passed,verification);

@override
String toString() {
  return 'QuizSubmissionResponse(score: $score, passed: $passed, verification: $verification)';
}


}

/// @nodoc
abstract mixin class _$QuizSubmissionResponseCopyWith<$Res> implements $QuizSubmissionResponseCopyWith<$Res> {
  factory _$QuizSubmissionResponseCopyWith(_QuizSubmissionResponse value, $Res Function(_QuizSubmissionResponse) _then) = __$QuizSubmissionResponseCopyWithImpl;
@override @useResult
$Res call({
 int score, bool passed, String? verification
});




}
/// @nodoc
class __$QuizSubmissionResponseCopyWithImpl<$Res>
    implements _$QuizSubmissionResponseCopyWith<$Res> {
  __$QuizSubmissionResponseCopyWithImpl(this._self, this._then);

  final _QuizSubmissionResponse _self;
  final $Res Function(_QuizSubmissionResponse) _then;

/// Create a copy of QuizSubmissionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? score = null,Object? passed = null,Object? verification = freezed,}) {
  return _then(_QuizSubmissionResponse(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,verification: freezed == verification ? _self.verification : verification // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
