#アニメーションの勉強

##Swiftでのアニメーションの基礎知識
###1. Timerクラスによって一定時間ごとにメソッドを呼び出して直接UIViewの状態を書き換える方法

```
// コードサンプル(Timerを止めたい場合は返り値にtimerを設定すると良い)
private func startMyTimer(){
	let timer:Timer
	timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer:Timer) in
		{Storyboardで定義しているUIViewを操作する処理を記述}
	})
	// タイマーの発火
	timer.fire()
}
```



1. メリット
	- 座標での操作が簡単。あたり判定などが簡単。

		UIKitのクラスメソッドやCoreAnimationの方法では、時間を指定して、始まりと終わりの状態を指定するといった使い方のため、途中で他のオブジェクトの状態が変化したらなどの条件(あたり判定など)を付与するのが難しい(？)。
2. デメリット 
	- 毎時間メソッドが呼ばれるため、カクカクする。
	- Timerのインスタンスを定義する必要があり、Controller内で管理するものが一つ増える。定義しないのも手だが、途中で止めたりできない。
3. 使う上での知っておきたいこと
	- Timer.scheduledTimerはメインスレッド(current run loop in the default mode)で実行される
		
		少しでも重い処理を書くと定期的に呼び出されることもあり、ユーザービリティが低下する。
	- Timerで呼び出されるメソッドには誤差あり

		[公式ドキュメント](https://developer.apple.com/reference/foundation/timer)に書いてあるように50-100 millisecondsの誤差がある

###2. UIKitのクラスメソッド
###3. CoreAnimationの利用


