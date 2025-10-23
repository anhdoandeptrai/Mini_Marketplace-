import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../core/errors/exceptions.dart';
import '../models/course_model.dart';
import 'imgbb_remote_datasource.dart';

abstract class CourseRemoteDataSource {
  Future<List<CourseModel>> getCourses();
  Future<CourseModel> getCourseById(String courseId);
  Future<CourseModel> createCourse(
    String title,
    String description,
    double price,
    List<String> tags,
    String? imagePath,
    String? youtubeUrl,
    String? pdfUrl,
  );
  Future<List<CourseModel>> getMyCourses(String userId);
  Future<void> toggleCourseStatus(String courseId, bool isActive);
  Future<CourseModel> updateCourse(
    String courseId,
    String title,
    String description,
    double price,
    List<String> tags,
    String? imagePath,
    String? youtubeUrl,
    String? pdfUrl,
  );
  Future<void> deleteCourse(String courseId);
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final ImgbbRemoteDataSource? imgbbRemote;
  final bool useImgbbOnCreate;

  CourseRemoteDataSourceImpl({
    required this.firestore,
    required this.storage,
    this.imgbbRemote,
    this.useImgbbOnCreate = false,
  });

  @override
  Future<List<CourseModel>> getCourses() async {
    try {
      final snapshot = await firestore
          .collection('courses')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => CourseModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CourseModel> getCourseById(String courseId) async {
    try {
      final doc = await firestore.collection('courses').doc(courseId).get();

      if (!doc.exists) {
        throw ServerException('Course not found');
      }

      return CourseModel.fromJson(doc.data()!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CourseModel> createCourse(
    String title,
    String description,
    double price,
    List<String> tags,
    String? imagePath,
    String? youtubeUrl,
    String? pdfUrl,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw AuthException('User not logged in');
      }

      // Get user data
      final userDoc = await firestore.collection('users').doc(user.uid).get();
      final userData = userDoc.data();

      String? imageUrl;
      if (imagePath != null) {
        if (useImgbbOnCreate && imgbbRemote != null) {
          try {
            imageUrl = await imgbbRemote!.uploadImage(File(imagePath));
          } catch (e) {
            // Fallback to Firebase Storage if imgbb fails
            final ref = storage.ref().child(
              'courses/${DateTime.now().millisecondsSinceEpoch}.jpg',
            );
            await ref.putFile(File(imagePath));
            imageUrl = await ref.getDownloadURL();
          }
        } else {
          final ref = storage.ref().child(
            'courses/${DateTime.now().millisecondsSinceEpoch}.jpg',
          );
          await ref.putFile(File(imagePath));
          imageUrl = await ref.getDownloadURL();
        }
      }

      final courseRef = firestore.collection('courses').doc();
      final courseModel = CourseModel(
        id: courseRef.id,
        title: title,
        description: description,
        price: price,
        teacherId: user.uid,
        teacherName: userData?['name'] ?? 'Unknown',
        imageUrl: imageUrl,
        tags: tags,
        createdAt: DateTime.now(),
        enrolledCount: 0,
        youtubeUrl: youtubeUrl,
        pdfUrl: pdfUrl,
      );

      await courseRef.set(courseModel.toJson());

      return courseModel;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CourseModel>> getMyCourses(String userId) async {
    try {
      final snapshot = await firestore
          .collection('courses')
          .where('teacherId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => CourseModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> toggleCourseStatus(String courseId, bool isActive) async {
    try {
      await firestore.collection('courses').doc(courseId).update({
        'isActive': isActive,
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CourseModel> updateCourse(
    String courseId,
    String title,
    String description,
    double price,
    List<String> tags,
    String? imagePath,
    String? youtubeUrl,
    String? pdfUrl,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw AuthException('User not logged in');
      }

      // Get current course data
      final courseDoc = await firestore
          .collection('courses')
          .doc(courseId)
          .get();
      if (!courseDoc.exists) {
        throw ServerException('Course not found');
      }
      final currentCourse = CourseModel.fromJson(courseDoc.data()!);

      // Check if user is the owner
      if (currentCourse.teacherId != user.uid) {
        throw AuthException('Not authorized to update this course');
      }

      String? imageUrl = currentCourse.imageUrl;
      if (imagePath != null) {
        if (useImgbbOnCreate && imgbbRemote != null) {
          try {
            imageUrl = await imgbbRemote!.uploadImage(File(imagePath));
          } catch (e) {
            final ref = storage.ref().child(
              'courses/${DateTime.now().millisecondsSinceEpoch}.jpg',
            );
            await ref.putFile(File(imagePath));
            imageUrl = await ref.getDownloadURL();
          }
        } else {
          final ref = storage.ref().child(
            'courses/${DateTime.now().millisecondsSinceEpoch}.jpg',
          );
          await ref.putFile(File(imagePath));
          imageUrl = await ref.getDownloadURL();
        }
      }

      final updatedCourse = CourseModel(
        id: courseId,
        title: title,
        description: description,
        price: price,
        teacherId: currentCourse.teacherId,
        teacherName: currentCourse.teacherName,
        imageUrl: imageUrl,
        tags: tags,
        createdAt: currentCourse.createdAt,
        enrolledCount: currentCourse.enrolledCount,
        isActive: currentCourse.isActive,
        youtubeUrl: youtubeUrl,
        pdfUrl: pdfUrl,
      );

      await firestore
          .collection('courses')
          .doc(courseId)
          .update(updatedCourse.toJson());

      return updatedCourse;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteCourse(String courseId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw AuthException('User not logged in');
      }

      // Get course data to verify ownership
      final courseDoc = await firestore
          .collection('courses')
          .doc(courseId)
          .get();
      if (!courseDoc.exists) {
        throw ServerException('Course not found');
      }
      final course = CourseModel.fromJson(courseDoc.data()!);

      // Check if user is the owner
      if (course.teacherId != user.uid) {
        throw AuthException('Not authorized to delete this course');
      }

      // Delete the course
      await firestore.collection('courses').doc(courseId).delete();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
