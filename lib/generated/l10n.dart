// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `اللغة العربية`
  String get otherlanguage {
    return Intl.message(
      'اللغة العربية',
      name: 'otherlanguage',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get onboarding1Title {
    return Intl.message(
      'Welcome',
      name: 'onboarding1Title',
      desc: '',
      args: [],
    );
  }

  /// `Discover a smarter way to stay organized and connected.`
  String get onboarding1Description {
    return Intl.message(
      'Discover a smarter way to stay organized and connected.',
      name: 'onboarding1Description',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get onboarding2Title {
    return Intl.message(
      'Get Started',
      name: 'onboarding2Title',
      desc: '',
      args: [],
    );
  }

  /// `Create your profile and set your preferences in just a few taps.`
  String get onboarding2Description {
    return Intl.message(
      'Create your profile and set your preferences in just a few taps.',
      name: 'onboarding2Description',
      desc: '',
      args: [],
    );
  }

  /// `Stay Organized`
  String get onboarding3Title {
    return Intl.message(
      'Stay Organized',
      name: 'onboarding3Title',
      desc: '',
      args: [],
    );
  }

  /// `Keep all your tasks and reminders in one convenient place.`
  String get onboarding3Description {
    return Intl.message(
      'Keep all your tasks and reminders in one convenient place.',
      name: 'onboarding3Description',
      desc: '',
      args: [],
    );
  }

  /// `Connect & Share`
  String get onboarding4Title {
    return Intl.message(
      'Connect & Share',
      name: 'onboarding4Title',
      desc: '',
      args: [],
    );
  }

  /// `Share updates and collaborate with friends and colleagues.`
  String get onboarding4Description {
    return Intl.message(
      'Share updates and collaborate with friends and colleagues.',
      name: 'onboarding4Description',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get onboarding5Title {
    return Intl.message(
      'Notifications',
      name: 'onboarding5Title',
      desc: '',
      args: [],
    );
  }

  /// `Enable notifications to never miss important updates.`
  String get onboarding5Description {
    return Intl.message(
      'Enable notifications to never miss important updates.',
      name: 'onboarding5Description',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Challange`
  String get app_name {
    return Intl.message('Challange', name: 'app_name', desc: '', args: []);
  }

  /// `Your shop on your pocket`
  String get splash_subtitle {
    return Intl.message(
      'Your shop on your pocket',
      name: 'splash_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please try again.`
  String get unexpectedError {
    return Intl.message(
      'An unexpected error occurred. Please try again.',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Welcome back`
  String get welcome_back {
    return Intl.message(
      'Welcome back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Enter your email`
  String get email_hint {
    return Intl.message(
      'Enter your email',
      name: 'email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `**********`
  String get password_hint {
    return Intl.message(
      '**********',
      name: 'password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Add User`
  String get add_user {
    return Intl.message('Add User', name: 'add_user', desc: '', args: []);
  }

  /// `View Users`
  String get view_users {
    return Intl.message('View Users', name: 'view_users', desc: '', args: []);
  }

  /// `Add Product`
  String get add_product {
    return Intl.message('Add Product', name: 'add_product', desc: '', args: []);
  }

  /// `View Products`
  String get view_products {
    return Intl.message(
      'View Products',
      name: 'view_products',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message('Dark Mode', name: 'dark_mode', desc: '', args: []);
  }

  /// `Add New User`
  String get addNewUser {
    return Intl.message('Add New User', name: 'addNewUser', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Enter user name`
  String get enterUserName {
    return Intl.message(
      'Enter user name',
      name: 'enterUserName',
      desc: '',
      args: [],
    );
  }

  /// `Enter email address`
  String get enterEmail {
    return Intl.message(
      'Enter email address',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enterPassword {
    return Intl.message(
      'Enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `User Type`
  String get userType {
    return Intl.message('User Type', name: 'userType', desc: '', args: []);
  }

  /// `Select user type`
  String get selectUserType {
    return Intl.message(
      'Select user type',
      name: 'selectUserType',
      desc: '',
      args: [],
    );
  }

  /// `Add User`
  String get addUser {
    return Intl.message('Add User', name: 'addUser', desc: '', args: []);
  }

  /// `Name is required`
  String get errorNameRequired {
    return Intl.message(
      'Name is required',
      name: 'errorNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get errorEmailRequired {
    return Intl.message(
      'Email is required',
      name: 'errorEmailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get errorInvalidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'errorInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get errorPasswordRequired {
    return Intl.message(
      'Password is required',
      name: 'errorPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get errorPasswordShort {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'errorPasswordShort',
      desc: '',
      args: [],
    );
  }

  /// `Please select a user type`
  String get errorUserTypeRequired {
    return Intl.message(
      'Please select a user type',
      name: 'errorUserTypeRequired',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get admin {
    return Intl.message('Admin', name: 'admin', desc: '', args: []);
  }

  /// `Employee`
  String get employee {
    return Intl.message('Employee', name: 'employee', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Log out`
  String get logout {
    return Intl.message('Log out', name: 'logout', desc: '', args: []);
  }

  /// `No users found`
  String get no_users_found {
    return Intl.message(
      'No users found',
      name: 'no_users_found',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Delete User`
  String get delete_user_title {
    return Intl.message(
      'Delete User',
      name: 'delete_user_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you want to confirm delete this user?`
  String get delete_user_desc {
    return Intl.message(
      'Are you want to confirm delete this user?',
      name: 'delete_user_desc',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message('cancel', name: 'cancel', desc: '', args: []);
  }

  /// `You can't delete your account.`
  String get can_not_delete_yourslef {
    return Intl.message(
      'You can\'t delete your account.',
      name: 'can_not_delete_yourslef',
      desc: '',
      args: [],
    );
  }

  /// `Add New Product`
  String get addNewProduct {
    return Intl.message(
      'Add New Product',
      name: 'addNewProduct',
      desc: '',
      args: [],
    );
  }

  /// `Select Image Source`
  String get selectImageSource {
    return Intl.message(
      'Select Image Source',
      name: 'selectImageSource',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Product Image *`
  String get productImage {
    return Intl.message(
      'Product Image *',
      name: 'productImage',
      desc: '',
      args: [],
    );
  }

  /// `Tap to select image`
  String get tapToSelectImage {
    return Intl.message(
      'Tap to select image',
      name: 'tapToSelectImage',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get productName {
    return Intl.message(
      'Product Name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Enter product name`
  String get enterProductName {
    return Intl.message(
      'Enter product name',
      name: 'enterProductName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Enter product description`
  String get enterDescription {
    return Intl.message(
      'Enter product description',
      name: 'enterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Enter price`
  String get enterPrice {
    return Intl.message('Enter price', name: 'enterPrice', desc: '', args: []);
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Enter quantity`
  String get enterQuantity {
    return Intl.message(
      'Enter quantity',
      name: 'enterQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get addProduct {
    return Intl.message('Add Product', name: 'addProduct', desc: '', args: []);
  }

  /// `Product name is required`
  String get productNameRequired {
    return Intl.message(
      'Product name is required',
      name: 'productNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Description is required`
  String get descriptionRequired {
    return Intl.message(
      'Description is required',
      name: 'descriptionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Price is required`
  String get priceRequired {
    return Intl.message(
      'Price is required',
      name: 'priceRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get enterValidNumber {
    return Intl.message(
      'Please enter a valid number',
      name: 'enterValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Price must be greater than 0`
  String get priceGreaterThanZero {
    return Intl.message(
      'Price must be greater than 0',
      name: 'priceGreaterThanZero',
      desc: '',
      args: [],
    );
  }

  /// `Quantity is required`
  String get quantityRequired {
    return Intl.message(
      'Quantity is required',
      name: 'quantityRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid integer`
  String get enterValidInteger {
    return Intl.message(
      'Please enter a valid integer',
      name: 'enterValidInteger',
      desc: '',
      args: [],
    );
  }

  /// `Quantity must be greater than 0`
  String get quantityGreaterThanZero {
    return Intl.message(
      'Quantity must be greater than 0',
      name: 'quantityGreaterThanZero',
      desc: '',
      args: [],
    );
  }

  /// `Please select a product image`
  String get selectProductImage {
    return Intl.message(
      'Please select a product image',
      name: 'selectProductImage',
      desc: '',
      args: [],
    );
  }

  /// `Error picking image`
  String get errorPickingImage {
    return Intl.message(
      'Error picking image',
      name: 'errorPickingImage',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Created By: `
  String get created_by_suffix {
    return Intl.message(
      'Created By: ',
      name: 'created_by_suffix',
      desc: '',
      args: [],
    );
  }

  /// `Qty: `
  String get quantity_suffix {
    return Intl.message('Qty: ', name: 'quantity_suffix', desc: '', args: []);
  }

  /// `Update Product`
  String get updateProduct {
    return Intl.message(
      'Update Product',
      name: 'updateProduct',
      desc: '',
      args: [],
    );
  }

  /// `Image Loading Failed`
  String get imageLoadFailed {
    return Intl.message(
      'Image Loading Failed',
      name: 'imageLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `No products available`
  String get no_products_exist {
    return Intl.message(
      'No products available',
      name: 'no_products_exist',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
