// Mocks generated by Mockito 5.0.8 from annotations
// in ditonton/test/presentation/pages/top_rated_tvs_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:ui' as _i7;

import 'package:ditonton/common/state_enum.dart' as _i4;
import 'package:ditonton/domain/entities/tv.dart' as _i5;
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart' as _i2;
import 'package:ditonton/presentation/provider/tv/top_rated_tv_notifier.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeGetTopRatedTV extends _i1.Fake implements _i2.GetTopRatedTV {
}

/// A class which mocks [TopRatedTVNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTopRatedTVNotifier extends _i1.Mock
    implements _i3.TopRatedTVNotifier {
  MockTopRatedTVNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTopRatedTV get getTopRatedTV =>
      (super.noSuchMethod(Invocation.getter(#getTopRatedTV),
          returnValue: _FakeGetTopRatedTV()) as _i2.GetTopRatedTV);
  @override
  _i4.RequestState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _i4.RequestState.Empty) as _i4.RequestState);
  @override
  List<_i5.TV> get tv => (super.noSuchMethod(Invocation.getter(#tvs),
      returnValue: <_i5.TV>[]) as List<_i5.TV>);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i6.Future<void> fetchTopRatedTV() =>
      (super.noSuchMethod(Invocation.method(#fetchTopRatedTV, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i6.Future<void>);
  @override
  void addListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
