import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';

enum AddressType {
  home,
  work,
  partner,
  gym,
  parent,
  cafe,
  park,
  other,
}

extension AddressTypeX on AddressType {
  String name(BuildContext context) {
    switch (this) {
      case AddressType.home:
        return 'Home';
      case AddressType.work:
        return 'Work';
      case AddressType.partner:
        return 'Partner';
      case AddressType.gym:
        return 'Gym';
      case AddressType.parent:
        return 'Parent\'s place';
      case AddressType.cafe:
        return 'Cafe';
      case AddressType.park:
        return 'Park';
      case AddressType.other:
        return 'Other';
    }
  }

  IconData get icon {
    switch (this) {
      case AddressType.home:
        return Ionicons.home;
      case AddressType.work:
        return Ionicons.business;
      case AddressType.partner:
        return Ionicons.heart;
      case AddressType.gym:
        return Ionicons.fitness;
      case AddressType.parent:
        return Ionicons.people;
      case AddressType.cafe:
        return Ionicons.cafe;
      case AddressType.park:
        return Ionicons.leaf;
      case AddressType.other:
        return Ionicons.ellipsis_horizontal_circle;
    }
  }
}

extension AddressTypeIcon on String {
  IconData getIcon() {
    switch (this) {
      case 'dashboard':
        return Ionicons.home;
      case 'work':
        return Ionicons.business;
      case 'partner':
        return Ionicons.heart;
      case 'gym':
        return Ionicons.fitness;
      case 'parent':
        return Ionicons.people;
      case 'cafe':
        return Ionicons.cafe;
      case 'park':
        return Ionicons.leaf;
      case 'other':
        return Ionicons.ellipsis_horizontal_circle;
      default:
        return Ionicons.ellipsis_horizontal_circle;
    }
  }
}

extension StringToAddress on String {
  // Convert a String to address type enum

  AddressType toAddressType() {
    switch (toLowerCase()) {
      case 'dashboard':
        return AddressType.home;
      case 'work':
        return AddressType.work;
      case 'partner':
        return AddressType.partner;
      case 'gym':
        return AddressType.gym;
      case 'parent':
        return AddressType.parent;
      case 'cafe':
        return AddressType.cafe;
      case 'park':
        return AddressType.park;
      case 'other':
        return AddressType.other;
      default:
        return AddressType.other;
    }
  }
}
