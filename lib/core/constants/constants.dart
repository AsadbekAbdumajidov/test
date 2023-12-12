// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const BASE_URL = 'https://crudcrud.com/api/';


enum Status { LOADING, UNKNOWN, SUCCESS, ERROR, OTHER,  OTHER_LOADING}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();


 // flutter pub run build_runner build --delete-conflicting-outputs
 // flutter pub run intl_utils:generate

