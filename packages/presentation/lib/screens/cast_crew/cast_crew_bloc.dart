import 'package:domain/usecases/get_image_url_usecase.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/screens/cast_crew/cast_crew_screen.dart';
import 'package:presentation/screens/cast_crew/data/cast_crew_data.dart';

abstract class CastCrewBloc
    implements Bloc<CastCrewScreenArguments, CastCrewData> {
  factory CastCrewBloc(GetImageUrlUseCase getImageUrlUseCase) =>
      _CastCrewBloc(getImageUrlUseCase);

  String? getImageUrlById(String? id);

  void handleBackPressed();
}

class _CastCrewBloc extends BlocImpl<CastCrewScreenArguments, CastCrewData>
    implements CastCrewBloc {
  final GetImageUrlUseCase _getImageUrlUseCase;

  _CastCrewBloc(
    this._getImageUrlUseCase,
  ) : super(initState: CastCrewData.init());

  @override
  void initArgs(CastCrewScreenArguments args) {
    super.initArgs(args);

    add(CastCrewData(args.castAndCrew));
  }

  @override
  String? getImageUrlById(String? id) {
    return id != null ? _getImageUrlUseCase(id) : id;
  }

  @override
  void handleBackPressed() {
    appNavigator.pop();
  }
}
