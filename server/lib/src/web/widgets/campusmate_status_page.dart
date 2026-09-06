import 'package:serverpod/serverpod.dart';

/// Renders the lightweight CampusMate backend status page at `/`.
class CampusMateStatusPageWidget extends TemplateWidget {
  CampusMateStatusPageWidget() : super(name: 'campusmate_status') {
    values = {'served': DateTime.now(), 'runmode': Serverpod.instance.runMode};
  }
}
