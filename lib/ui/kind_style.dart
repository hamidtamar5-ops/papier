import 'package:flutter/material.dart';

import '../domain/models.dart';

IconData iconOf(DocumentKind kind) {
  return switch (kind) {
    DocumentKind.cni => Icons.badge_outlined,
    DocumentKind.passeport => Icons.flight_takeoff_outlined,
    DocumentKind.permis => Icons.directions_car_outlined,
    DocumentKind.carteVitale => Icons.health_and_safety_outlined,
    DocumentKind.carteGrise => Icons.article_outlined,
    DocumentKind.controleTechnique => Icons.car_repair_outlined,
    DocumentKind.assuranceAuto => Icons.verified_user_outlined,
    DocumentKind.personnalise => Icons.folder_outlined,
  };
}
