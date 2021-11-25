import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/cubit/tv/tv_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_recommendations_cubit.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objectstv.dart';


class TVDetailCubitMock extends MockCubit<TVDetailState> implements TVDetailCubit {}

class TVRecommendationsCubitMock extends MockCubit<TVRecommendationsState>
    implements TVRecommendationsCubit {}

void main() {
  late TVDetailCubitMock tvDetailCubitMock;
  late TVRecommendationsCubitMock tvRecommendationsMock;

  setUp(() {
    tvRecommendationsMock = TVRecommendationsCubitMock();
    tvDetailCubitMock = TVDetailCubitMock();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<TVDetailCubit>(
          create: (context) => tvDetailCubitMock,
        ),
        BlocProvider<TVRecommendationsCubit>(
          create: (context) => tvRecommendationsMock,
        ),
      ],
      child: MaterialApp(home: body),
    );
  }

  void initializeFunction() {
    when(() => tvDetailCubitMock.get(any())).thenAnswer((_) async => {});
    when(() => tvDetailCubitMock.getWatchlistStatus(any())).thenAnswer((_) async => {});
    when(() => tvRecommendationsMock.get(any())).thenAnswer((_) async => {});
  }

  testWidgets('Watchlist button should display add icon when tv not added to watchlist',
          (WidgetTester tester) async {
        /// Find widget
        final watchlistButtonIcon = find.byIcon(Icons.add);

        initializeFunction();

        when(() => tvDetailCubitMock.state)
            .thenAnswer((_) => const TVDetailState(requestState: RequestState.Loaded));

        when(() => tvRecommendationsMock.state)
            .thenAnswer((_) => TVRecommendationsLoadedState(items: testTVList));

        await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets('Watchlist button should dispay check icon when tv is added to wathclist',
          (WidgetTester tester) async {
        /// Find Widget
        final watchlistButtonIcon = find.byIcon(Icons.check);

        initializeFunction();

        when(() => tvDetailCubitMock.state).thenReturn(
          TVDetailState(
            requestState: RequestState.Loaded,
            tv: testTVDetail,
            isAddedToWatchlist: true,
          ),
        );

        when(() => tvRecommendationsMock.state).thenReturn(
          const TVRecommendationsLoadedState(items: []),
        );

        await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets('Watchlist button should display Snackbar when added to watchlist',
          (WidgetTester tester) async {
        initializeFunction();
        when(() => tvDetailCubitMock.addWatchlist(testTVDetail)).thenAnswer((_) async => {});

        when(() => tvDetailCubitMock.state).thenReturn(
           TVDetailState(
            requestState: RequestState.Loaded,
            tv: testTVDetail,
            messageWatchlist: 'Added to Watchlist',
          ),
        );

        when(() => tvRecommendationsMock.state).thenReturn(
          const TVRecommendationsLoadedState(items: []),
        );

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

  testWidgets('Watchlist button should display AlertDialog when add to watchlist failed',
          (WidgetTester tester) async {
        initializeFunction();
        when(() => tvDetailCubitMock.addWatchlist(testTVDetail)).thenAnswer((_) async => {});

        when(() => tvDetailCubitMock.state).thenReturn(
           TVDetailState(
            requestState: RequestState.Loaded,
            tv: testTVDetail,
            messageWatchlist: 'Failed',
            isAddedToWatchlist: false,
          ),
        );

        when(() => tvRecommendationsMock.state).thenReturn(
          const TVRecommendationsLoadedState(items: []),
        );

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      });
}
