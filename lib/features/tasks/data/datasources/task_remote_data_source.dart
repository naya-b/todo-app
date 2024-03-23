import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/error/exceptions.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/authentecation/data/datasources/auth_remote_data_source.dart';
import 'package:todo_app/features/tasks/data/models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getAllTasks();
  Future<Unit> deleteTask(String id);
  Future<Unit> addTask(TaskModel taskModel);
  Future<Unit> updateTask(
    TaskModel taskModel,
  );
  Future<Unit> updateCheckbox(bool value, String taskId);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  String databaseId = '658b1688e8e82c9163b4';
  String collectionId = '658b1778acd12700ade6';
  final Databases databases = Databases(client);
  final SharedPreferences sharedPreferences;

  List _todos = [];

  TaskRemoteDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      final email2 = sharedPreferences.getString('email');
      final data = await databases.listDocuments(
          databaseId: databaseId,
          collectionId: collectionId,
          queries: [Query.equal('createdBy', email2)]); // add queries
      //_todos = data.documents;
      final List<TaskModel> taskModels = data.documents
          .map((jsonTaskModel) =>
              TaskModel.fromJson(jsonTaskModel.data, jsonTaskModel.$id))
          .toList();
      print(taskModels);
      return taskModels;
    } on ServerException {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addTask(TaskModel taskModel) async {
    try {
      final docid = ID.unique();
      final email = sharedPreferences.getString('email');
      final data = {
        'title': taskModel.title,
        'body': taskModel.body,
        'isDone': false,
        'createdBy': email,
      };

      final collection = await databases.createDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: docid,
          data: data);
      return Future.value(unit);
    } on ServerException {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateTask(TaskModel taskModel) async {
    final newData = {
      'title': taskModel.title,
      'body': taskModel.body,
      'isDone': taskModel.isDone,
    };
    try {
      final updateDoc = await databases.updateDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: taskModel.id2,
        data: newData,
      );
      return Future.value(unit);
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<Unit> deleteTask(String taskId) async {
    try {
      final deleteDoc = await databases.deleteDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: taskId);
      return Future.value(unit);
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<Unit> updateCheckbox(bool value, String taskId) async {
    try {
      print('update check box');
      final updateDoc = await databases.updateDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: taskId,
        data: {'isDone': value},
      );
      return Future.value(unit);
    } on ServerException {
      throw ServerFailure();
    }
  }
}
