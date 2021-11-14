## VsCodeプラグイン
Git Graph

## 作業ディレクトリを作成
適当な場所に・・・work

## クローン
作成した作成ディレクトリにクローン
git clone git@github.com:kakuta2/trailhead.git

## VsCode
### 作業ディレクトリ(例だとworkフォルダ)をVSCODEで開く
Ctrl+Shift+p
SFDX:プロジェクトを作成
標準
プロジェクト名：(クローンしてきたフォルダ名。例だとtrailhead)

指定されたプロジェクト名は選択したディレクトリ上にすでに存在します。
上書きしてもよろしいですか？
上書き
→SFプロジェクトが作成される
　.gitignoreに下記を追加してメタファイル以外のファイルをGitで無視させる
これで左バーの「ソース管理」の差分が消える(はず)
```
.eslintignore
.forceignore
.prettierignore
.prettierrc
jest.config.js
package.json
sfdx-project.json
.vscode
.husky
config/project-scratch-def.json
```


## SF組織の認証
Ctrl+Shift+p
SFDX:組織を認証

## SFの組織からソースを取得(リトリーブ)
マニフェストファイル(manifest/package.xml)を右クリック
SFDX:マニフェストファイルのソースを組織から取得

左バーの「ソース管理」の差分を確認
自分と関係ない変更がされている場合があるので
自分と関係ない変更は必要に応じて「変更を破棄」


## ブランチを作成
「...」→ブランチ→分岐の作成→<ブランチ名：課題名>
左下のブランチ名を確認


## プルリクでコンフリクトがあることが表示された場合
(プルリクでも表示、解決できるが)ここではVsCodeにてコンフリクトの状態を再現させる
プルリクでマージ先に指定しているブランチをチェックアウト
→プルしてローカルをリモートと同じ状態にする
課題のブランチをチェックアウト
ブランチをマージ
　→マージ元：マージ先に指定しているブランチ

