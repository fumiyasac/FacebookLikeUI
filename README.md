# FacebookLikeUI
[ING]FacebookみたいなUIをライブラリなしで作ってみるプラクティス（レイアウト3種ほど）

こちらはFacebookやTwitterのアプリの中でUI表現や気になった部分をトレースしてDIYをしたサンプルになります。
特に今回は画像の見せ方や動き・レイアウトの部分を中心にピックアップしてみました。

#### 主な動きの一覧

+ サムネイル画像の一覧表示の際に画像の枚数に応じてタイル表示部分の大きさを変更するレイアウトと画面遷移関連
+ 自分のフォトライブラリーに登録されている画像の一覧を取得してUICollectionViewに表示する
+ 横方向にカード型のUICollectionViewを配置しスクロールすると表示対象のセルが中央に表示される

#### 画面キャプチャその1

![今回のサンプルの画面一覧その1](https://qiita-image-store.s3.amazonaws.com/0/17400/11798ef0-e2f3-4c62-6ee5-cd4bd82d61d6.jpeg)

#### 画面キャプチャその2

![今回のサンプルの画面一覧その2](https://qiita-image-store.s3.amazonaws.com/0/17400/8eb25fa9-8a60-c0cd-3a18-8591b3eb0ff5.jpeg)

#### 画像サムネイルのタイル状レイアウト表示のパターン

タイル状のUI表現をする際には、様々な手法があるかと思いますが、今回は複雑な段違いのサムネイルレイアウトをするためにAutoLayoutの制約を利用して1枚のセルの中で完結するようにしました。
InterfaceBuilderでの設定とコードを組み合わせた実装になっています。（それぞれのUIImageViewの幅と高さはAutoLayoutの制約を計算で出しています）

__1. 画像が1枚または2枚の場合:__

![画像が1枚または2枚の場合](https://qiita-image-store.s3.amazonaws.com/0/17400/39f11ff9-1ea4-881f-8c4e-a459bb661c75.jpeg)

__2. 画像が3枚または4枚の場合:__

![画像が3枚または4枚の場合](https://qiita-image-store.s3.amazonaws.com/0/17400/5d914968-e65a-b925-0950-33590ef75bf5.jpeg)

__3. 画像が5枚または6枚以上の場合:__

![画像が5枚または6枚以上の場合](https://qiita-image-store.s3.amazonaws.com/0/17400/f9fc27b3-0a6d-a331-1062-e6e49b3889b6.jpeg)

__参考. Xib(MainContentsCell.xib)内における全体のUIパーツ配置の参考:__

![配置](https://qiita-image-store.s3.amazonaws.com/0/17400/05cf1bf1-9529-5b68-0aa6-6d097e0397ce.png)

レイアウトやその他要素の配置に関することに関しては下記のQiita記事にポイント並びに手順をまとめてありますので、ご確認頂ければ幸いです。
また、是非とも実機などがおありの場合はインストールをして挙動や振る舞いをご確認いただければと思います。

(Qiita) http://qiita.com/fumiyasac@github/items/3be1344255b3ebb9f416
