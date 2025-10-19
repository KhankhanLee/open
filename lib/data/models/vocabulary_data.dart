// 언어 학습을 위한 기본 단어 데이터

class VocabularyWord {
  final String word;
  final String translation;
  final String? example;
  final String? pronunciation;
  final String category;

  VocabularyWord({
    required this.word,
    required this.translation,
    this.example,
    this.pronunciation,
    required this.category,
  });
}

enum LanguageType {
  english('영어', 'en'),
  japanese('일본어', 'ja'),
  spanish('스페인어', 'es'),
  german('독일어', 'de');

  final String label;
  final String code;

  const LanguageType(this.label, this.code);
}

class VocabularyData {
  // 영어 기본 단어 1000개
  static List<VocabularyWord> getEnglishWords() {
    return [
      // 기초 (1-100)
      VocabularyWord(
        word: 'hello',
        translation: '안녕하세요',
        example: 'Hello, how are you?',
        category: '인사',
      ),
      VocabularyWord(
        word: 'goodbye',
        translation: '안녕히 가세요',
        example: 'Goodbye, see you later!',
        category: '인사',
      ),
      VocabularyWord(
        word: 'thank you',
        translation: '감사합니다',
        example: 'Thank you for your help',
        category: '인사',
      ),
      VocabularyWord(
        word: 'please',
        translation: '부탁합니다',
        example: 'Please help me',
        category: '인사',
      ),
      VocabularyWord(
        word: 'sorry',
        translation: '미안합니다',
        example: 'I am sorry',
        category: '인사',
      ),
      VocabularyWord(
        word: 'yes',
        translation: '예',
        example: 'Yes, I agree',
        category: '기본',
      ),
      VocabularyWord(
        word: 'no',
        translation: '아니오',
        example: 'No, I disagree',
        category: '기본',
      ),
      VocabularyWord(
        word: 'good',
        translation: '좋은',
        example: 'It is a good day',
        category: '형용사',
      ),
      VocabularyWord(
        word: 'bad',
        translation: '나쁜',
        example: 'That is bad news',
        category: '형용사',
      ),
      VocabularyWord(
        word: 'happy',
        translation: '행복한',
        example: 'I am happy',
        category: '감정',
      ),
      VocabularyWord(
        word: 'sad',
        translation: '슬픈',
        example: 'She looks sad',
        category: '감정',
      ),
      VocabularyWord(
        word: 'big',
        translation: '큰',
        example: 'A big house',
        category: '형용사',
      ),
      VocabularyWord(
        word: 'small',
        translation: '작은',
        example: 'A small car',
        category: '형용사',
      ),
      VocabularyWord(
        word: 'hot',
        translation: '뜨거운',
        example: 'Hot coffee',
        category: '형용사',
      ),
      VocabularyWord(
        word: 'cold',
        translation: '차가운',
        example: 'Cold water',
        category: '형용사',
      ),
      VocabularyWord(
        word: 'new',
        translation: '새로운',
        example: 'A new book',
        category: '형용사',
      ),
      VocabularyWord(
        word: 'old',
        translation: '오래된',
        example: 'An old building',
        category: '형용사',
      ),
      VocabularyWord(
        word: 'young',
        translation: '젊은',
        example: 'A young man',
        category: '형용사',
      ),
      VocabularyWord(
        word: 'beautiful',
        translation: '아름다운',
        example: 'Beautiful flowers',
        category: '형용사',
      ),
      VocabularyWord(
        word: 'ugly',
        translation: '못생긴',
        example: 'An ugly monster',
        category: '형용사',
      ),

      // 숫자 (21-30)
      VocabularyWord(
        word: 'one',
        translation: '하나',
        example: 'One apple',
        category: '숫자',
      ),
      VocabularyWord(
        word: 'two',
        translation: '둘',
        example: 'Two books',
        category: '숫자',
      ),
      VocabularyWord(
        word: 'three',
        translation: '셋',
        example: 'Three cats',
        category: '숫자',
      ),
      VocabularyWord(
        word: 'four',
        translation: '넷',
        example: 'Four chairs',
        category: '숫자',
      ),
      VocabularyWord(
        word: 'five',
        translation: '다섯',
        example: 'Five fingers',
        category: '숫자',
      ),
      VocabularyWord(
        word: 'six',
        translation: '여섯',
        example: 'Six days',
        category: '숫자',
      ),
      VocabularyWord(
        word: 'seven',
        translation: '일곱',
        example: 'Seven colors',
        category: '숫자',
      ),
      VocabularyWord(
        word: 'eight',
        translation: '여덟',
        example: 'Eight hours',
        category: '숫자',
      ),
      VocabularyWord(
        word: 'nine',
        translation: '아홉',
        example: 'Nine players',
        category: '숫자',
      ),
      VocabularyWord(
        word: 'ten',
        translation: '열',
        example: 'Ten dollars',
        category: '숫자',
      ),

      // 가족 (31-40)
      VocabularyWord(
        word: 'family',
        translation: '가족',
        example: 'My family is big',
        category: '가족',
      ),
      VocabularyWord(
        word: 'mother',
        translation: '어머니',
        example: 'My mother is kind',
        category: '가족',
      ),
      VocabularyWord(
        word: 'father',
        translation: '아버지',
        example: 'My father works',
        category: '가족',
      ),
      VocabularyWord(
        word: 'brother',
        translation: '형제',
        example: 'I have a brother',
        category: '가족',
      ),
      VocabularyWord(
        word: 'sister',
        translation: '자매',
        example: 'She is my sister',
        category: '가족',
      ),
      VocabularyWord(
        word: 'son',
        translation: '아들',
        example: 'He has a son',
        category: '가족',
      ),
      VocabularyWord(
        word: 'daughter',
        translation: '딸',
        example: 'She has a daughter',
        category: '가족',
      ),
      VocabularyWord(
        word: 'grandfather',
        translation: '할아버지',
        example: 'My grandfather is old',
        category: '가족',
      ),
      VocabularyWord(
        word: 'grandmother',
        translation: '할머니',
        example: 'My grandmother cooks',
        category: '가족',
      ),
      VocabularyWord(
        word: 'uncle',
        translation: '삼촌',
        example: 'My uncle visits us',
        category: '가족',
      ),

      // 음식 (41-60)
      VocabularyWord(
        word: 'food',
        translation: '음식',
        example: 'I love food',
        category: '음식',
      ),
      VocabularyWord(
        word: 'water',
        translation: '물',
        example: 'Drink water',
        category: '음식',
      ),
      VocabularyWord(
        word: 'bread',
        translation: '빵',
        example: 'Fresh bread',
        category: '음식',
      ),
      VocabularyWord(
        word: 'rice',
        translation: '쌀, 밥',
        example: 'White rice',
        category: '음식',
      ),
      VocabularyWord(
        word: 'meat',
        translation: '고기',
        example: 'Cook meat',
        category: '음식',
      ),
      VocabularyWord(
        word: 'fish',
        translation: '생선',
        example: 'Grilled fish',
        category: '음식',
      ),
      VocabularyWord(
        word: 'fruit',
        translation: '과일',
        example: 'Fresh fruit',
        category: '음식',
      ),
      VocabularyWord(
        word: 'vegetable',
        translation: '채소',
        example: 'Green vegetables',
        category: '음식',
      ),
      VocabularyWord(
        word: 'apple',
        translation: '사과',
        example: 'Red apple',
        category: '음식',
      ),
      VocabularyWord(
        word: 'banana',
        translation: '바나나',
        example: 'Yellow banana',
        category: '음식',
      ),
      VocabularyWord(
        word: 'orange',
        translation: '오렌지',
        example: 'Sweet orange',
        category: '음식',
      ),
      VocabularyWord(
        word: 'egg',
        translation: '계란',
        example: 'Boiled egg',
        category: '음식',
      ),
      VocabularyWord(
        word: 'milk',
        translation: '우유',
        example: 'Cold milk',
        category: '음식',
      ),
      VocabularyWord(
        word: 'coffee',
        translation: '커피',
        example: 'Hot coffee',
        category: '음식',
      ),
      VocabularyWord(
        word: 'tea',
        translation: '차',
        example: 'Green tea',
        category: '음식',
      ),
      VocabularyWord(
        word: 'sugar',
        translation: '설탕',
        example: 'Sweet sugar',
        category: '음식',
      ),
      VocabularyWord(
        word: 'salt',
        translation: '소금',
        example: 'Salty food',
        category: '음식',
      ),
      VocabularyWord(
        word: 'breakfast',
        translation: '아침식사',
        example: 'Eat breakfast',
        category: '음식',
      ),
      VocabularyWord(
        word: 'lunch',
        translation: '점심식사',
        example: 'Lunch time',
        category: '음식',
      ),
      VocabularyWord(
        word: 'dinner',
        translation: '저녁식사',
        example: 'Dinner is ready',
        category: '음식',
      ),

      // 동물 (61-80)
      VocabularyWord(
        word: 'animal',
        translation: '동물',
        example: 'Wild animals',
        category: '동물',
      ),
      VocabularyWord(
        word: 'dog',
        translation: '개',
        example: 'My dog is cute',
        category: '동물',
      ),
      VocabularyWord(
        word: 'cat',
        translation: '고양이',
        example: 'Black cat',
        category: '동물',
      ),
      VocabularyWord(
        word: 'bird',
        translation: '새',
        example: 'Birds fly',
        category: '동물',
      ),
      VocabularyWord(
        word: 'fish',
        translation: '물고기',
        example: 'Fish swim',
        category: '동물',
      ),
      VocabularyWord(
        word: 'horse',
        translation: '말',
        example: 'Fast horse',
        category: '동물',
      ),
      VocabularyWord(
        word: 'cow',
        translation: '소',
        example: 'Brown cow',
        category: '동물',
      ),
      VocabularyWord(
        word: 'pig',
        translation: '돼지',
        example: 'Pink pig',
        category: '동물',
      ),
      VocabularyWord(
        word: 'chicken',
        translation: '닭',
        example: 'Chicken coop',
        category: '동물',
      ),
      VocabularyWord(
        word: 'duck',
        translation: '오리',
        example: 'Duck pond',
        category: '동물',
      ),
      VocabularyWord(
        word: 'rabbit',
        translation: '토끼',
        example: 'White rabbit',
        category: '동물',
      ),
      VocabularyWord(
        word: 'mouse',
        translation: '쥐',
        example: 'Small mouse',
        category: '동물',
      ),
      VocabularyWord(
        word: 'elephant',
        translation: '코끼리',
        example: 'Big elephant',
        category: '동물',
      ),
      VocabularyWord(
        word: 'lion',
        translation: '사자',
        example: 'Brave lion',
        category: '동물',
      ),
      VocabularyWord(
        word: 'tiger',
        translation: '호랑이',
        example: 'Strong tiger',
        category: '동물',
      ),
      VocabularyWord(
        word: 'bear',
        translation: '곰',
        example: 'Brown bear',
        category: '동물',
      ),
      VocabularyWord(
        word: 'monkey',
        translation: '원숭이',
        example: 'Funny monkey',
        category: '동물',
      ),
      VocabularyWord(
        word: 'snake',
        translation: '뱀',
        example: 'Long snake',
        category: '동물',
      ),
      VocabularyWord(
        word: 'frog',
        translation: '개구리',
        example: 'Green frog',
        category: '동물',
      ),
      VocabularyWord(
        word: 'butterfly',
        translation: '나비',
        example: 'Beautiful butterfly',
        category: '동물',
      ),

      // 색상 (81-90)
      VocabularyWord(
        word: 'color',
        translation: '색',
        example: 'Bright colors',
        category: '색상',
      ),
      VocabularyWord(
        word: 'red',
        translation: '빨간색',
        example: 'Red rose',
        category: '색상',
      ),
      VocabularyWord(
        word: 'blue',
        translation: '파란색',
        example: 'Blue sky',
        category: '색상',
      ),
      VocabularyWord(
        word: 'green',
        translation: '초록색',
        example: 'Green grass',
        category: '색상',
      ),
      VocabularyWord(
        word: 'yellow',
        translation: '노란색',
        example: 'Yellow sun',
        category: '색상',
      ),
      VocabularyWord(
        word: 'black',
        translation: '검은색',
        example: 'Black night',
        category: '색상',
      ),
      VocabularyWord(
        word: 'white',
        translation: '흰색',
        example: 'White snow',
        category: '색상',
      ),
      VocabularyWord(
        word: 'brown',
        translation: '갈색',
        example: 'Brown bear',
        category: '색상',
      ),
      VocabularyWord(
        word: 'pink',
        translation: '분홍색',
        example: 'Pink flower',
        category: '색상',
      ),
      VocabularyWord(
        word: 'purple',
        translation: '보라색',
        example: 'Purple grape',
        category: '색상',
      ),

      // 동사 (91-150)
      VocabularyWord(
        word: 'eat',
        translation: '먹다',
        example: 'I eat food',
        category: '동사',
      ),
      VocabularyWord(
        word: 'drink',
        translation: '마시다',
        example: 'Drink water',
        category: '동사',
      ),
      VocabularyWord(
        word: 'sleep',
        translation: '자다',
        example: 'Sleep well',
        category: '동사',
      ),
      VocabularyWord(
        word: 'wake',
        translation: '깨다',
        example: 'Wake up early',
        category: '동사',
      ),
      VocabularyWord(
        word: 'walk',
        translation: '걷다',
        example: 'Walk slowly',
        category: '동사',
      ),
      VocabularyWord(
        word: 'run',
        translation: '달리다',
        example: 'Run fast',
        category: '동사',
      ),
      VocabularyWord(
        word: 'jump',
        translation: '뛰다',
        example: 'Jump high',
        category: '동사',
      ),
      VocabularyWord(
        word: 'sit',
        translation: '앉다',
        example: 'Sit down',
        category: '동사',
      ),
      VocabularyWord(
        word: 'stand',
        translation: '서다',
        example: 'Stand up',
        category: '동사',
      ),
      VocabularyWord(
        word: 'read',
        translation: '읽다',
        example: 'Read a book',
        category: '동사',
      ),
      VocabularyWord(
        word: 'write',
        translation: '쓰다',
        example: 'Write a letter',
        category: '동사',
      ),
      VocabularyWord(
        word: 'speak',
        translation: '말하다',
        example: 'Speak loudly',
        category: '동사',
      ),
      VocabularyWord(
        word: 'listen',
        translation: '듣다',
        example: 'Listen carefully',
        category: '동사',
      ),
      VocabularyWord(
        word: 'see',
        translation: '보다',
        example: 'See clearly',
        category: '동사',
      ),
      VocabularyWord(
        word: 'look',
        translation: '보다',
        example: 'Look at me',
        category: '동사',
      ),
      VocabularyWord(
        word: 'watch',
        translation: '지켜보다',
        example: 'Watch TV',
        category: '동사',
      ),
      VocabularyWord(
        word: 'hear',
        translation: '듣다',
        example: 'Hear a sound',
        category: '동사',
      ),
      VocabularyWord(
        word: 'smell',
        translation: '냄새 맡다',
        example: 'Smell flowers',
        category: '동사',
      ),
      VocabularyWord(
        word: 'taste',
        translation: '맛보다',
        example: 'Taste good',
        category: '동사',
      ),
      VocabularyWord(
        word: 'touch',
        translation: '만지다',
        example: 'Touch gently',
        category: '동사',
      ),
      VocabularyWord(
        word: 'think',
        translation: '생각하다',
        example: 'Think deeply',
        category: '동사',
      ),
      VocabularyWord(
        word: 'know',
        translation: '알다',
        example: 'I know it',
        category: '동사',
      ),
      VocabularyWord(
        word: 'understand',
        translation: '이해하다',
        example: 'Understand well',
        category: '동사',
      ),
      VocabularyWord(
        word: 'remember',
        translation: '기억하다',
        example: 'Remember me',
        category: '동사',
      ),
      VocabularyWord(
        word: 'forget',
        translation: '잊다',
        example: 'Do not forget',
        category: '동사',
      ),
      VocabularyWord(
        word: 'love',
        translation: '사랑하다',
        example: 'I love you',
        category: '동사',
      ),
      VocabularyWord(
        word: 'like',
        translation: '좋아하다',
        example: 'I like it',
        category: '동사',
      ),
      VocabularyWord(
        word: 'hate',
        translation: '싫어하다',
        example: 'I hate lying',
        category: '동사',
      ),
      VocabularyWord(
        word: 'want',
        translation: '원하다',
        example: 'I want water',
        category: '동사',
      ),
      VocabularyWord(
        word: 'need',
        translation: '필요하다',
        example: 'I need help',
        category: '동사',
      ),
      VocabularyWord(
        word: 'have',
        translation: '1.가지다,있다. 2.~으로 되어있다. 3.(어떤 특질,특징이)있다.',
        example: 'I have a car',
        category: '동사',
      )
      // ... 계속 추가 (총 1000개까지)
    ];
  }

  // 일본어 기본 단어 1000개
  static List<VocabularyWord> getJapaneseWords() {
    return [
      VocabularyWord(
        word: 'こんにちは',
        translation: '안녕하세요',
        pronunciation: 'konnichiwa',
        category: '인사',
      ),
      VocabularyWord(
        word: 'さようなら',
        translation: '안녕히 가세요',
        pronunciation: 'sayounara',
        category: '인사',
      ),
      VocabularyWord(
        word: 'ありがとう',
        translation: '감사합니다',
        pronunciation: 'arigatou',
        category: '인사',
      ),
      VocabularyWord(
        word: 'すみません',
        translation: '죄송합니다',
        pronunciation: 'sumimasen',
        category: '인사',
      ),
      VocabularyWord(
        word: 'はい',
        translation: '네',
        pronunciation: 'hai',
        category: '기본',
      ),
      VocabularyWord(
        word: 'いいえ',
        translation: '아니오',
        pronunciation: 'iie',
        category: '기본',
      ),
      VocabularyWord(
        word: 'おはよう',
        translation: '좋은 아침',
        pronunciation: 'ohayou',
        category: '인사',
      ),
      VocabularyWord(
        word: 'おやすみ',
        translation: '안녕히 주무세요',
        pronunciation: 'oyasumi',
        category: '인사',
      ),
      VocabularyWord(
        word: '水',
        translation: '물',
        pronunciation: 'mizu',
        category: '음식',
      ),
      VocabularyWord(
        word: '食べ物',
        translation: '음식',
        pronunciation: 'tabemono',
        category: '음식',
      ),
      VocabularyWord(
        word: 'パン',
        translation: '빵',
        pronunciation: 'pan',
        category: '음식',
      ),
      VocabularyWord(
        word: 'ご飯',
        translation: '밥',
        pronunciation: 'gohan',
        category: '음식',
      ),
      VocabularyWord(
        word: '肉',
        translation: '고기',
        pronunciation: 'niku',
        category: '음식',
      ),
      VocabularyWord(
        word: '魚',
        translation: '생선',
        pronunciation: 'sakana',
        category: '음식',
      ),
      VocabularyWord(
        word: '果物',
        translation: '과일',
        pronunciation: 'kudamono',
        category: '음식',
      ),
      VocabularyWord(
        word: '野菜',
        translation: '채소',
        pronunciation: 'yasai',
        category: '음식',
      ),
      VocabularyWord(
        word: 'リンゴ',
        translation: '사과',
        pronunciation: 'ringo',
        category: '음식',
      ),
      VocabularyWord(
        word: 'バナナ',
        translation: '바나나',
        pronunciation: 'banana',
        category: '음식',
      ),
      VocabularyWord(
        word: 'コーヒー',
        translation: '커피',
        pronunciation: 'koohii',
        category: '음식',
      ),
      VocabularyWord(
        word: 'お茶',
        translation: '차',
        pronunciation: 'ocha',
        category: '음식',
      ),
      VocabularyWord(
        word: '犬',
        translation: '개',
        pronunciation: 'inu',
        category: '동물',
      ),
      VocabularyWord(
        word: '猫',
        translation: '고양이',
        pronunciation: 'neko',
        category: '동물',
      ),
      VocabularyWord(
        word: '鳥',
        translation: '새',
        pronunciation: 'tori',
        category: '동물',
      ),
      VocabularyWord(
        word: '馬',
        translation: '말',
        pronunciation: 'uma',
        category: '동물',
      ),
      VocabularyWord(
        word: '牛',
        translation: '소',
        pronunciation: 'ushi',
        category: '동물',
      ),
      VocabularyWord(
        word: '赤',
        translation: '빨간색',
        pronunciation: 'aka',
        category: '색상',
      ),
      VocabularyWord(
        word: '青',
        translation: '파란색',
        pronunciation: 'ao',
        category: '색상',
      ),
      VocabularyWord(
        word: '緑',
        translation: '초록색',
        pronunciation: 'midori',
        category: '색상',
      ),
      VocabularyWord(
        word: '黄色',
        translation: '노란색',
        pronunciation: 'kiiro',
        category: '색상',
      ),
      VocabularyWord(
        word: '黒',
        translation: '검은색',
        pronunciation: 'kuro',
        category: '색상',
      ),
      // ... 계속 추가 (총 1000개까지)
    ];
  }

  // 스페인어 기본 단어 1000개
  static List<VocabularyWord> getSpanishWords() {
    return [
      VocabularyWord(word: 'hola', translation: '안녕하세요', category: '인사'),
      VocabularyWord(word: 'adiós', translation: '안녕히 가세요', category: '인사'),
      VocabularyWord(word: 'gracias', translation: '감사합니다', category: '인사'),
      VocabularyWord(word: 'por favor', translation: '부탁합니다', category: '인사'),
      VocabularyWord(word: 'lo siento', translation: '미안합니다', category: '인사'),
      VocabularyWord(word: 'sí', translation: '네', category: '기본'),
      VocabularyWord(word: 'no', translation: '아니오', category: '기본'),
      VocabularyWord(word: 'buenos días', translation: '좋은 아침', category: '인사'),
      VocabularyWord(
        word: 'buenas noches',
        translation: '좋은 밤',
        category: '인사',
      ),
      VocabularyWord(word: 'agua', translation: '물', category: '음식'),
      VocabularyWord(word: 'comida', translation: '음식', category: '음식'),
      VocabularyWord(word: 'pan', translation: '빵', category: '음식'),
      VocabularyWord(word: 'arroz', translation: '쌀', category: '음식'),
      VocabularyWord(word: 'carne', translation: '고기', category: '음식'),
      VocabularyWord(word: 'pescado', translation: '생선', category: '음식'),
      VocabularyWord(word: 'fruta', translation: '과일', category: '음식'),
      VocabularyWord(word: 'verdura', translation: '채소', category: '음식'),
      VocabularyWord(word: 'manzana', translation: '사과', category: '음식'),
      VocabularyWord(word: 'plátano', translation: '바나나', category: '음식'),
      VocabularyWord(word: 'café', translation: '커피', category: '음식'),
      VocabularyWord(word: 'té', translation: '차', category: '음식'),
      VocabularyWord(word: 'perro', translation: '개', category: '동물'),
      VocabularyWord(word: 'gato', translation: '고양이', category: '동물'),
      VocabularyWord(word: 'pájaro', translation: '새', category: '동물'),
      VocabularyWord(word: 'caballo', translation: '말', category: '동물'),
      VocabularyWord(word: 'vaca', translation: '소', category: '동물'),
      VocabularyWord(word: 'rojo', translation: '빨간색', category: '색상'),
      VocabularyWord(word: 'azul', translation: '파란색', category: '색상'),
      VocabularyWord(word: 'verde', translation: '초록색', category: '색상'),
      VocabularyWord(word: 'amarillo', translation: '노란색', category: '색상'),
      // ... 계속 추가 (총 1000개까지)
    ];
  }

  // 독일어 기본 단어 1000개
  static List<VocabularyWord> getGermanWords() {
    return [
      VocabularyWord(word: 'hallo', translation: '안녕하세요', category: '인사'),
      VocabularyWord(word: 'tschüss', translation: '안녕히 가세요', category: '인사'),
      VocabularyWord(word: 'danke', translation: '감사합니다', category: '인사'),
      VocabularyWord(word: 'bitte', translation: '부탁합니다', category: '인사'),
      VocabularyWord(
        word: 'entschuldigung',
        translation: '미안합니다',
        category: '인사',
      ),
      VocabularyWord(word: 'ja', translation: '네', category: '기본'),
      VocabularyWord(word: 'nein', translation: '아니오', category: '기본'),
      VocabularyWord(
        word: 'guten Morgen',
        translation: '좋은 아침',
        category: '인사',
      ),
      VocabularyWord(word: 'gute Nacht', translation: '좋은 밤', category: '인사'),
      VocabularyWord(word: 'Wasser', translation: '물', category: '음식'),
      VocabularyWord(word: 'Essen', translation: '음식', category: '음식'),
      VocabularyWord(word: 'Brot', translation: '빵', category: '음식'),
      VocabularyWord(word: 'Reis', translation: '쌀', category: '음식'),
      VocabularyWord(word: 'Fleisch', translation: '고기', category: '음식'),
      VocabularyWord(word: 'Fisch', translation: '생선', category: '음식'),
      VocabularyWord(word: 'Obst', translation: '과일', category: '음식'),
      VocabularyWord(word: 'Gemüse', translation: '채소', category: '음식'),
      VocabularyWord(word: 'Apfel', translation: '사과', category: '음식'),
      VocabularyWord(word: 'Banane', translation: '바나나', category: '음식'),
      VocabularyWord(word: 'Kaffee', translation: '커피', category: '음식'),
      VocabularyWord(word: 'Tee', translation: '차', category: '음식'),
      VocabularyWord(word: 'Hund', translation: '개', category: '동물'),
      VocabularyWord(word: 'Katze', translation: '고양이', category: '동물'),
      VocabularyWord(word: 'Vogel', translation: '새', category: '동물'),
      VocabularyWord(word: 'Pferd', translation: '말', category: '동물'),
      VocabularyWord(word: 'Kuh', translation: '소', category: '동물'),
      VocabularyWord(word: 'rot', translation: '빨간색', category: '색상'),
      VocabularyWord(word: 'blau', translation: '파란색', category: '색상'),
      VocabularyWord(word: 'grün', translation: '초록색', category: '색상'),
      VocabularyWord(word: 'gelb', translation: '노란색', category: '색상'),
      // ... 계속 추가 (총 1000개까지)
    ];
  }

  static List<VocabularyWord> getWordsForLanguage(LanguageType language) {
    switch (language) {
      case LanguageType.english:
        return getEnglishWords();
      case LanguageType.japanese:
        return getJapaneseWords();
      case LanguageType.spanish:
        return getSpanishWords();
      case LanguageType.german:
        return getGermanWords();
    }
  }
}
