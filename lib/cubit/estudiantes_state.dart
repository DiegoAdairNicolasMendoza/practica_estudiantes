import 'package:equatable/equatable.dart';

import '../models/estudiante.dart';

/// Estado base de la consulta. Es sealed para que el switch
/// de la pantalla esté obligado a cubrir los cinco estados.
sealed class EstudiantesState extends Equatable {
  const EstudiantesState();

  @override
  List<Object?> get props => [];
}

class EstudiantesInicial extends EstudiantesState {
  const EstudiantesInicial();
}

class EstudiantesCarga extends EstudiantesState {
  const EstudiantesCarga();
}

class EstudiantesVacio extends EstudiantesState {
  const EstudiantesVacio();
}

class EstudiantesExito extends EstudiantesState {
  final List<Estudiante> estudiantes;

  const EstudiantesExito(this.estudiantes);

  @override
  List<Object?> get props => [estudiantes];
}

class EstudiantesError extends EstudiantesState {
  final String mensaje;

  const EstudiantesError(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}
