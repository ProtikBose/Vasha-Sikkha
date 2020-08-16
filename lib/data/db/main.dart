import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class MainDatabaseHelper {
  static final MainDatabaseHelper _instance = new MainDatabaseHelper.internal();
  factory MainDatabaseHelper() => _instance;

  static Database _db;

  //for user
  String userTable = 'User';
  String userIdCol = 'Id';
  String userNameCol = 'Username';
  String userEmailCol = 'Email';
  String userImageLinkCol = 'Image_Link';
  String userExperienceIdCol = 'ExperienceId';
  String userAgeCol = 'Age';
  String userTokenCol = 'Token';
  String userTokenTypeCol = 'Token_Type';
  String expiryCol = 'Expiration_Date';
  //for topic
  String topicTable = 'Topic';
  String topicIdCol = 'Id';
  String topicNameCol = 'Topic_Name';
  String topicImageLinkCol = 'Image_Link';
  String topicIsLovedCol = 'Is_Loved';
  String topicProgressCol = 'Topic_Progress';
  String topicLevelCol = 'Level';
  //for MCQ
  String mcqTable = 'MCQ';
  String mcqIdCol = 'Id';
  String mcqQuestionCol = 'Question';
  String mcqOptionCol = 'Options';
  String mcqAnswerCol = 'Answer';
  String mcqExplanationCol = 'Explanation';
  String mcqTopicIdCol='Topic_Id';

  //for FB
  String fbTable = 'FB';
  String fbIdCol = 'Id';
  String fbQuestionCol = 'Question';
  String fbOptionsCol = 'Options';
  String fbAnswersCol = 'Answers';
  String fbExplanationCol = 'Explanation';
  String fbTopicIdCol='Topic_Id';

  //for SM
  String smTable = 'SM';
  String smIdCol = 'Id';
  String smQuestionCol = 'Question';
  String smEnglishSentenceCol = 'EnglishSentence';
  String smBanglaSentenceCol = 'BanglaSentence';
  String smTopicIdCol = 'Topic_Id';
  String smSpecificTaskId ='Specific_Task_Id';
  String smTaskId = 'Task_Id';

  //for TF
  String tfTable = 'TF';
  String tfIdCol = 'Id';
  String tfQuestionCol = 'Question';
  String tfAnswerCol = 'Answer';
  String tfExplanationCol = 'Explanation';
  String tfTopicIdCol = 'Topic_Id';

  //for PW
  String pwTable = 'PW';
  String pwIdCol = 'Id';
  String pwImageCol = 'Image';
  String pwOptionsCol = 'Options';
  String pwAnswerCol = 'Answer';
  String pwExplanationCol = 'Explanation';
  String pwTopicIdCol = 'Topic_Id';

  //for WP
  String wpTable = 'WP';
  String wpIdCol = 'Id';
  String wpWordCol = 'Word';
  String wpImageOptionsCol = 'Image_Options';
  String wpAnswerCol = 'Image_Answer';
  String wpExplanationCol = 'Explanation';
  String wpTopicIdCol = 'Topic_Id';

   //for SME
  String smeTable='SME';
  String smeIdCol='Id';
  String smeBrokenSentenceCol='BrokenSentence';
  String smeEnglishSentenceCol='EnglishSentence';
  String smeBanglaSentenceCol='BanglaSentence';
  String smeFirstSegmentCol='FirstSegment';
  String smeLastSegmentCol ='LastSegment';
  String smeTopicIdCol = 'Topic_Id';
  String smeSpecificTaskId ='Specific_Task_Id';
  String smeTaskId = 'Task_Id';

  //for jumbled sentence
  String jumbledTable="JUMBLED";
  String jumbledIdCol="Id";
  String jumbledSegmentsCol="Segments";
  String jumbledEnglishSentenceCol="EnglishSentence";
  String jumbledBanglaMeaningCol="BanglaMeaning";
  String jumTopicIdCol = 'Topic_Id';

   //for Memory Game
  String mGTable='MG';
  String mGIdCol='Id';
  String mGImageLink='Image_link';
  String mGOptions='Options';
  String mGCorrect='Correct_answers';
  String mGTopicId="Topic_Id";
  String mgTaskId ="Task_Id";
  String mgSpecificTaskId = "Specific_Task_Id";

  MainDatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "dimik.db");
    print("DEBUG : === db path == : " + path);
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    print("Beiimain");
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    print("Yo Man");
    //User Table
    await db.execute(
        "CREATE TABLE $userTable($userIdCol INTEGER PRIMARY KEY AUTOINCREMENT, $userNameCol TEXT,"
        "$userEmailCol TEXT,$userImageLinkCol TEXT,$userExperienceIdCol INTEGER,$userAgeCol INTEGER,$userTokenCol TEXT)");

    //Topic Table
    await db.execute(
        "CREATE TABLE $topicTable($topicIdCol INTEGER PRIMARY KEY AUTOINCREMENT, $topicNameCol TEXT,"
        "$topicImageLinkCol TEXT,$topicIsLovedCol INTEGER,$topicProgressCol INTEGER, $topicLevelCol INTEGER)");

    //MCQ Table
    await db.execute(
        "CREATE TABLE $mcqTable($mcqIdCol INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$mcqQuestionCol TEXT,$mcqOptionCol TEXT,$mcqAnswerCol TEXT,$mcqExplanationCol TEXT,$mcqTopicIdCol INTEGER,FOREIGN KEY($mcqTopicIdCol) REFERENCES $topicTable($topicIdCol))");

    //FB Table
    await db.execute(
        "CREATE TABLE $fbTable($fbIdCol INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$fbQuestionCol TEXT,$fbOptionsCol TEXT,$fbAnswersCol TEXT,$fbExplanationCol TEXT,$fbTopicIdCol INTEGER,FOREIGN KEY($fbTopicIdCol) REFERENCES $topicTable($topicIdCol))");

    //SM Table
    await db.execute(
        "CREATE TABLE $smTable($smIdCol INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$smEnglishSentenceCol TEXT,$smBanglaSentenceCol TEXT,$smTopicIdCol INTEGER, $smSpecificTaskId INTEGER, $smTaskId INTEGER ,FOREIGN KEY($smTopicIdCol) REFERENCES $topicTable($topicIdCol))");
    print("Created SM tables");

    //TF Table
    await db.execute(
        "CREATE TABLE $tfTable($tfIdCol INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$tfQuestionCol TEXT,$tfAnswerCol INTEGER,$tfExplanationCol TEXT,$tfTopicIdCol INTEGER, FOREIGN KEY($tfTopicIdCol) REFERENCES $topicTable($topicIdCol))");
    print("Created TF tables");
  
    //PW Table
    await db.execute(
        "CREATE TABLE $pwTable($pwIdCol INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$pwImageCol TEXT,$pwOptionsCol TEXT,$pwAnswerCol TEXT,$pwExplanationCol TEXT,$pwTopicIdCol INTEGER, FOREIGN KEY($pwTopicIdCol) REFERENCES $topicTable($topicIdCol))");
    print("Created PW tables");
    
    //WP Table
    await db.execute(
        "CREATE TABLE $wpTable($wpIdCol INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$wpWordCol TEXT,$wpImageOptionsCol TEXT,$wpAnswerCol TEXT,$wpExplanationCol TEXT,$wpTopicIdCol INTEGER, FOREIGN KEY($wpTopicIdCol) REFERENCES $topicTable($topicIdCol))");
    print("Created WP tables");

    //SME Table
    await db.execute(
    "CREATE TABLE $smeTable($smeIdCol INTEGER PRIMARY KEY AUTOINCREMENT, "
    "$smeBrokenSentenceCol TEXT,$smeEnglishSentenceCol TEXT,$smeBanglaSentenceCol TEXT,$smeFirstSegmentCol TEXT,$smeLastSegmentCol TEXT,$smeTopicIdCol INTEGER,$smeTaskId INTEGER, $smeSpecificTaskId INTEGER,FOREIGN KEY($smeTopicIdCol) REFERENCES $topicTable($topicIdCol))");
    print("Created sme table");

    //JUMBLED Table
     await db.execute(
    "CREATE TABLE $jumbledTable($jumbledIdCol INTEGER PRIMARY KEY AUTOINCREMENT, "
    "$jumbledSegmentsCol TEXT,$jumbledEnglishSentenceCol TEXT,$jumbledBanglaMeaningCol TEXT,$jumTopicIdCol TEXT,FOREIGN KEY($jumTopicIdCol) REFERENCES $topicTable($topicIdCol))");
    print("Created jumbled table");

    //MG Table
    
    await db.execute(
        "CREATE TABLE $mGTable($mGIdCol INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$mGImageLink TEXT,$mGOptions TEXT,$mGCorrect TEXT,$mGTopicId INTEGER, $mgTaskId INTEGER, $mgSpecificTaskId INTEGER,FOREIGN KEY($mGTopicId) REFERENCES $topicTable($topicIdCol))");
    print("Created MG tables");
    
  }

  /*
  static final MCQDatabaseHelper _instance = new MCQDatabaseHelper.internal();
  factory MCQDatabaseHelper() => _instance;

  static Database _db;

  MCQDatabaseHelper.internal();

  String tableName='MCQ';
  String idCol='Id';
  String questionCol='Question';
  String optionCol='Options';
  String answerCol='Answer';
  String explanationCol='Explanation';

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "mcq.db");
    print("DEBUG : === db path == : "+path);
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
    "CREATE TABLE $tableName($idCol INTEGER PRIMARY KEY AUTOINCREMENT, $questionCol TEXT,"
    "$optionCol TEXT,$answerCol TEXT,$explanationCol TEXT)");
    print("Created tables");
  }

  Future<List<Map<String,dynamic>> > getMCQList() async {
    Database dbClient = await db;

    List<Map<String,dynamic> > result = await dbClient.rawQuery('SELECT * FROM $tableName');
    
   // var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    //return result;
    return result;
  }

  // Insert Operation: Insert a Topic object to database
  Future<int> insertMCQ(MCQ mcq) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableName, mcq.toMap());
    return result;
  }

  // Update Operation: Update a Topic object and save it to database
  Future<int> updateMCQ(MCQ mcq) async {
    var dbClient = await db;
    var result = await dbClient.update(tableName, mcq.toMap(), where: '$idCol = ?', whereArgs: [mcq.Id]);
    return result;
  }

  // Delete Operation: Delete a Topic object from database
  Future<int> deleteMCQ(int entryId) async {
    var dbClient = await db;
    int result = await dbClient.rawDelete('DELETE FROM $tableName WHERE $idCol = $entryId');
    return result;
  }


  Future<int> getCount() async {
    var dbClient = await db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
  */
}
