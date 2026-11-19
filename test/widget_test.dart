import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import 'package:kosfinder_device_demo/main.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  testWidgets('KosFinderDeviceApp renders local mode UI', (tester) async {
    await tester.pumpWidget(const KosFinderDeviceApp());
    await tester.pumpAndSettle();

    expect(find.text('KosFinder · Device Demo'), findsOneWidget);
    expect(
      find.text('Mode: lokal/offline (Supabase belum dikonfigurasi)'),
      findsOneWidget,
    );
    expect(find.text('Kamera'), findsOneWidget);
    expect(find.text('Galeri'), findsOneWidget);
    expect(find.text('Ambil Koordinat GPS'), findsOneWidget);
    expect(find.text('Simpan Draft Lokal'), findsOneWidget);

    // Upload button is disabled when Supabase is not configured.
    final uploadButton = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Upload Foto ke Supabase (opsional)'),
    );
    expect(uploadButton.onPressed, isNull);
  });
}
