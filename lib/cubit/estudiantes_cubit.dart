import 'dart:async'; // Actividad 2: para TimeoutException

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http; // Actividad 2: para ClientException

import '../services/estudiante_service.dart';
import 'estudiantes_state.dart';


/// Controla la consulta de estudiantes: emite Carga, Exito,
/// Vacio o Error según la respuesta del servicio.
class EstudiantesCubit extends Cubit<EstudiantesState> {
  final EstudianteService _servicio;

  EstudiantesCubit(this._servicio) : super(const EstudiantesInicial());

  Future<void> cargarEstudiantes() async {
    emit(const EstudiantesCarga());
    try {
      final datos = await _servicio.obtenerEstudiantes();
      if (datos.isEmpty) {
        emit(const EstudiantesVacio());
      } else {
        emit(EstudiantesExito(datos));
      }
    } on TimeoutException {
      // La API tardó más de 10 segundos (el .timeout del servicio)
      emit(const EstudiantesError(
        'El servidor tardó demasiado en responder. Intenta de nuevo.',
      ));
    } on http.ClientException {
      // No se pudo conectar: sin internet, modo avión, DNS, etc.
      emit(const EstudiantesError(
        'Sin conexión a internet. Revisa tu red e intenta de nuevo.',
      ));
    } catch (e) {
      // Cualquier otro error, por ejemplo statusCode != 200
      emit(const EstudiantesError(
        'Error del servidor. No se pudieron cargar los datos.',
      ));
    }
  }

  void reiniciar() => emit(const EstudiantesInicial());
}
