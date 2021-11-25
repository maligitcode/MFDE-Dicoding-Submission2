import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/cubit/tv/tv_popular_cubit.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';


class TVPopularCubitMock extends MockCubit<TVPopularState> implements TVPopularCubit {}

void main() {
  late TVPopularCubitMock mockTVPopularCubit;

  setUp(() {
    mockTVPopularCubit = TVPopularCubitMock();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<TVPopularCubit>(
          create: (context) => mockTVPopularCubit,
        ),
      ],
      child: MaterialApp(home: body),
    );
  }

  void initializeFunction() {
    when(() => mockTVPopularCubit.get()).thenAnswer((_) async => {});
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    initializeFunction();

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    when(() => mockTVPopularCubit.state).thenAnswer((_) => const TVPopularLoadingState());
    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    /// Find Widget
    final listViewFinder = find.byType(ListView);

    initializeFunction();
    when(() => mockTVPopularCubit.state)
        .thenAnswer((_) => const TVPopularLoadedState(items: []));

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    /// Find Widget
    final textFinder = find.byKey(const Key('error_message'));

    initializeFunction();
    when(() => mockTVPopularCubit.state)
        .thenAnswer((_) => const TVPopularErrorState('error'));

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(textFinder, findsOneWidget);
  });
}
