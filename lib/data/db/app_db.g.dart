// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class NotificationEntries extends Table
    with TableInfo<NotificationEntries, NotificationEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  NotificationEntries(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _postedAtMeta = const VerificationMeta(
    'postedAt',
  );
  late final GeneratedColumn<int> postedAt = GeneratedColumn<int>(
    'posted_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _packageNameMeta = const VerificationMeta(
    'packageName',
  );
  late final GeneratedColumn<String> packageName = GeneratedColumn<String>(
    'package_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _appLabelMeta = const VerificationMeta(
    'appLabel',
  );
  late final GeneratedColumn<String> appLabel = GeneratedColumn<String>(
    'app_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _channelIdMeta = const VerificationMeta(
    'channelId',
  );
  late final GeneratedColumn<String> channelId = GeneratedColumn<String>(
    'channel_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _assignedCategoryMeta = const VerificationMeta(
    'assignedCategory',
  );
  late final GeneratedColumn<String> assignedCategory = GeneratedColumn<String>(
    'assigned_category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _isImportantMeta = const VerificationMeta(
    'isImportant',
  );
  late final GeneratedColumn<bool> isImportant = GeneratedColumn<bool>(
    'is_important',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT FALSE',
    defaultValue: const CustomExpression('FALSE'),
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT FALSE',
    defaultValue: const CustomExpression('FALSE'),
  );
  static const VerificationMeta _hashMeta = const VerificationMeta('hash');
  late final GeneratedColumn<String> hash = GeneratedColumn<String>(
    'hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    postedAt,
    packageName,
    appLabel,
    title,
    content,
    channelId,
    category,
    assignedCategory,
    isImportant,
    isRead,
    hash,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('posted_at')) {
      context.handle(
        _postedAtMeta,
        postedAt.isAcceptableOrUnknown(data['posted_at']!, _postedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_postedAtMeta);
    }
    if (data.containsKey('package_name')) {
      context.handle(
        _packageNameMeta,
        packageName.isAcceptableOrUnknown(
          data['package_name']!,
          _packageNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packageNameMeta);
    }
    if (data.containsKey('app_label')) {
      context.handle(
        _appLabelMeta,
        appLabel.isAcceptableOrUnknown(data['app_label']!, _appLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_appLabelMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('channel_id')) {
      context.handle(
        _channelIdMeta,
        channelId.isAcceptableOrUnknown(data['channel_id']!, _channelIdMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('assigned_category')) {
      context.handle(
        _assignedCategoryMeta,
        assignedCategory.isAcceptableOrUnknown(
          data['assigned_category']!,
          _assignedCategoryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_assignedCategoryMeta);
    }
    if (data.containsKey('is_important')) {
      context.handle(
        _isImportantMeta,
        isImportant.isAcceptableOrUnknown(
          data['is_important']!,
          _isImportantMeta,
        ),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('hash')) {
      context.handle(
        _hashMeta,
        hash.isAcceptableOrUnknown(data['hash']!, _hashMeta),
      );
    } else if (isInserting) {
      context.missing(_hashMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      postedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}posted_at'],
      )!,
      packageName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_name'],
      )!,
      appLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_label'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      channelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}channel_id'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      assignedCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assigned_category'],
      )!,
      isImportant: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_important'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      hash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hash'],
      )!,
    );
  }

  @override
  NotificationEntries createAlias(String alias) {
    return NotificationEntries(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class NotificationEntry extends DataClass
    implements Insertable<NotificationEntry> {
  final int id;
  final int postedAt;
  final String packageName;
  final String appLabel;
  final String title;
  final String? content;
  final String? channelId;
  final String? category;
  final String assignedCategory;
  final bool isImportant;
  final bool isRead;
  final String hash;
  const NotificationEntry({
    required this.id,
    required this.postedAt,
    required this.packageName,
    required this.appLabel,
    required this.title,
    this.content,
    this.channelId,
    this.category,
    required this.assignedCategory,
    required this.isImportant,
    required this.isRead,
    required this.hash,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['posted_at'] = Variable<int>(postedAt);
    map['package_name'] = Variable<String>(packageName);
    map['app_label'] = Variable<String>(appLabel);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || channelId != null) {
      map['channel_id'] = Variable<String>(channelId);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['assigned_category'] = Variable<String>(assignedCategory);
    map['is_important'] = Variable<bool>(isImportant);
    map['is_read'] = Variable<bool>(isRead);
    map['hash'] = Variable<String>(hash);
    return map;
  }

  NotificationEntriesCompanion toCompanion(bool nullToAbsent) {
    return NotificationEntriesCompanion(
      id: Value(id),
      postedAt: Value(postedAt),
      packageName: Value(packageName),
      appLabel: Value(appLabel),
      title: Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      channelId: channelId == null && nullToAbsent
          ? const Value.absent()
          : Value(channelId),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      assignedCategory: Value(assignedCategory),
      isImportant: Value(isImportant),
      isRead: Value(isRead),
      hash: Value(hash),
    );
  }

  factory NotificationEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationEntry(
      id: serializer.fromJson<int>(json['id']),
      postedAt: serializer.fromJson<int>(json['posted_at']),
      packageName: serializer.fromJson<String>(json['package_name']),
      appLabel: serializer.fromJson<String>(json['app_label']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String?>(json['content']),
      channelId: serializer.fromJson<String?>(json['channel_id']),
      category: serializer.fromJson<String?>(json['category']),
      assignedCategory: serializer.fromJson<String>(json['assigned_category']),
      isImportant: serializer.fromJson<bool>(json['is_important']),
      isRead: serializer.fromJson<bool>(json['is_read']),
      hash: serializer.fromJson<String>(json['hash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'posted_at': serializer.toJson<int>(postedAt),
      'package_name': serializer.toJson<String>(packageName),
      'app_label': serializer.toJson<String>(appLabel),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String?>(content),
      'channel_id': serializer.toJson<String?>(channelId),
      'category': serializer.toJson<String?>(category),
      'assigned_category': serializer.toJson<String>(assignedCategory),
      'is_important': serializer.toJson<bool>(isImportant),
      'is_read': serializer.toJson<bool>(isRead),
      'hash': serializer.toJson<String>(hash),
    };
  }

  NotificationEntry copyWith({
    int? id,
    int? postedAt,
    String? packageName,
    String? appLabel,
    String? title,
    Value<String?> content = const Value.absent(),
    Value<String?> channelId = const Value.absent(),
    Value<String?> category = const Value.absent(),
    String? assignedCategory,
    bool? isImportant,
    bool? isRead,
    String? hash,
  }) => NotificationEntry(
    id: id ?? this.id,
    postedAt: postedAt ?? this.postedAt,
    packageName: packageName ?? this.packageName,
    appLabel: appLabel ?? this.appLabel,
    title: title ?? this.title,
    content: content.present ? content.value : this.content,
    channelId: channelId.present ? channelId.value : this.channelId,
    category: category.present ? category.value : this.category,
    assignedCategory: assignedCategory ?? this.assignedCategory,
    isImportant: isImportant ?? this.isImportant,
    isRead: isRead ?? this.isRead,
    hash: hash ?? this.hash,
  );
  NotificationEntry copyWithCompanion(NotificationEntriesCompanion data) {
    return NotificationEntry(
      id: data.id.present ? data.id.value : this.id,
      postedAt: data.postedAt.present ? data.postedAt.value : this.postedAt,
      packageName: data.packageName.present
          ? data.packageName.value
          : this.packageName,
      appLabel: data.appLabel.present ? data.appLabel.value : this.appLabel,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      channelId: data.channelId.present ? data.channelId.value : this.channelId,
      category: data.category.present ? data.category.value : this.category,
      assignedCategory: data.assignedCategory.present
          ? data.assignedCategory.value
          : this.assignedCategory,
      isImportant: data.isImportant.present
          ? data.isImportant.value
          : this.isImportant,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      hash: data.hash.present ? data.hash.value : this.hash,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationEntry(')
          ..write('id: $id, ')
          ..write('postedAt: $postedAt, ')
          ..write('packageName: $packageName, ')
          ..write('appLabel: $appLabel, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('channelId: $channelId, ')
          ..write('category: $category, ')
          ..write('assignedCategory: $assignedCategory, ')
          ..write('isImportant: $isImportant, ')
          ..write('isRead: $isRead, ')
          ..write('hash: $hash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    postedAt,
    packageName,
    appLabel,
    title,
    content,
    channelId,
    category,
    assignedCategory,
    isImportant,
    isRead,
    hash,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationEntry &&
          other.id == this.id &&
          other.postedAt == this.postedAt &&
          other.packageName == this.packageName &&
          other.appLabel == this.appLabel &&
          other.title == this.title &&
          other.content == this.content &&
          other.channelId == this.channelId &&
          other.category == this.category &&
          other.assignedCategory == this.assignedCategory &&
          other.isImportant == this.isImportant &&
          other.isRead == this.isRead &&
          other.hash == this.hash);
}

class NotificationEntriesCompanion extends UpdateCompanion<NotificationEntry> {
  final Value<int> id;
  final Value<int> postedAt;
  final Value<String> packageName;
  final Value<String> appLabel;
  final Value<String> title;
  final Value<String?> content;
  final Value<String?> channelId;
  final Value<String?> category;
  final Value<String> assignedCategory;
  final Value<bool> isImportant;
  final Value<bool> isRead;
  final Value<String> hash;
  const NotificationEntriesCompanion({
    this.id = const Value.absent(),
    this.postedAt = const Value.absent(),
    this.packageName = const Value.absent(),
    this.appLabel = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.channelId = const Value.absent(),
    this.category = const Value.absent(),
    this.assignedCategory = const Value.absent(),
    this.isImportant = const Value.absent(),
    this.isRead = const Value.absent(),
    this.hash = const Value.absent(),
  });
  NotificationEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int postedAt,
    required String packageName,
    required String appLabel,
    required String title,
    this.content = const Value.absent(),
    this.channelId = const Value.absent(),
    this.category = const Value.absent(),
    required String assignedCategory,
    this.isImportant = const Value.absent(),
    this.isRead = const Value.absent(),
    required String hash,
  }) : postedAt = Value(postedAt),
       packageName = Value(packageName),
       appLabel = Value(appLabel),
       title = Value(title),
       assignedCategory = Value(assignedCategory),
       hash = Value(hash);
  static Insertable<NotificationEntry> custom({
    Expression<int>? id,
    Expression<int>? postedAt,
    Expression<String>? packageName,
    Expression<String>? appLabel,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? channelId,
    Expression<String>? category,
    Expression<String>? assignedCategory,
    Expression<bool>? isImportant,
    Expression<bool>? isRead,
    Expression<String>? hash,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (postedAt != null) 'posted_at': postedAt,
      if (packageName != null) 'package_name': packageName,
      if (appLabel != null) 'app_label': appLabel,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (channelId != null) 'channel_id': channelId,
      if (category != null) 'category': category,
      if (assignedCategory != null) 'assigned_category': assignedCategory,
      if (isImportant != null) 'is_important': isImportant,
      if (isRead != null) 'is_read': isRead,
      if (hash != null) 'hash': hash,
    });
  }

  NotificationEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? postedAt,
    Value<String>? packageName,
    Value<String>? appLabel,
    Value<String>? title,
    Value<String?>? content,
    Value<String?>? channelId,
    Value<String?>? category,
    Value<String>? assignedCategory,
    Value<bool>? isImportant,
    Value<bool>? isRead,
    Value<String>? hash,
  }) {
    return NotificationEntriesCompanion(
      id: id ?? this.id,
      postedAt: postedAt ?? this.postedAt,
      packageName: packageName ?? this.packageName,
      appLabel: appLabel ?? this.appLabel,
      title: title ?? this.title,
      content: content ?? this.content,
      channelId: channelId ?? this.channelId,
      category: category ?? this.category,
      assignedCategory: assignedCategory ?? this.assignedCategory,
      isImportant: isImportant ?? this.isImportant,
      isRead: isRead ?? this.isRead,
      hash: hash ?? this.hash,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (postedAt.present) {
      map['posted_at'] = Variable<int>(postedAt.value);
    }
    if (packageName.present) {
      map['package_name'] = Variable<String>(packageName.value);
    }
    if (appLabel.present) {
      map['app_label'] = Variable<String>(appLabel.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (channelId.present) {
      map['channel_id'] = Variable<String>(channelId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (assignedCategory.present) {
      map['assigned_category'] = Variable<String>(assignedCategory.value);
    }
    if (isImportant.present) {
      map['is_important'] = Variable<bool>(isImportant.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (hash.present) {
      map['hash'] = Variable<String>(hash.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationEntriesCompanion(')
          ..write('id: $id, ')
          ..write('postedAt: $postedAt, ')
          ..write('packageName: $packageName, ')
          ..write('appLabel: $appLabel, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('channelId: $channelId, ')
          ..write('category: $category, ')
          ..write('assignedCategory: $assignedCategory, ')
          ..write('isImportant: $isImportant, ')
          ..write('isRead: $isRead, ')
          ..write('hash: $hash')
          ..write(')'))
        .toString();
  }
}

class StudyItems extends Table with TableInfo<StudyItems, StudyItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  StudyItems(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _sourceNotificationIdMeta =
      const VerificationMeta('sourceNotificationId');
  late final GeneratedColumn<int> sourceNotificationId = GeneratedColumn<int>(
    'source_notification_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES notification_entries(id)',
  );
  static const VerificationMeta _langMeta = const VerificationMeta('lang');
  late final GeneratedColumn<String> lang = GeneratedColumn<String>(
    'lang',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _phraseMeta = const VerificationMeta('phrase');
  late final GeneratedColumn<String> phrase = GeneratedColumn<String>(
    'phrase',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _translationMeta = const VerificationMeta(
    'translation',
  );
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
    'translation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _reviewLevelMeta = const VerificationMeta(
    'reviewLevel',
  );
  late final GeneratedColumn<int> reviewLevel = GeneratedColumn<int>(
    'review_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceNotificationId,
    lang,
    phrase,
    translation,
    reviewLevel,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_notification_id')) {
      context.handle(
        _sourceNotificationIdMeta,
        sourceNotificationId.isAcceptableOrUnknown(
          data['source_notification_id']!,
          _sourceNotificationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceNotificationIdMeta);
    }
    if (data.containsKey('lang')) {
      context.handle(
        _langMeta,
        lang.isAcceptableOrUnknown(data['lang']!, _langMeta),
      );
    } else if (isInserting) {
      context.missing(_langMeta);
    }
    if (data.containsKey('phrase')) {
      context.handle(
        _phraseMeta,
        phrase.isAcceptableOrUnknown(data['phrase']!, _phraseMeta),
      );
    } else if (isInserting) {
      context.missing(_phraseMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationMeta);
    }
    if (data.containsKey('review_level')) {
      context.handle(
        _reviewLevelMeta,
        reviewLevel.isAcceptableOrUnknown(
          data['review_level']!,
          _reviewLevelMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudyItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sourceNotificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_notification_id'],
      )!,
      lang: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lang'],
      )!,
      phrase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phrase'],
      )!,
      translation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation'],
      )!,
      reviewLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_level'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  StudyItems createAlias(String alias) {
    return StudyItems(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class StudyItem extends DataClass implements Insertable<StudyItem> {
  final int id;
  final int sourceNotificationId;
  final String lang;
  final String phrase;
  final String translation;
  final int reviewLevel;
  final int createdAt;
  const StudyItem({
    required this.id,
    required this.sourceNotificationId,
    required this.lang,
    required this.phrase,
    required this.translation,
    required this.reviewLevel,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_notification_id'] = Variable<int>(sourceNotificationId);
    map['lang'] = Variable<String>(lang);
    map['phrase'] = Variable<String>(phrase);
    map['translation'] = Variable<String>(translation);
    map['review_level'] = Variable<int>(reviewLevel);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  StudyItemsCompanion toCompanion(bool nullToAbsent) {
    return StudyItemsCompanion(
      id: Value(id),
      sourceNotificationId: Value(sourceNotificationId),
      lang: Value(lang),
      phrase: Value(phrase),
      translation: Value(translation),
      reviewLevel: Value(reviewLevel),
      createdAt: Value(createdAt),
    );
  }

  factory StudyItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyItem(
      id: serializer.fromJson<int>(json['id']),
      sourceNotificationId: serializer.fromJson<int>(
        json['source_notification_id'],
      ),
      lang: serializer.fromJson<String>(json['lang']),
      phrase: serializer.fromJson<String>(json['phrase']),
      translation: serializer.fromJson<String>(json['translation']),
      reviewLevel: serializer.fromJson<int>(json['review_level']),
      createdAt: serializer.fromJson<int>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'source_notification_id': serializer.toJson<int>(sourceNotificationId),
      'lang': serializer.toJson<String>(lang),
      'phrase': serializer.toJson<String>(phrase),
      'translation': serializer.toJson<String>(translation),
      'review_level': serializer.toJson<int>(reviewLevel),
      'created_at': serializer.toJson<int>(createdAt),
    };
  }

  StudyItem copyWith({
    int? id,
    int? sourceNotificationId,
    String? lang,
    String? phrase,
    String? translation,
    int? reviewLevel,
    int? createdAt,
  }) => StudyItem(
    id: id ?? this.id,
    sourceNotificationId: sourceNotificationId ?? this.sourceNotificationId,
    lang: lang ?? this.lang,
    phrase: phrase ?? this.phrase,
    translation: translation ?? this.translation,
    reviewLevel: reviewLevel ?? this.reviewLevel,
    createdAt: createdAt ?? this.createdAt,
  );
  StudyItem copyWithCompanion(StudyItemsCompanion data) {
    return StudyItem(
      id: data.id.present ? data.id.value : this.id,
      sourceNotificationId: data.sourceNotificationId.present
          ? data.sourceNotificationId.value
          : this.sourceNotificationId,
      lang: data.lang.present ? data.lang.value : this.lang,
      phrase: data.phrase.present ? data.phrase.value : this.phrase,
      translation: data.translation.present
          ? data.translation.value
          : this.translation,
      reviewLevel: data.reviewLevel.present
          ? data.reviewLevel.value
          : this.reviewLevel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyItem(')
          ..write('id: $id, ')
          ..write('sourceNotificationId: $sourceNotificationId, ')
          ..write('lang: $lang, ')
          ..write('phrase: $phrase, ')
          ..write('translation: $translation, ')
          ..write('reviewLevel: $reviewLevel, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceNotificationId,
    lang,
    phrase,
    translation,
    reviewLevel,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyItem &&
          other.id == this.id &&
          other.sourceNotificationId == this.sourceNotificationId &&
          other.lang == this.lang &&
          other.phrase == this.phrase &&
          other.translation == this.translation &&
          other.reviewLevel == this.reviewLevel &&
          other.createdAt == this.createdAt);
}

class StudyItemsCompanion extends UpdateCompanion<StudyItem> {
  final Value<int> id;
  final Value<int> sourceNotificationId;
  final Value<String> lang;
  final Value<String> phrase;
  final Value<String> translation;
  final Value<int> reviewLevel;
  final Value<int> createdAt;
  const StudyItemsCompanion({
    this.id = const Value.absent(),
    this.sourceNotificationId = const Value.absent(),
    this.lang = const Value.absent(),
    this.phrase = const Value.absent(),
    this.translation = const Value.absent(),
    this.reviewLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StudyItemsCompanion.insert({
    this.id = const Value.absent(),
    required int sourceNotificationId,
    required String lang,
    required String phrase,
    required String translation,
    this.reviewLevel = const Value.absent(),
    required int createdAt,
  }) : sourceNotificationId = Value(sourceNotificationId),
       lang = Value(lang),
       phrase = Value(phrase),
       translation = Value(translation),
       createdAt = Value(createdAt);
  static Insertable<StudyItem> custom({
    Expression<int>? id,
    Expression<int>? sourceNotificationId,
    Expression<String>? lang,
    Expression<String>? phrase,
    Expression<String>? translation,
    Expression<int>? reviewLevel,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceNotificationId != null)
        'source_notification_id': sourceNotificationId,
      if (lang != null) 'lang': lang,
      if (phrase != null) 'phrase': phrase,
      if (translation != null) 'translation': translation,
      if (reviewLevel != null) 'review_level': reviewLevel,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StudyItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? sourceNotificationId,
    Value<String>? lang,
    Value<String>? phrase,
    Value<String>? translation,
    Value<int>? reviewLevel,
    Value<int>? createdAt,
  }) {
    return StudyItemsCompanion(
      id: id ?? this.id,
      sourceNotificationId: sourceNotificationId ?? this.sourceNotificationId,
      lang: lang ?? this.lang,
      phrase: phrase ?? this.phrase,
      translation: translation ?? this.translation,
      reviewLevel: reviewLevel ?? this.reviewLevel,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceNotificationId.present) {
      map['source_notification_id'] = Variable<int>(sourceNotificationId.value);
    }
    if (lang.present) {
      map['lang'] = Variable<String>(lang.value);
    }
    if (phrase.present) {
      map['phrase'] = Variable<String>(phrase.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (reviewLevel.present) {
      map['review_level'] = Variable<int>(reviewLevel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyItemsCompanion(')
          ..write('id: $id, ')
          ..write('sourceNotificationId: $sourceNotificationId, ')
          ..write('lang: $lang, ')
          ..write('phrase: $phrase, ')
          ..write('translation: $translation, ')
          ..write('reviewLevel: $reviewLevel, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final NotificationEntries notificationEntries = NotificationEntries(
    this,
  );
  late final StudyItems studyItems = StudyItems(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    notificationEntries,
    studyItems,
  ];
}

typedef $NotificationEntriesCreateCompanionBuilder =
    NotificationEntriesCompanion Function({
      Value<int> id,
      required int postedAt,
      required String packageName,
      required String appLabel,
      required String title,
      Value<String?> content,
      Value<String?> channelId,
      Value<String?> category,
      required String assignedCategory,
      Value<bool> isImportant,
      Value<bool> isRead,
      required String hash,
    });
typedef $NotificationEntriesUpdateCompanionBuilder =
    NotificationEntriesCompanion Function({
      Value<int> id,
      Value<int> postedAt,
      Value<String> packageName,
      Value<String> appLabel,
      Value<String> title,
      Value<String?> content,
      Value<String?> channelId,
      Value<String?> category,
      Value<String> assignedCategory,
      Value<bool> isImportant,
      Value<bool> isRead,
      Value<String> hash,
    });

final class $NotificationEntriesReferences
    extends
        BaseReferences<_$AppDatabase, NotificationEntries, NotificationEntry> {
  $NotificationEntriesReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<StudyItems, List<StudyItem>> _studyItemsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.studyItems,
    aliasName: $_aliasNameGenerator(
      db.notificationEntries.id,
      db.studyItems.sourceNotificationId,
    ),
  );

  $StudyItemsProcessedTableManager get studyItemsRefs {
    final manager = $StudyItemsTableManager($_db, $_db.studyItems).filter(
      (f) => f.sourceNotificationId.id.sqlEquals($_itemColumn<int>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_studyItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $NotificationEntriesFilterComposer
    extends Composer<_$AppDatabase, NotificationEntries> {
  $NotificationEntriesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get postedAt => $composableBuilder(
    column: $table.postedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appLabel => $composableBuilder(
    column: $table.appLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get channelId => $composableBuilder(
    column: $table.channelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assignedCategory => $composableBuilder(
    column: $table.assignedCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isImportant => $composableBuilder(
    column: $table.isImportant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hash => $composableBuilder(
    column: $table.hash,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> studyItemsRefs(
    Expression<bool> Function($StudyItemsFilterComposer f) f,
  ) {
    final $StudyItemsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.sourceNotificationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $StudyItemsFilterComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $NotificationEntriesOrderingComposer
    extends Composer<_$AppDatabase, NotificationEntries> {
  $NotificationEntriesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get postedAt => $composableBuilder(
    column: $table.postedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appLabel => $composableBuilder(
    column: $table.appLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get channelId => $composableBuilder(
    column: $table.channelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assignedCategory => $composableBuilder(
    column: $table.assignedCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isImportant => $composableBuilder(
    column: $table.isImportant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hash => $composableBuilder(
    column: $table.hash,
    builder: (column) => ColumnOrderings(column),
  );
}

class $NotificationEntriesAnnotationComposer
    extends Composer<_$AppDatabase, NotificationEntries> {
  $NotificationEntriesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get postedAt =>
      $composableBuilder(column: $table.postedAt, builder: (column) => column);

  GeneratedColumn<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get appLabel =>
      $composableBuilder(column: $table.appLabel, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get channelId =>
      $composableBuilder(column: $table.channelId, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get assignedCategory => $composableBuilder(
    column: $table.assignedCategory,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isImportant => $composableBuilder(
    column: $table.isImportant,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<String> get hash =>
      $composableBuilder(column: $table.hash, builder: (column) => column);

  Expression<T> studyItemsRefs<T extends Object>(
    Expression<T> Function($StudyItemsAnnotationComposer a) f,
  ) {
    final $StudyItemsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyItems,
      getReferencedColumn: (t) => t.sourceNotificationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $StudyItemsAnnotationComposer(
            $db: $db,
            $table: $db.studyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $NotificationEntriesTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          NotificationEntries,
          NotificationEntry,
          $NotificationEntriesFilterComposer,
          $NotificationEntriesOrderingComposer,
          $NotificationEntriesAnnotationComposer,
          $NotificationEntriesCreateCompanionBuilder,
          $NotificationEntriesUpdateCompanionBuilder,
          (NotificationEntry, $NotificationEntriesReferences),
          NotificationEntry,
          PrefetchHooks Function({bool studyItemsRefs})
        > {
  $NotificationEntriesTableManager(_$AppDatabase db, NotificationEntries table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $NotificationEntriesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $NotificationEntriesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $NotificationEntriesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> postedAt = const Value.absent(),
                Value<String> packageName = const Value.absent(),
                Value<String> appLabel = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<String?> channelId = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String> assignedCategory = const Value.absent(),
                Value<bool> isImportant = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<String> hash = const Value.absent(),
              }) => NotificationEntriesCompanion(
                id: id,
                postedAt: postedAt,
                packageName: packageName,
                appLabel: appLabel,
                title: title,
                content: content,
                channelId: channelId,
                category: category,
                assignedCategory: assignedCategory,
                isImportant: isImportant,
                isRead: isRead,
                hash: hash,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int postedAt,
                required String packageName,
                required String appLabel,
                required String title,
                Value<String?> content = const Value.absent(),
                Value<String?> channelId = const Value.absent(),
                Value<String?> category = const Value.absent(),
                required String assignedCategory,
                Value<bool> isImportant = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                required String hash,
              }) => NotificationEntriesCompanion.insert(
                id: id,
                postedAt: postedAt,
                packageName: packageName,
                appLabel: appLabel,
                title: title,
                content: content,
                channelId: channelId,
                category: category,
                assignedCategory: assignedCategory,
                isImportant: isImportant,
                isRead: isRead,
                hash: hash,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $NotificationEntriesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({studyItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (studyItemsRefs) db.studyItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (studyItemsRefs)
                    await $_getPrefetchedData<
                      NotificationEntry,
                      NotificationEntries,
                      StudyItem
                    >(
                      currentTable: table,
                      referencedTable: $NotificationEntriesReferences
                          ._studyItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $NotificationEntriesReferences(
                            db,
                            table,
                            p0,
                          ).studyItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.sourceNotificationId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $NotificationEntriesProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      NotificationEntries,
      NotificationEntry,
      $NotificationEntriesFilterComposer,
      $NotificationEntriesOrderingComposer,
      $NotificationEntriesAnnotationComposer,
      $NotificationEntriesCreateCompanionBuilder,
      $NotificationEntriesUpdateCompanionBuilder,
      (NotificationEntry, $NotificationEntriesReferences),
      NotificationEntry,
      PrefetchHooks Function({bool studyItemsRefs})
    >;
typedef $StudyItemsCreateCompanionBuilder =
    StudyItemsCompanion Function({
      Value<int> id,
      required int sourceNotificationId,
      required String lang,
      required String phrase,
      required String translation,
      Value<int> reviewLevel,
      required int createdAt,
    });
typedef $StudyItemsUpdateCompanionBuilder =
    StudyItemsCompanion Function({
      Value<int> id,
      Value<int> sourceNotificationId,
      Value<String> lang,
      Value<String> phrase,
      Value<String> translation,
      Value<int> reviewLevel,
      Value<int> createdAt,
    });

final class $StudyItemsReferences
    extends BaseReferences<_$AppDatabase, StudyItems, StudyItem> {
  $StudyItemsReferences(super.$_db, super.$_table, super.$_typedResult);

  static NotificationEntries _sourceNotificationIdTable(_$AppDatabase db) =>
      db.notificationEntries.createAlias(
        $_aliasNameGenerator(
          db.studyItems.sourceNotificationId,
          db.notificationEntries.id,
        ),
      );

  $NotificationEntriesProcessedTableManager get sourceNotificationId {
    final $_column = $_itemColumn<int>('source_notification_id')!;

    final manager = $NotificationEntriesTableManager(
      $_db,
      $_db.notificationEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _sourceNotificationIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $StudyItemsFilterComposer extends Composer<_$AppDatabase, StudyItems> {
  $StudyItemsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lang => $composableBuilder(
    column: $table.lang,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phrase => $composableBuilder(
    column: $table.phrase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewLevel => $composableBuilder(
    column: $table.reviewLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $NotificationEntriesFilterComposer get sourceNotificationId {
    final $NotificationEntriesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceNotificationId,
      referencedTable: $db.notificationEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $NotificationEntriesFilterComposer(
            $db: $db,
            $table: $db.notificationEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $StudyItemsOrderingComposer extends Composer<_$AppDatabase, StudyItems> {
  $StudyItemsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lang => $composableBuilder(
    column: $table.lang,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phrase => $composableBuilder(
    column: $table.phrase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewLevel => $composableBuilder(
    column: $table.reviewLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $NotificationEntriesOrderingComposer get sourceNotificationId {
    final $NotificationEntriesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceNotificationId,
      referencedTable: $db.notificationEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $NotificationEntriesOrderingComposer(
            $db: $db,
            $table: $db.notificationEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $StudyItemsAnnotationComposer
    extends Composer<_$AppDatabase, StudyItems> {
  $StudyItemsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lang =>
      $composableBuilder(column: $table.lang, builder: (column) => column);

  GeneratedColumn<String> get phrase =>
      $composableBuilder(column: $table.phrase, builder: (column) => column);

  GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewLevel => $composableBuilder(
    column: $table.reviewLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $NotificationEntriesAnnotationComposer get sourceNotificationId {
    final $NotificationEntriesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceNotificationId,
      referencedTable: $db.notificationEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $NotificationEntriesAnnotationComposer(
            $db: $db,
            $table: $db.notificationEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $StudyItemsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          StudyItems,
          StudyItem,
          $StudyItemsFilterComposer,
          $StudyItemsOrderingComposer,
          $StudyItemsAnnotationComposer,
          $StudyItemsCreateCompanionBuilder,
          $StudyItemsUpdateCompanionBuilder,
          (StudyItem, $StudyItemsReferences),
          StudyItem,
          PrefetchHooks Function({bool sourceNotificationId})
        > {
  $StudyItemsTableManager(_$AppDatabase db, StudyItems table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $StudyItemsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $StudyItemsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $StudyItemsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sourceNotificationId = const Value.absent(),
                Value<String> lang = const Value.absent(),
                Value<String> phrase = const Value.absent(),
                Value<String> translation = const Value.absent(),
                Value<int> reviewLevel = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => StudyItemsCompanion(
                id: id,
                sourceNotificationId: sourceNotificationId,
                lang: lang,
                phrase: phrase,
                translation: translation,
                reviewLevel: reviewLevel,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sourceNotificationId,
                required String lang,
                required String phrase,
                required String translation,
                Value<int> reviewLevel = const Value.absent(),
                required int createdAt,
              }) => StudyItemsCompanion.insert(
                id: id,
                sourceNotificationId: sourceNotificationId,
                lang: lang,
                phrase: phrase,
                translation: translation,
                reviewLevel: reviewLevel,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $StudyItemsReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({sourceNotificationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sourceNotificationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sourceNotificationId,
                                referencedTable: $StudyItemsReferences
                                    ._sourceNotificationIdTable(db),
                                referencedColumn: $StudyItemsReferences
                                    ._sourceNotificationIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $StudyItemsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      StudyItems,
      StudyItem,
      $StudyItemsFilterComposer,
      $StudyItemsOrderingComposer,
      $StudyItemsAnnotationComposer,
      $StudyItemsCreateCompanionBuilder,
      $StudyItemsUpdateCompanionBuilder,
      (StudyItem, $StudyItemsReferences),
      StudyItem,
      PrefetchHooks Function({bool sourceNotificationId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $NotificationEntriesTableManager get notificationEntries =>
      $NotificationEntriesTableManager(_db, _db.notificationEntries);
  $StudyItemsTableManager get studyItems =>
      $StudyItemsTableManager(_db, _db.studyItems);
}
