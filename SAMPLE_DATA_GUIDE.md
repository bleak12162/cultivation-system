# サンプルデータ挿入ガイド

栽培履歴管理システムにサンプルデータを挿入するスクリプトの使用方法です。

---

## 📋 準備

### 1. Vercel CLIのインストール
```bash
npm install -g vercel
```

### 2. APIサーバーの起動
```bash
vercel dev
```
サーバーは **http://localhost:3000** で起動します。

---

## 🚀 実行方法

### **方法1: PowerShell（Windows推奨）**

#### 基本的な使い方
```powershell
# 1個のサンプルデータを作成
.\insert-sample-data.ps1

# 複数個作成（例: 5個）
.\insert-sample-data.ps1 -Count 5
```

#### 実行がうまくいかない場合
```powershell
# 実行ポリシーを一時的に変更
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

# その後、スクリプトを実行
.\insert-sample-data.ps1 -Count 3
```

---

### **方法2: Node.js**

#### 準備
```bash
# fetch APIが標準で使える（Node 18以上）
# またはnode-fetchをインストール
npm install node-fetch
```

#### 実行
```bash
# 1個作成
node insert-sample-data.js

# 複数個作成（例: 5個）
node insert-sample-data.js 5
```

---

## 📊 出力例

PowerShellで実行した場合の出力：

```
🌱 栽培履歴管理システム - サンプルデータ挿入
📝 3 個のサンプルデータを作成します

⏳ [1/3] データを送信中...
   - 商品: ミニトマト
   - 記入者: 山田太郎
✅ [1/3] 成功! ID: 1

⏳ [2/3] データを送信中...
   - 商品: キャベツ
   - 記入者: 佐藤花子
✅ [2/3] 成功! ID: 2

⏳ [3/3] データを送信中...
   - 商品: ニンジン
   - 記入者: 鈴木次郎
✅ [3/3] 成功! ID: 3

🎉 完了！
```

---

## 🎲 生成されるサンプルデータ

各スクリプトは以下のデータを**ランダムに生成**します：

### 記入者情報
- 名前：農家名リストからランダム選択
- 所属団体：農園名からランダム選択
- 住所：大阪府吹田市（農家名付き）
- 電話番号：ランダム生成

### 商品情報
- 商品名：ミニトマト、キャベツ、ニンジン、ナス、キュウリから選択
- 作付面積：100〜500㎡（ランダム）
- 栽植株数：500〜5000株（ランダム）
- 予想収量：500〜2000kg（ランダム）

### 肥料使用履歴
3件の肥料記録を自動生成：
1. 牛糞堆肥（基肥）
2. ニーム油かす（追肥1回目）
3. 鶏糞肥料（追肥2回目）

### 農薬使用履歴
2件の農薬記録を自動生成：
1. ニーム油（アブラムシ・ハダニ防除）
2. 木酢液（うどんこ病予防）

### 作業記録
5つの作業ステップを自動生成：
1. 播種・育苗
2. 定植
3. 施肥
4. 病害虫防除
5. 収穫

---

## 🔧 カスタマイズ

### スクリプトを編集してデータをカスタマイズ

#### PowerShellの場合
```powershell
# 農家名を変更
$Farmers = @("自分の名前", "別の農家名", "...")

# 商品を変更
$Products = @("トマト", "ピーマン", "...")
```

#### Node.jsの場合
```javascript
// farmers, products の配列を編集
const farmers = ['自分の名前', '別の農家名', ...];
const products = ['トマト', 'ピーマン', ...];
```

---

## 🐛 トラブルシューティング

### ❌ エラー: "Unable to connect to API"
- **確認事項**:
  - Vercel CLIが起動しているか？ (`vercel dev` コマンド)
  - http://localhost:3000 にアクセスできるか？

### ❌ エラー: "SyntaxError in JSON"
- **確認事項**:
  - スクリプトが正しく保存されているか？
  - 日本語が文字化けしていないか？（UTF-8エンコーディングを確認）

### ❌ PowerShell実行ポリシーエラー
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```
上記を実行してから、スクリプトを再度実行してください。

---

## 💡 Tips

### 大量にデータを作成したい場合
```powershell
# 100個のサンプルデータを作成
.\insert-sample-data.ps1 -Count 100
```

### 環境変数でAPIのURLを変更
```powershell
# デプロイ済みのVercelアプリに対して実行
$env:API_URL = "https://your-app.vercel.app/api/records"
.\insert-sample-data.ps1 -Count 5
```

---

## 📝 生成されたデータの確認

### ブラウザで確認
1. http://localhost:3000 を開く
2. 「📋 履歴一覧」タブをクリック
3. 作成されたレコードが表示されます

### コマンドラインで確認
```bash
# 全レコードを取得
curl http://localhost:3000/api/records

# 特定のレコード（ID=1）を取得
curl http://localhost:3000/api/records?id=1
```

---

## 🎯 実行フロー図

```
1. vercel dev で APIサーバー起動
   ↓
2. insert-sample-data.ps1 / .js を実行
   ↓
3. スクリプトがサンプルデータ生成
   ↓
4. http://localhost:3000/api/records に POST
   ↓
5. DBにデータが保存される
   ↓
6. ブラウザで確認 (http://localhost:3000)
```

---

作成日: 2024-10-26
