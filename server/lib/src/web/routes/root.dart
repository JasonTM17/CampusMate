import 'package:campusmate_server/src/web/widgets/campusmate_status_page.dart';
import 'package:serverpod/serverpod.dart';

class RootRoute extends WidgetRoute {
  @override
  Future<TemplateWidget> build(Session session, Request request) async {
    return CampusMateStatusPageWidget();
  }
}
