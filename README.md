# 古武道 動画ライブラリ

部員がログインして動画URL・説明・コメントを共有する静的Webアプリです。画面はHTML/CSS/JavaScriptのまま、認証と共有データにSupabaseを使用します。

## 初期設定

1. Supabaseでプロジェクトを作成します。
2. SupabaseのSQL Editorで `supabase/schema.sql` の内容を実行します。
3. SupabaseのAuthentication設定でメールによるサインアップを有効にします。メール確認を有効にすると、登録後に届く確認メールからログインできます。
4. SupabaseのProject URLと公開用の `anon` キーを `config.js` に設定します。

```js
window.KOBUDO_SUPABASE_CONFIG = {
  url: "https://プロジェクトID.supabase.co",
  anonKey: "公開用anonキー",
};
```

`anon` キーはブラウザーに配布される公開キーです。`service_role` キーなどの秘密鍵は絶対に設定しないでください。アクセス制御はデータベースのRLSポリシーで行います。

サインアップが有効な間は、リンクを知っている人が誰でも部員アカウントを作成できます。部員だけに限定したい場合は、Supabase側で公開サインアップを無効にし、管理者がユーザーを招待・作成する運用にしてください。

カテゴリは全ログインユーザーで共有され、画面の「＋ カテゴリを追加」からいつでも追加できます。既存の5カテゴリはそのまま引き継がれ、新しいカテゴリは追加順に番号付きで表示されます。カテゴリは「削除」から削除できますが、動画または階層があるカテゴリと最後の1つは削除できません。動画は全ログインユーザーが編集でき、削除は投稿者本人のみ可能です。既存のSupabaseプロジェクトに適用する場合も、更新した `supabase/schema.sql` をSQL Editorで再実行してください（カテゴリの追加・削除権限と、全メンバーの動画編集権限を設定します）。

## ローカルで確認

VS CodeのLive Serverなどで `index.html` を開きます（例: `http://127.0.0.1:5500`）。`file://` で直接開くのではなく、HTTPサーバーを使ってください。SupabaseのAuthentication設定にあるURL ConfigurationのRedirect URLsへ、実際に使うローカルURL（例: `http://127.0.0.1:5500/**`）を追加します。サインアップ確認メールは、開いているアプリのURLへ戻ります。

## 公開

`index.html`、`config.js`、`supabase/schema.sql` を含むフォルダーをCloudflare Pagesなどの静的ホスティングに配置します。公開後はSupabase AuthenticationのURL設定でサイトURLとリダイレクトURLを設定してください。

動画ファイルは保存せず、YouTubeのURLを登録します。現在の保存データ（ブラウザーのlocalStorage）は新しい共有データベースには自動移行されません。
