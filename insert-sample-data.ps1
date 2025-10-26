# 栽培履歴管理システム - PowerShellサンプルデータ挿入スクリプト
# 使い方: .\insert-sample-data.ps1 -Count 3

param(
    [int]$Count = 1
)

# APIのベースURL
$ApiUrl = $env:API_URL ?? "http://localhost:3000/api/records"

# 農家名のリスト
$Farmers = @("山田太郎", "佐藤花子", "鈴木次郎", "佐々木美咲")
$Products = @("ミニトマト", "キャベツ", "ニンジン", "ナス", "キュウリ")
$Organizations = @("○○農園", "△△ファーム", "□□営農")

function Get-RandomDate {
    param([int]$DaysAgo)
    (Get-Date).AddDays($DaysAgo) | Get-Date -Format "yyyy-MM-dd"
}

function GenerateSampleData {
    param([int]$Index)

    $today = Get-Date
    $startDate = $today.AddMonths(-3)

    $farmerName = $Farmers[$Index % $Farmers.Count]
    $productName = $Products[$Index % $Products.Count]
    $org = $Organizations[$Index % $Organizations.Count]

    $varietyMap = @{
        "ミニトマト" = "アイコ"
        "キャベツ" = "寒玉"
        "ニンジン" = "標準品種"
        "ナス" = "長ナス"
        "キュウリ" = "青くん"
    }

    $fertilizers = @(
        @{
            date = $startDate | Get-Date -Format "yyyy-MM-dd"
            name = "牛糞堆肥"
            material = "牛糞"
            maker = "農産物センター"
            amount = Get-Random -Minimum 200 -Maximum 500
            notes = "基肥"
        },
        @{
            date = $startDate.AddDays(30) | Get-Date -Format "yyyy-MM-dd"
            name = "ニーム油かす"
            material = "ニーム"
            maker = "有機肥料協会"
            amount = Get-Random -Minimum 100 -Maximum 300
            notes = "追肥1回目"
        },
        @{
            date = $startDate.AddDays(60) | Get-Date -Format "yyyy-MM-dd"
            name = "鶏糞肥料"
            material = "鶏糞"
            maker = "自然派肥料"
            amount = Get-Random -Minimum 50 -Maximum 200
            notes = "追肥2回目"
        }
    )

    $pesticides = @(
        @{
            date = $startDate.AddDays(45) | Get-Date -Format "yyyy-MM-dd"
            name = "ニーム油"
            ingredient = "ニーム精油"
            maker = "天然農薬メーカー"
            dilution = "500倍"
            target = "アブラムシ、ハダニ"
        },
        @{
            date = $startDate.AddDays(75) | Get-Date -Format "yyyy-MM-dd"
            name = "木酢液"
            ingredient = "木酢液"
            maker = "自然派"
            dilution = "100倍"
            target = "うどんこ病予防"
        }
    )

    $works = @(
        @{
            type = "seeding"
            content = "温床で育苗開始"
            startDate = $startDate | Get-Date -Format "yyyy-MM-dd"
            endDate = $startDate.AddDays(7) | Get-Date -Format "yyyy-MM-dd"
            fertRef = "1"
            pestRef = "-"
            notes = "気温管理に注意"
        },
        @{
            type = "planting"
            content = "本圃へ定植"
            startDate = $startDate.AddDays(30) | Get-Date -Format "yyyy-MM-dd"
            endDate = $startDate.AddDays(35) | Get-Date -Format "yyyy-MM-dd"
            fertRef = "2"
            pestRef = "-"
            notes = "雨の日を避けて定植"
        },
        @{
            type = "fertilizer"
            content = "追肥施用"
            startDate = $startDate.AddDays(45) | Get-Date -Format "yyyy-MM-dd"
            endDate = $startDate.AddDays(45) | Get-Date -Format "yyyy-MM-dd"
            fertRef = "2"
            pestRef = "1"
            notes = "開花期前の施肥"
        },
        @{
            type = "pest-control"
            content = "病害虫防除"
            startDate = $startDate.AddDays(60) | Get-Date -Format "yyyy-MM-dd"
            endDate = $startDate.AddDays(60) | Get-Date -Format "yyyy-MM-dd"
            fertRef = "-"
            pestRef = "1"
            notes = "アブラムシ防除"
        },
        @{
            type = "harvest"
            content = "初回収穫"
            startDate = $startDate.AddDays(90) | Get-Date -Format "yyyy-MM-dd"
            endDate = $today | Get-Date -Format "yyyy-MM-dd"
            fertRef = "-"
            pestRef = "-"
            notes = "毎日早朝に収穫"
        }
    )

    return @{
        recorder_name = $farmerName
        recorder_org = $org
        recorder_address = "大阪府吹田市${farmerName}地区"
        recorder_tel = "06-$(Get-Random -Minimum 1000 -Maximum 10000)-$(Get-Random -Minimum 1000 -Maximum 10000)"
        recorder_fax = "06-$(Get-Random -Minimum 1000 -Maximum 10000)-$(Get-Random -Minimum 1000 -Maximum 10000)"

        producer_name = $Farmers[($Index + 1) % $Farmers.Count]
        producer_org = $org

        product_name = $productName
        product_spec = "秀品"
        cultivation_variety = $varietyMap[$productName]
        planting_area = Get-Random -Minimum 100 -Maximum 500
        plant_count = Get-Random -Minimum 500 -Maximum 5000
        expected_yield = Get-Random -Minimum 500 -Maximum 2000
        cultivation_type = "促成栽培"

        seed_type = if (Get-Random -Minimum 0 -Maximum 2 -eq 1) { "purchase" } else { "self" }
        seed_supplier = "○○種苗店"
        seedling_method = "self"

        fertilizers = $fertilizers
        pesticides = $pesticides
        works = $works

        prev_crop_name = "キャベツ"
        cultivation_class = "special"
    }
}

function Send-Data {
    param($Data)

    $jsonBody = $Data | ConvertTo-Json -Depth 10

    try {
        $response = Invoke-WebRequest -Uri $ApiUrl `
            -Method POST `
            -Headers @{ "Content-Type" = "application/json" } `
            -Body $jsonBody `
            -UseBasicParsing

        return $response.Content | ConvertFrom-Json
    }
    catch {
        throw $_.Exception.Message
    }
}

# メイン処理
Write-Host "🌱 栽培履歴管理システム - サンプルデータ挿入" -ForegroundColor Green
Write-Host "📝 $Count 個のサンプルデータを作成します`n" -ForegroundColor Yellow

for ($i = 0; $i -lt $Count; $i++) {
    try {
        $data = GenerateSampleData $i

        Write-Host "⏳ [$(($i + 1))/$Count] データを送信中..." -ForegroundColor Cyan
        Write-Host "   - 商品: $($data.product_name)" -ForegroundColor Gray
        Write-Host "   - 記入者: $($data.recorder_name)" -ForegroundColor Gray

        $result = Send-Data $data

        Write-Host "✅ [$(($i + 1))/$Count] 成功! ID: $($result.id)`n" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ [$(($i + 1))/$Count] エラー: $_`n" -ForegroundColor Red
    }
}

Write-Host "🎉 完了！" -ForegroundColor Green
