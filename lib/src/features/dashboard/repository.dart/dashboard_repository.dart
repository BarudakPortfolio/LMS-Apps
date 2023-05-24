import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/core/utils/exceptions.dart';
import 'package:lms/src/features/dashboard/data/dashboard_api.dart';
import 'package:lms/src/features/storage/provider/storage_provider.dart';
import 'package:lms/src/features/storage/service/storage.dart';

import '../../../core/utils/failures.dart';

class DashboardRepository {
  final DashboardApi dashboardApi;
  final SecureStorage storage;
  DashboardRepository({required this.dashboardApi, required this.storage});

  Future<Either<Failure, dynamic>> getDashboardData() async {
    try {
      final token = await storage.read('token');
      final result = await dashboardApi.getDashboardData(token);
      return Right(result['data']);
    } on ServerException {
      return const Left(ServerFailure('Gagal mendapatkan data dari server'));
    } on SocketException {
      return const Left(ConnectionFailure(
          'Gagal menghubungkan ke jaringan, silahkan periksa koneksi internet kamu'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }
}

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository(
    dashboardApi: ref.watch(dashboardApiProvider),
    storage: ref.watch(storageProvider),
  );
});
