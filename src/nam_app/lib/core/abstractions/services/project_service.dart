import 'package:nam_app/core/entities/project.dart';

abstract class ProjectService {
  Future<List<Project>> getAllProjects();
  Future<Project?> getProjectById(String id);
  Future<void> addProject(Project project);
  Future<void> updateProject(Project project);
  Future<void> deleteProject(String id);
}
