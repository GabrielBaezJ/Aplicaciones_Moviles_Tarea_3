import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:aplicaciones_moviles_tarea_3/main.dart';
import 'package:aplicaciones_moviles_tarea_3/view_model/lugar_viewmodel.dart';

void main() {
  testWidgets('Carga inicial de la app en Splash y transicion', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => LugarViewModel(),
        child: const MyApp(),
      ),
    );

    // Verifica que el Splash muestra el titulo
    expect(find.text('Ecuador Turístico'), findsOneWidget);

    // Avanza el tiempo para completar la animacion y el temporizador
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    // Verifica que llego a la pantalla de lugares
    expect(find.text('Lugares Turísticos'), findsOneWidget);
  });
}
