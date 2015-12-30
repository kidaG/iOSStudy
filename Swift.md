#iOS勉強メモ

#0. Controllerのライフサイクル
以下のようになっている。

1. loadView  
2. viewDidLoad
3. viewWillAppear:
4. viewWillLayoutSubviews
5. viewDidLayoutSubviews
6. videDidAppear:
7. viewWillDisappear
8. viewDidDisapper


##1 loadView
カスタムViewの初期化を実施するメソッド。
なお、InterfaceBuilder(storyboardやxib)を利用している場合は、このメソッドは呼び出してはならない。

##2 viewDidLoad
ViewControllerのviewがロードされた後。InterfaceBuilder利用時はここでサブビューのセットアップを実施する。

##3 viewWillAppear
viewが表示される直前に呼ばれる。

##6 viewDidAppear
画面描画直後。そのため、ここでviewの生成などを行うとおかしくなる

 





#1. Core Dataの基礎知識
### Core Dataスタック
スタックとは --- 永続ストアへのデータの保存や取得のためのフレームワークオブジェクト全体。具体的には、**ManagedObjectContext**や**ManageObject**、PersistentStoreCoordinator、**ManagedObjectModel**、PersistentObjectStoreのまとまりのこと。

####管理オブジェクト(NSManagedObjectのサブクラスのインスタンス)
概念的には、DBのレコード。

####管理オブジェクトコンテキスト(NSManagedObjectContextのインスタンス)
一つのオブジェクト空間(スクラッチパッド)。正確には異なるがキャッシュのような、実際に永続ストアに保存する前状態の塊。
管理オブジェクトオンテキストへの操作（管理オブジェクトの保存、削除、更新など）は、永続ストアにコミットするまで、メモリ内に保持される。
ライフサイクル管理から、妥当性検証、関係の管理、アンドゥ/リドゥまでを担当している。
使い方の流れとしては以下のようになっている：

1. 管理オブジェクトの作成
2. 管理オブジェクトコンテキストへ作成した管理オブジェクトを挿入。
3. 永続ストアにコミット

####管理オブジェクトモデル（Core Dataのモデル(.xcdatamodeld)ファイル）
DBを定義するスキーマのオブジェクト表現。NSEntityDescriptionのインスタンスのコレクション。
エンティティの名前やクラスの名前、プロパティ(属性や関係)を定義している。
詳しいモデリンングツールの使い方は[Core Dataプログラミングガイド](https://developer.apple.com/jp/documentation/CoreData.pdf)参照

1. プロパティ  
プロパティには「属性」と「関係」の２種類があり、また名前と型もある。
	1. 属性  
		文字列、日付、整数など様々な属性型がある。属性値はオプションに設定可能。
		 	
	2. 関係  
	関係の随意性（必須か否か）、基数(対1か対多)、削除規定を指定可能。
		* 関係の随意性
		* 基数
		* 削除指定
			* Deny  
			関係で結ばれる先に１つでもオブジェクトがあれば削除されない。例えば、関連従業員を削除しないと部署削除できないということ。
			* Nullify  
			削除した際に、逆関係をnullにする
			* Cascade  
			関係先のオブジェクトを連鎖的に削除。例えば、部署削除時に関係するすべての従業員が削除されるということ。
			* No Action  
			何もしない
	
	
#####サンプルプログラム

	[CoreDataでRelationshipが対多の場合の、他のNSManagedObjectを追加する場合の方法]  
	// コンテストに賞品を追加するサンプル
	// Contests.Constants.relatedPrize：管理オブジェクトモデルで設定しているRelationshipの名前
	let appDelegate : AppDelegate? = UIApplication.sharedApplication().delegate as? AppDelegate
	let item = self.mutableSetValueForKey(Contests.Constants.relatedPrize)
	for prize in prizes{
		item.addObject(prize)
	}
	// 変更保存
	appDelegate?.saveContext()
	
	
#2. Core Dataへの具体的な操作
##1. Fetch
* setReturnsObjectsAsFaultsとは？  
フェッチ要求をする前にNSFetchRequestのインスタンスで呼び出すメソッドであり、管理オブジェクトがフォールトの形で返されないよう指定可能。  

 フォールト：まだ完全に実態化していない管理オブジェクトや、関係のコレクションオブジェクトを表す、プレースホルダのことである。
管理オブジェクトが「フォールト」であるといった使い方をする。これの意味は、そのプロパティ値を外部データストアからまだ読み込んでいない状態のことです。フォールティングによって、アプリケーションのメモリ消費量を削減できる。詳しくは[フォールティングと一意化](https://developer.apple.com/jp/documentation/CoreData.pdf)を参照。

##2. mergeChangesFromContextDidSaveNotificationの利用方法
###利用例：
	notification = NSManagedObjectContextDidSaveNotification
	[managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
	
他のスレッドで変更削除したNSManagedObjectCotext(データの検索、挿入更新削除や Undo Redo を行うクラス)をマージポリシー(後述)に沿ってMainThreadのNSMangaedObjectContextにマージしてもらうためのメソッド。
マージポリシーはメインスレッドではなく別スレッドのNSManagedObjectContextに下記のように設定する。

	// [マージポリシー]変更した方（別スレッド）優先
	[{NSManagedObjectContext} setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];

#3 CoreDataのマルチスレッド
　Mangaed Object Contextはスレッドセーフではないため、Core Dataを複数スレッドで同時に利用したりバックグラウンドスレッドで使用するには、対応が必要。詳細は[Core Data Programming Guide - Concurrency with Core Data]()。
具体的には、スレッドごとにすべて同じPersistent Store Coordinator（一般的にAppdelegateで定義されている）がセットされているNSManageObjectContextを用意する必要がある。NSManagedObjectContextは親子関係を定義することができ、save:メソッドで親コンテキストに対して通知されマージされます。つまり、子コンテキストへの変更はsaveを呼ばない限り破棄可能となっている。


また、saveの保存処理の完了はNSManagedObjectContextDidSaveNotificationという通知によって知ることができる。  

	// Register for context save changes notification
    NSNotificationCenter *notify = [NSNotificationCenter defaultCenter];
    [notify addObserver:self 
               selector:@selector(mergeChanges:) // mergeChagnesは自分で定義
                   name:NSManagedObjectContextDidSaveNotification 
                 object:newMoc];





	
#4. NSFetchedResultsController
CoreDataのデータとUITableViewを結合させる。
生成されたインスタンスはUITableViewを使うこと前提のオブジェクトのため、sectionやrowにアクセスしやすいという利点がある

NSFetchRequestを作りNSManagedObjectContextからデータを取得するのが通常のCoreDataの利用方法だが、NSFetchedResultsControllerを使うとその部分をラップしてくれる。
## 利用方法
1. NSFetchRequest作成
2. NSFetchedResultsControllerをinitWithFetchRequestメソッドで作成  
	(id)initWithFetchRequest:(NSFetchRequest *)fetchRequest  
    		managedObjectContext:(NSManagedObjectContext *)context  
      		sectionNameKeyPath:(NSString *)sectionNameKeyPath // セクション分けされる条件となる(データベースのコラム名？)  
      		cacheName:(NSString *)name // キャッシュのデータベース名

	##1. controllerDidChangeContent
	NSFetchedResultsControllerDelegateのメソッドであり、NSFetchedResultsControllerからのコールバックを受け取るための
	ソッド。NSManagedObjectCOntextに対する操作を監視することができる。他の下記メソッドとの違いは、呼び出されるタイミングであ
	このメソッドは下記の通り操作終了時に呼び出される。そのため、例えば100件変更ごとにテーブルに反映するなどの処理をここに記述す
	ことが一般的な使われ方となっている。他のメソッドも大抵はUITableViewへの操作のために利用されることが多い。
	
	* controllerWillChangeContent:
	* controller:didChangeObject:atIndexPath:forChangeType:newIndexPath:　変更ごとに反映する処理用
	* controller:didChangeSection:atIndex:forChangeType:
	* controllerDidChangeContent:　まとまった処理用

	このDelegateメソッドは上記のmergeChangesFromContextDidSaveNotificationでも呼ばれる。

	

#5. SwiftのUITestについて
Unit Test実施時に、UIApplication.sharedApplication().delegateを呼び出しas!もしくはas?でAppDelegateにキャストする場合、ネームスペースの関係上、下記のようにしないとエラーでテストが実行できない

1. AppDelage.swiftのTargetMemberから(アプリ名)Testsと(アプリ名)UITestsのチェックを外すまたは外れていることを確認する
　・調査した限りではAppDelegate classとmethodをpublicにする必要があるとの記述が多かったが、しなくても実施できることを確認。


#6.iOSの実機のネットワーク速度を遅くする方法（低速化)
　http://qiita.com/yimajo/items/efd3a033ac42afd93714  
　実機を利用していれば通信を制限できる。  
　設定方法：Setting -> Development -> NETWORK LINK CONDITION -> Status    
   - "100% Loss"：通信がタイムアウト
   - "Edge"；0.31Mbpsで3Gより低く
   - "DSL"；2.24Mbpsで3Gより高く
   - "High Latency DNS"：Wifiとほぼ同じ
   - "Very Bad Netowrk"：試した限り接続ができない状態


#7. ネットワーク通信
1. NSURLSession(iOS7〜)  
バックグラウンドで通信できるクラス。大きなデータをバックグラウンドで通信して取得できる。NSURLConnectionとは違い汎用的ではなく、FTPなどの通信プロトコルには対応していない。  

	* HTTPMaximumConnectionsPerHost  
	ホストに対しての同時接続の上限。バックグラウンドで実行される非同期の通信で重複するので、 ホストに対しての上限をこのプロパティで調整することが可能。
	* allowsCellularAccess  
セルラーアクセスが可能かどうか設定可能。Wifi接続ではなく3Gとか4Gとか。
	* timeoutIntervalForRequest  
	リクエスト毎のタイムアウトと判断する閾値の設定。デフォルトは60秒。
  

2. NSURLConnection  
WebサーバーやファイルサーバーなどのデータソースからURLを指定してデータを非同期で取得することができるクラス。
これによって通信処理中、UIThreadを邪魔せずに通信処理を書くことが可能。利用する流れは以下のようになる。

	1. NSURLRequest生成：通信先のウRLやタイムアウトなどの設定はここで実施。デリゲートもここで設定。
	2. NSURLRespinseの受信：ステータスコードやHTTPヘッダなどのレスポンス。デリゲードメッソドの引数として渡される。

	
	
#8. Cookieの処理
UIWebViewやHTTPRequestではNSHTTPCookieStorageが管理しているCookieを共有して使うことができる。しかし、UIWebViewでCookieを一度NSHTTPCookieStorageに保存したとしても、アプリが終了するとそれらは削除されてしまう。そのため、下記のような保存処理を実施する必要がある[[参考](http://tech-gym.com/2011/10/objective-c/506.html)]。

	- (void)loadCookie{
    	NSData *cookiesData = [[NSUserDefaults standardUserDefaults]
                           objectForKey:SavedHTTPCookiesKey];
    	if (cookiesData) {
     	   NSLog(@"load cookies");
     	   NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
     	   for (NSHTTPCookie *cookie in cookies)
     	       [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    	}
	}
　
	
	- (void)saveCookie{
    
    	// Save the cookies to the user defaults
    	NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject:
       	                    [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    	[[NSUserDefaults standardUserDefaults] setObject:cookiesData
       	                                       forKey:SavedHTTPCookiesKey];

	}


それぞれを下記に埋め込む。
loadCookie - AppDelegateクラスのdelagateメソッドのdidFinishLaunchingWithOptions
saveCookie - AppDelegateクラスのdelagateメソッドのapplicationDidEnterBackground and applicationWillTerminate

#9. 並行処理
	// サブスレッドで処理させる
	let qualityOfServiceClass = DISPATCH_QUEUE_PRIORITY_DEFAULT
	let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
	dispatch_async(backgroundQueue, {
		// ここにバックグランド処理記述
	})
	
	// メインスレッドで処理させる
	dispatch_async(dispatch_get_main_queue(), {
	})



#10. データ保存
iOSではデータは基本的にフラッシュドライブに保存します。また、フラッシュドライブにある領域は大きく、  

 - アプリ領域
 - ＯＳ領域
 - 共有領域

 があり、主に使用するのは「アプリ領域」である。  
 アプリで参照できるのはアプリごとに割り振られたホームディレクトリ(/Applications/<GUID>/)です。ホームディレクトリにはさらにいくつかディレクトリに分かれており、それぞれ目的が異なります。
 
 - /アプリ名.app - メインハンドル。アプリ自体のリソースファイルを保存する。アプリ名= [[NSBundle mainBundle] bundlePath]
 - /Documents - アーカイブなどファイル単位で永続化する場合に使用
 - /Library/Caches/ - キャッシュ領域
 - /Library/Preferences - アプリケーションの設定情報を保存。NSUserDefaultsで使用
 - /tmp - 一時ファイル保存場所
 
 ホームディレクトリ以下へのアクセス

		NSArray *paths = NSSearchPathForDirectoriesInDomains([ディレクトリタイプ],
		 	NSUserDomainMask/NSDocumentDirectory/NSCachesDirectory, YES);
	

結局は下記３つの方法で保存することになるかな？

 1. a
 2. NSUserDefaults
 3. CoreData

 		
 		// 該当アプリで設定したNSUserDefaultsの一覧取得 
		NSDictionary *dict = [NSUserDefaults.standardUserDefaults
		 persistentDomainForName:NSBundle.mainBundle.bundleIdentifier];
		NSLog(@"Defaults: %@", dict);

 



