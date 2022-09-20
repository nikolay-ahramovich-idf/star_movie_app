import 'package:presentation/bloc/base/bloc.dart';

extension ConvertApiRuntime on Bloc {
  String? formatApiRuntime(int? runtime) {
    if (runtime == null) return null;
    const minutesInHour = 60;
    final minutes = runtime % minutesInHour;
    final hours = (runtime - minutes) ~/ minutesInHour;
    return '${hours}hr ${minutes}m';
  }
}