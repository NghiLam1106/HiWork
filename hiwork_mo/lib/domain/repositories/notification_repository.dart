import 'package:dartz/dartz.dart'; 
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/domain/entities/notification_entity.dart'; 

abstract class NotificationRepository {
   Future<Either<Failure, List<NotificationEntity>>> getNotifications();
}