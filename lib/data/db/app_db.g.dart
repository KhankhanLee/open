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

class CustomCategories extends Table
    with TableInfo<CustomCategories, CustomCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CustomCategories(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _iconCodePointMeta = const VerificationMeta(
    'iconCodePoint',
  );
  late final GeneratedColumn<int> iconCodePoint = GeneratedColumn<int>(
    'icon_code_point',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
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
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT TRUE',
    defaultValue: const CustomExpression('TRUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    iconCodePoint,
    colorValue,
    createdAt,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_code_point')) {
      context.handle(
        _iconCodePointMeta,
        iconCodePoint.isAcceptableOrUnknown(
          data['icon_code_point']!,
          _iconCodePointMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_iconCodePointMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      iconCodePoint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}icon_code_point'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  CustomCategories createAlias(String alias) {
    return CustomCategories(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CustomCategory extends DataClass implements Insertable<CustomCategory> {
  final int id;
  final String name;
  final int iconCodePoint;
  final int colorValue;
  final int createdAt;
  final bool isActive;
  const CustomCategory({
    required this.id,
    required this.name,
    required this.iconCodePoint,
    required this.colorValue,
    required this.createdAt,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon_code_point'] = Variable<int>(iconCodePoint);
    map['color_value'] = Variable<int>(colorValue);
    map['created_at'] = Variable<int>(createdAt);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  CustomCategoriesCompanion toCompanion(bool nullToAbsent) {
    return CustomCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      iconCodePoint: Value(iconCodePoint),
      colorValue: Value(colorValue),
      createdAt: Value(createdAt),
      isActive: Value(isActive),
    );
  }

  factory CustomCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomCategory(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconCodePoint: serializer.fromJson<int>(json['icon_code_point']),
      colorValue: serializer.fromJson<int>(json['color_value']),
      createdAt: serializer.fromJson<int>(json['created_at']),
      isActive: serializer.fromJson<bool>(json['is_active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'icon_code_point': serializer.toJson<int>(iconCodePoint),
      'color_value': serializer.toJson<int>(colorValue),
      'created_at': serializer.toJson<int>(createdAt),
      'is_active': serializer.toJson<bool>(isActive),
    };
  }

  CustomCategory copyWith({
    int? id,
    String? name,
    int? iconCodePoint,
    int? colorValue,
    int? createdAt,
    bool? isActive,
  }) => CustomCategory(
    id: id ?? this.id,
    name: name ?? this.name,
    iconCodePoint: iconCodePoint ?? this.iconCodePoint,
    colorValue: colorValue ?? this.colorValue,
    createdAt: createdAt ?? this.createdAt,
    isActive: isActive ?? this.isActive,
  );
  CustomCategory copyWithCompanion(CustomCategoriesCompanion data) {
    return CustomCategory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      iconCodePoint: data.iconCodePoint.present
          ? data.iconCodePoint.value
          : this.iconCodePoint,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('colorValue: $colorValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, iconCodePoint, colorValue, createdAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconCodePoint == this.iconCodePoint &&
          other.colorValue == this.colorValue &&
          other.createdAt == this.createdAt &&
          other.isActive == this.isActive);
}

class CustomCategoriesCompanion extends UpdateCompanion<CustomCategory> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> iconCodePoint;
  final Value<int> colorValue;
  final Value<int> createdAt;
  final Value<bool> isActive;
  const CustomCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconCodePoint = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  CustomCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int iconCodePoint,
    required int colorValue,
    required int createdAt,
    this.isActive = const Value.absent(),
  }) : name = Value(name),
       iconCodePoint = Value(iconCodePoint),
       colorValue = Value(colorValue),
       createdAt = Value(createdAt);
  static Insertable<CustomCategory> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? iconCodePoint,
    Expression<int>? colorValue,
    Expression<int>? createdAt,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconCodePoint != null) 'icon_code_point': iconCodePoint,
      if (colorValue != null) 'color_value': colorValue,
      if (createdAt != null) 'created_at': createdAt,
      if (isActive != null) 'is_active': isActive,
    });
  }

  CustomCategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? iconCodePoint,
    Value<int>? colorValue,
    Value<int>? createdAt,
    Value<bool>? isActive,
  }) {
    return CustomCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      colorValue: colorValue ?? this.colorValue,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconCodePoint.present) {
      map['icon_code_point'] = Variable<int>(iconCodePoint.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('colorValue: $colorValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class CategoryAppMappings extends Table
    with TableInfo<CategoryAppMappings, CategoryAppMapping> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CategoryAppMappings(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES custom_categories(id)ON DELETE CASCADE',
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
    categoryId,
    packageName,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_app_mappings';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryAppMapping> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
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
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {categoryId, packageName},
  ];
  @override
  CategoryAppMapping map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryAppMapping(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      packageName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  CategoryAppMappings createAlias(String alias) {
    return CategoryAppMappings(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'UNIQUE(category_id, package_name)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class CategoryAppMapping extends DataClass
    implements Insertable<CategoryAppMapping> {
  final int id;
  final int categoryId;
  final String packageName;
  final int createdAt;
  const CategoryAppMapping({
    required this.id,
    required this.categoryId,
    required this.packageName,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['package_name'] = Variable<String>(packageName);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CategoryAppMappingsCompanion toCompanion(bool nullToAbsent) {
    return CategoryAppMappingsCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      packageName: Value(packageName),
      createdAt: Value(createdAt),
    );
  }

  factory CategoryAppMapping.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryAppMapping(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['category_id']),
      packageName: serializer.fromJson<String>(json['package_name']),
      createdAt: serializer.fromJson<int>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category_id': serializer.toJson<int>(categoryId),
      'package_name': serializer.toJson<String>(packageName),
      'created_at': serializer.toJson<int>(createdAt),
    };
  }

  CategoryAppMapping copyWith({
    int? id,
    int? categoryId,
    String? packageName,
    int? createdAt,
  }) => CategoryAppMapping(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    packageName: packageName ?? this.packageName,
    createdAt: createdAt ?? this.createdAt,
  );
  CategoryAppMapping copyWithCompanion(CategoryAppMappingsCompanion data) {
    return CategoryAppMapping(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      packageName: data.packageName.present
          ? data.packageName.value
          : this.packageName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryAppMapping(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('packageName: $packageName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, categoryId, packageName, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryAppMapping &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.packageName == this.packageName &&
          other.createdAt == this.createdAt);
}

class CategoryAppMappingsCompanion extends UpdateCompanion<CategoryAppMapping> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<String> packageName;
  final Value<int> createdAt;
  const CategoryAppMappingsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.packageName = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CategoryAppMappingsCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required String packageName,
    required int createdAt,
  }) : categoryId = Value(categoryId),
       packageName = Value(packageName),
       createdAt = Value(createdAt);
  static Insertable<CategoryAppMapping> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? packageName,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (packageName != null) 'package_name': packageName,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CategoryAppMappingsCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<String>? packageName,
    Value<int>? createdAt,
  }) {
    return CategoryAppMappingsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      packageName: packageName ?? this.packageName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (packageName.present) {
      map['package_name'] = Variable<String>(packageName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryAppMappingsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('packageName: $packageName, ')
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
  late final CustomCategories customCategories = CustomCategories(this);
  late final CategoryAppMappings categoryAppMappings = CategoryAppMappings(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    notificationEntries,
    studyItems,
    customCategories,
    categoryAppMappings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'custom_categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('category_app_mappings', kind: UpdateKind.delete)],
    ),
  ]);
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
typedef $CustomCategoriesCreateCompanionBuilder =
    CustomCategoriesCompanion Function({
      Value<int> id,
      required String name,
      required int iconCodePoint,
      required int colorValue,
      required int createdAt,
      Value<bool> isActive,
    });
typedef $CustomCategoriesUpdateCompanionBuilder =
    CustomCategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> iconCodePoint,
      Value<int> colorValue,
      Value<int> createdAt,
      Value<bool> isActive,
    });

final class $CustomCategoriesReferences
    extends BaseReferences<_$AppDatabase, CustomCategories, CustomCategory> {
  $CustomCategoriesReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<CategoryAppMappings, List<CategoryAppMapping>>
  _categoryAppMappingsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.categoryAppMappings,
        aliasName: $_aliasNameGenerator(
          db.customCategories.id,
          db.categoryAppMappings.categoryId,
        ),
      );

  $CategoryAppMappingsProcessedTableManager get categoryAppMappingsRefs {
    final manager = $CategoryAppMappingsTableManager(
      $_db,
      $_db.categoryAppMappings,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _categoryAppMappingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $CustomCategoriesFilterComposer
    extends Composer<_$AppDatabase, CustomCategories> {
  $CustomCategoriesFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> categoryAppMappingsRefs(
    Expression<bool> Function($CategoryAppMappingsFilterComposer f) f,
  ) {
    final $CategoryAppMappingsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categoryAppMappings,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CategoryAppMappingsFilterComposer(
            $db: $db,
            $table: $db.categoryAppMappings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $CustomCategoriesOrderingComposer
    extends Composer<_$AppDatabase, CustomCategories> {
  $CustomCategoriesOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $CustomCategoriesAnnotationComposer
    extends Composer<_$AppDatabase, CustomCategories> {
  $CustomCategoriesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> categoryAppMappingsRefs<T extends Object>(
    Expression<T> Function($CategoryAppMappingsAnnotationComposer a) f,
  ) {
    final $CategoryAppMappingsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categoryAppMappings,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CategoryAppMappingsAnnotationComposer(
            $db: $db,
            $table: $db.categoryAppMappings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $CustomCategoriesTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          CustomCategories,
          CustomCategory,
          $CustomCategoriesFilterComposer,
          $CustomCategoriesOrderingComposer,
          $CustomCategoriesAnnotationComposer,
          $CustomCategoriesCreateCompanionBuilder,
          $CustomCategoriesUpdateCompanionBuilder,
          (CustomCategory, $CustomCategoriesReferences),
          CustomCategory,
          PrefetchHooks Function({bool categoryAppMappingsRefs})
        > {
  $CustomCategoriesTableManager(_$AppDatabase db, CustomCategories table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CustomCategoriesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CustomCategoriesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CustomCategoriesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> iconCodePoint = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => CustomCategoriesCompanion(
                id: id,
                name: name,
                iconCodePoint: iconCodePoint,
                colorValue: colorValue,
                createdAt: createdAt,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int iconCodePoint,
                required int colorValue,
                required int createdAt,
                Value<bool> isActive = const Value.absent(),
              }) => CustomCategoriesCompanion.insert(
                id: id,
                name: name,
                iconCodePoint: iconCodePoint,
                colorValue: colorValue,
                createdAt: createdAt,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $CustomCategoriesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryAppMappingsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (categoryAppMappingsRefs) db.categoryAppMappings,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (categoryAppMappingsRefs)
                    await $_getPrefetchedData<
                      CustomCategory,
                      CustomCategories,
                      CategoryAppMapping
                    >(
                      currentTable: table,
                      referencedTable: $CustomCategoriesReferences
                          ._categoryAppMappingsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $CustomCategoriesReferences(
                            db,
                            table,
                            p0,
                          ).categoryAppMappingsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $CustomCategoriesProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      CustomCategories,
      CustomCategory,
      $CustomCategoriesFilterComposer,
      $CustomCategoriesOrderingComposer,
      $CustomCategoriesAnnotationComposer,
      $CustomCategoriesCreateCompanionBuilder,
      $CustomCategoriesUpdateCompanionBuilder,
      (CustomCategory, $CustomCategoriesReferences),
      CustomCategory,
      PrefetchHooks Function({bool categoryAppMappingsRefs})
    >;
typedef $CategoryAppMappingsCreateCompanionBuilder =
    CategoryAppMappingsCompanion Function({
      Value<int> id,
      required int categoryId,
      required String packageName,
      required int createdAt,
    });
typedef $CategoryAppMappingsUpdateCompanionBuilder =
    CategoryAppMappingsCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<String> packageName,
      Value<int> createdAt,
    });

final class $CategoryAppMappingsReferences
    extends
        BaseReferences<_$AppDatabase, CategoryAppMappings, CategoryAppMapping> {
  $CategoryAppMappingsReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static CustomCategories _categoryIdTable(_$AppDatabase db) =>
      db.customCategories.createAlias(
        $_aliasNameGenerator(
          db.categoryAppMappings.categoryId,
          db.customCategories.id,
        ),
      );

  $CustomCategoriesProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $CustomCategoriesTableManager(
      $_db,
      $_db.customCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $CategoryAppMappingsFilterComposer
    extends Composer<_$AppDatabase, CategoryAppMappings> {
  $CategoryAppMappingsFilterComposer({
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

  ColumnFilters<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $CustomCategoriesFilterComposer get categoryId {
    final $CustomCategoriesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.customCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CustomCategoriesFilterComposer(
            $db: $db,
            $table: $db.customCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CategoryAppMappingsOrderingComposer
    extends Composer<_$AppDatabase, CategoryAppMappings> {
  $CategoryAppMappingsOrderingComposer({
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

  ColumnOrderings<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $CustomCategoriesOrderingComposer get categoryId {
    final $CustomCategoriesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.customCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CustomCategoriesOrderingComposer(
            $db: $db,
            $table: $db.customCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CategoryAppMappingsAnnotationComposer
    extends Composer<_$AppDatabase, CategoryAppMappings> {
  $CategoryAppMappingsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $CustomCategoriesAnnotationComposer get categoryId {
    final $CustomCategoriesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.customCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CustomCategoriesAnnotationComposer(
            $db: $db,
            $table: $db.customCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CategoryAppMappingsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          CategoryAppMappings,
          CategoryAppMapping,
          $CategoryAppMappingsFilterComposer,
          $CategoryAppMappingsOrderingComposer,
          $CategoryAppMappingsAnnotationComposer,
          $CategoryAppMappingsCreateCompanionBuilder,
          $CategoryAppMappingsUpdateCompanionBuilder,
          (CategoryAppMapping, $CategoryAppMappingsReferences),
          CategoryAppMapping,
          PrefetchHooks Function({bool categoryId})
        > {
  $CategoryAppMappingsTableManager(_$AppDatabase db, CategoryAppMappings table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CategoryAppMappingsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CategoryAppMappingsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CategoryAppMappingsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<String> packageName = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => CategoryAppMappingsCompanion(
                id: id,
                categoryId: categoryId,
                packageName: packageName,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                required String packageName,
                required int createdAt,
              }) => CategoryAppMappingsCompanion.insert(
                id: id,
                categoryId: categoryId,
                packageName: packageName,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $CategoryAppMappingsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
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
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable: $CategoryAppMappingsReferences
                                    ._categoryIdTable(db),
                                referencedColumn: $CategoryAppMappingsReferences
                                    ._categoryIdTable(db)
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

typedef $CategoryAppMappingsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      CategoryAppMappings,
      CategoryAppMapping,
      $CategoryAppMappingsFilterComposer,
      $CategoryAppMappingsOrderingComposer,
      $CategoryAppMappingsAnnotationComposer,
      $CategoryAppMappingsCreateCompanionBuilder,
      $CategoryAppMappingsUpdateCompanionBuilder,
      (CategoryAppMapping, $CategoryAppMappingsReferences),
      CategoryAppMapping,
      PrefetchHooks Function({bool categoryId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $NotificationEntriesTableManager get notificationEntries =>
      $NotificationEntriesTableManager(_db, _db.notificationEntries);
  $StudyItemsTableManager get studyItems =>
      $StudyItemsTableManager(_db, _db.studyItems);
  $CustomCategoriesTableManager get customCategories =>
      $CustomCategoriesTableManager(_db, _db.customCategories);
  $CategoryAppMappingsTableManager get categoryAppMappings =>
      $CategoryAppMappingsTableManager(_db, _db.categoryAppMappings);
}
