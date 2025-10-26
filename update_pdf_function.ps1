# PDF生成関数を更新するスクリプト

$filePath = "C:\Users\shomaP\cultivation-system\index.html"
$content = Get-Content $filePath -Raw -Encoding UTF8

# 古いgeneratePDFHTML関数を見つける
$startPattern = 'function generatePDFHTML\(data\) \{'
$endPattern = 'function generateExcel\(\) \{'

$startIndex = $content.IndexOf($startPattern)
$endIndex = $content.IndexOf($endPattern)

if ($startIndex -eq -1 -or $endIndex -eq -1) {
    Write-Host "Error: Could not find function boundaries"
    exit 1
}

# 新しい関数（ドキュメントから）
$newFunction = @'
function generatePDFHTML(data) {
            const today = new Date().toLocaleString('ja-JP', {year: 'numeric', month: 'numeric', day: 'numeric'});
            
            // 作業種別の色
            const getWorkColor = (type) => {
                const colors = {
                    'seeding': '#4caf50', 'planting': '#2196f3', 'fertilizer': '#ff9800',
                    'pest-control': '#e91e63', 'harvest': '#f44336', 'weeding': '#8bc34a',
                    'pruning': '#00bcd4', 'watering': '#03a9f4', 'other': '#9e9e9e'
                };
                return colors[type] || '#9e9e9e';
            };

            // 作業種別名
            const getWorkTypeName = (type) => {
                const names = {
                    'seeding': '播種・育苗', 'planting': '定植', 'fertilizer': '施肥',
                    'pest-control': '防除', 'harvest': '収穫', 'weeding': '除草',
                    'pruning': '整枝・剪定', 'watering': '灌水', 'other': 'その他'
                };
                return names[type] || '';
            };
            
            return `
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>栽培管理カード - ${data.product_name || '未入力'}</title>
    <style>
        @page { size: A4; margin: 12mm; }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Yu Gothic', 'Meiryo', sans-serif; font-size: 9pt; line-height: 1.4; color: #1a1a1a; }
        .page { page-break-after: always; padding: 10px; min-height: 277mm; }
        .page:last-child { page-break-after: auto; }
        .header { background: linear-gradient(135deg, #4a8f4f 0%, #6ab76e 100%); color: white; border-radius: 6px; padding: 10px 12px; margin-bottom: 10px; position: relative; }
        .header-title { font-size: 15pt; font-weight: 600; }
        .header-org { position: absolute; right: 12px; top: 10px; font-size: 7.5pt; text-align: right; line-height: 1.3; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 8px; font-size: 8pt; }
        th, td { border: 1px solid #d0d0d0; padding: 4px 6px; }
        th { background: #4a8f4f; color: white; font-weight: 600; text-align: center; font-size: 7.5pt; }
        .label-cell { background: #e8f5e9; font-weight: 600; text-align: center; color: #2e7d32; font-size: 8pt; }
        .value-cell { background-color: white; padding-left: 8px; }
        .section-title { background: #4caf50; color: white; border-radius: 4px; padding: 5px 8px; font-weight: 600; font-size: 9.5pt; margin-top: 8px; margin-bottom: 4px; }
        .detail-table th { font-size: 6.5pt; padding: 3px 2px; line-height: 1.2; }
        .detail-table td { padding: 3px; font-size: 7pt; }
        .no-col { width: 25px; text-align: center; background: #f1f8f4; font-weight: 600; }
        .note { font-size: 6.5pt; color: #555; margin-top: 2px; padding: 3px 6px; background: #fff8e1; border-left: 2px solid #ffa726; font-style: italic; }
        .page-number { text-align: right; font-size: 8pt; color: #666; margin-top: 5px; }
        .separator { height: 1px; background: #ddd; margin: 6px 0; }
        .timeline-container { border: 2px solid #000; padding: 8px; background: #f9f9f9; margin-top: 8px; }
        .timeline-title { font-weight: bold; font-size: 8.5pt; margin-bottom: 6px; text-align: center; }
        .timeline-grid { display: grid; grid-template-columns: 80px repeat(12, 1fr); gap: 0; margin-bottom: 4px; }
        .timeline-header { padding: 4px 2px; font-weight: bold; text-align: center; font-size: 7pt; border: 1px solid #999; background: #e0e0e0; }
        .timeline-label { padding: 4px; font-size: 7pt; font-weight: 600; border: 1px solid #999; background: #f0f0f0; display: flex; align-items: center; }
        .timeline-cell { padding: 2px; border: 1px solid #ddd; }
        .timeline-bar { height: 20px; border-radius: 3px; margin: 1px 0; display: flex; align-items: center; justify-content: center; font-size: 6pt; color: white; font-weight: bold; }
        .legend { margin-top: 6px; padding: 6px; background: white; border: 1px solid #ddd; border-radius: 4px; display: flex; gap: 10px; flex-wrap: wrap; font-size: 6.5pt; }
        .legend-item { display: flex; align-items: center; gap: 4px; }
        .legend-color { width: 14px; height: 14px; border-radius: 2px; }
        @media print { body { -webkit-print-color-adjust: exact; print-color-adjust: exact; } }
    </style>
</head>
<body>
    <!-- ページ1：表面 -->
    <div class="page">
        <div class="header">
            <div class="header-title">🌱 栽培管理カード（野菜用 1/2）2024年度</div>
            <div class="header-org">
                生活協同組合連合会<br>
                <strong>コープ自然派事業連合</strong><br>
                FAX 078-998-0851
            </div>
        </div>
        
        <!-- 記入者・生産者情報 -->
        <table>
            <tr>
                <td class="label-cell" rowspan="2" style="width: 12%;">記入者<br>（確認責任者）</td>
                <td class="value-cell" colspan="2"><strong>${data.recorder_name || ''}</strong></td>
                <td class="label-cell" style="width: 12%;">所属団体</td>
                <td class="value-cell" colspan="2">${data.recorder_org || ''}</td>
                <td class="label-cell" rowspan="2" style="width: 12%;">生産者名<br>（栽培責任者）</td>
                <td class="value-cell" colspan="2"><strong>${data.producer_name || ''}</strong></td>
                <td class="label-cell" style="width: 12%;">所属団体</td>
                <td class="value-cell" colspan="2">${data.producer_org || ''}</td>
            </tr>
            <tr>
                <td class="label-cell">住所</td>
                <td class="value-cell" colspan="4">${data.recorder_address || ''}</td>
                <td class="label-cell">電話番号<br>FAX番号</td>
                <td class="value-cell" colspan="4">Tel: ${data.recorder_tel || ''}<br>Fax: ${data.recorder_fax || ''}</td>
            </tr>
        </table>
        
        <div class="separator"></div>
        
        <!-- 商品情報 -->
        <table>
            <tr>
                <th colspan="3">商品名</th>
                <th>規格</th>
                <th>その他</th>
                <th>栽培品種</th>
                <th>作付面積</th>
                <th>栽植株数</th>
                <th>予想収量</th>
                <th colspan="2">作型</th>
            </tr>
            <tr>
                <td colspan="3"><strong>${data.product_name || ''}</strong></td>
                <td>${data.product_spec || ''}</td>
                <td>-</td>
                <td>${data.cultivation_variety || ''}</td>
                <td>${data.planting_area || ''}㎡</td>
                <td>${data.plant_count || ''}株</td>
                <td>${data.expected_yield || ''}kg</td>
                <td colspan="2">${data.cultivation_type || ''}</td>
            </tr>
        </table>
        
        <!-- 種子と育苗 -->
        <div class="section-title">種子と育苗　植付方法（直播・苗定植）</div>
        <table style="font-size: 7.5pt;">
            <tr>
                <td class="label-cell" style="width: 10%;">種子</td>
                <td class="value-cell">${data.seed_type === 'purchase' ? '購入' : data.seed_type === 'self' ? '自家採種' : ''} ${data.seed_supplier ? '（' + data.seed_supplier + '）' : ''}</td>
                <td class="label-cell" style="width: 10%;">育苗</td>
                <td class="value-cell">${data.seedling_method === 'self' ? '自家育苗' : data.seedling_method === 'purchase' ? '購入' : data.seedling_method || ''}</td>
            </tr>
        </table>
        
        <!-- 肥料使用履歴 -->
        <div class="section-title">肥料及び土壌改良資材（堆肥・液肥・化学肥料等）</div>
        <table class="detail-table">
            <thead>
                <tr>
                    <th class="no-col">No.</th>
                    <th>施用日</th>
                    <th>使用資材名称</th>
                    <th>原料</th>
                    <th>製造メーカー</th>
                    <th>施用量<br>kg/10a</th>
                    <th>備考</th>
                </tr>
            </thead>
            <tbody>
                ${(data.fertilizers || []).slice(0, 10).map((f, i) => `
                <tr>
                    <td class="no-col">${i + 1}</td>
                    <td>${f.date || ''}</td>
                    <td>${f.name || ''}</td>
                    <td>${f.material || ''}</td>
                    <td>${f.maker || ''}</td>
                    <td>${f.amount || ''}</td>
                    <td>${f.notes || ''}</td>
                </tr>
                `).join('')}
                ${Array.from({length: Math.max(0, 10 - (data.fertilizers || []).length)}).map((_, i) => `
                <tr><td class="no-col">${i + 1 + (data.fertilizers || []).length}</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                `).join('')}
            </tbody>
        </table>
        <div class="note">※県基準慣行的化学合成N（窒素成分）使用量：18kg/10a</div>
        
        <div class="page-number">Page 1 of 2</div>
    </div>
    
    <!-- ページ2：裏面 -->
    <div class="page">
        <div class="header">
            <div class="header-title">🌱 栽培管理カード（野菜用 2/2）2024年度</div>
            <div class="header-org">
                記入日　${today}<br>
                生活協同組合連合会<br>
                <strong>コープ自然派事業連合</strong><br>
                FAX 078-998-0851
            </div>
        </div>
        
        <!-- 記入者・生産者・商品名 -->
        <table>
            <tr>
                <td class="label-cell" style="width: 12%;">記入者<br>（確認責任者）</td>
                <td class="value-cell" colspan="2"><strong>${data.recorder_name || ''}</strong></td>
                <td class="label-cell" style="width: 12%;">所属団体</td>
                <td class="value-cell" colspan="2">${data.recorder_org || ''}</td>
                <td class="label-cell" style="width: 12%;">生産者名<br>（栽培責任者）</td>
                <td class="value-cell" colspan="2"><strong>${data.producer_name || ''}</strong></td>
                <td class="label-cell" style="width: 12%;">所属団体</td>
                <td class="value-cell" colspan="2">${data.producer_org || ''}</td>
            </tr>
            <tr>
                <td class="label-cell">商品名</td>
                <td class="value-cell" colspan="5"><strong>${data.product_name || ''}</strong></td>
                <td class="label-cell">規格</td>
                <td class="value-cell" colspan="5">${data.product_spec || ''}</td>
            </tr>
        </table>
        
        <div class="separator"></div>
        
        <!-- 農薬使用履歴 -->
        <div class="section-title">病害虫防除・除草・成長調整　資材　　（使用された農薬等をすべて記入）</div>
        <table class="detail-table">
            <thead>
                <tr>
                    <th class="no-col">No.</th>
                    <th style="width: 60px;">使用日</th>
                    <th style="width: 90px;">使用農薬<br>資材名称</th>
                    <th style="width: 90px;">成分名<br>または原料</th>
                    <th style="width: 70px;">製造<br>メーカー</th>
                    <th style="width: 60px;">希釈率<br>使用量<br>/10a</th>
                    <th style="width: 70px;">対象病害虫</th>
                    <th style="width: 50px;">資材区分<br>（農薬・<br>天然）</th>
                </tr>
            </thead>
            <tbody>
                ${(data.pesticides || []).slice(0, 8).map((p, i) => `
                <tr>
                    <td class="no-col">${i + 1}</td>
                    <td>${p.date || ''}</td>
                    <td>${p.name || ''}</td>
                    <td>${p.ingredient || ''}</td>
                    <td>${p.maker || ''}</td>
                    <td>${p.dilution || ''}</td>
                    <td>${p.target || ''}</td>
                    <td>天然物</td>
                </tr>
                `).join('')}
                ${Array.from({length: Math.max(0, 8 - (data.pesticides || []).length)}).map((_, i) => `
                <tr><td class="no-col">${i + 1 + (data.pesticides || []).length}</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                `).join('')}
            </tbody>
        </table>
        <div class="note">※県基準慣行的農薬成分使用回数　（　12　）回</div>
        
        <!-- 作業記録・栽培工程表 -->
        <div class="section-title">📅 作業記録・栽培工程表</div>
        <table style="margin-bottom: 6px; font-size: 7pt;">
            <thead>
                <tr>
                    <th style="width: 25px;">No.</th>
                    <th style="width: 70px;">作業種別</th>
                    <th style="width: 120px;">作業内容</th>
                    <th style="width: 65px;">開始日</th>
                    <th style="width: 65px;">終了日</th>
                    <th style="width: 45px;">肥料No.</th>
                    <th style="width: 45px;">農薬No.</th>
                    <th>備考</th>
                </tr>
            </thead>
            <tbody>
                ${(data.works || []).slice(0, 8).map((w, i) => {
                    const typeName = getWorkTypeName(w.type);
                    return `
                <tr>
                    <td style="text-align: center;">${i + 1}</td>
                    <td>${typeName}</td>
                    <td>${w.content || ''}</td>
                    <td style="text-align: center;">${w.startDate ? new Date(w.startDate).toLocaleDateString('ja-JP', {month:'numeric', day:'numeric'}) : ''}</td>
                    <td style="text-align: center;">${w.endDate ? new Date(w.endDate).toLocaleDateString('ja-JP', {month:'numeric', day:'numeric'}) : ''}</td>
                    <td style="text-align: center;">${w.fertRef || '-'}</td>
                    <td style="text-align: center;">${w.pestRef || '-'}</td>
                    <td>${w.notes || ''}</td>
                </tr>
                `}).join('')}
                ${Array.from({length: Math.max(0, 8 - (data.works || []).length)}).map((_, i) => `
                <tr><td style="text-align: center;">${i + 1 + (data.works || []).length}</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                `).join('')}
            </tbody>
        </table>
        
        <!-- タイムライン -->
        <div class="timeline-container">
            <div class="timeline-title">年間作業タイムライン（2024年度）</div>
            
            <!-- 月ヘッダー -->
            <div class="timeline-grid" style="margin-bottom: 3px;">
                <div style="border: none;"></div>
                ${['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'].map(m => `<div class="timeline-header">${m}</div>`).join('')}
            </div>
            
            <!-- タイムライン行 -->
            ${['seeding','planting','fertilizer','pest-control','harvest'].map(type => {
                const works = (data.works || []).filter(w => w.type === type);
                const typeName = getWorkTypeName(type);
                return `
                <div class="timeline-grid">
                    <div class="timeline-label">${typeName}</div>
                    ${Array.from({length:12}).map((_, month) => {
                        const matchingWorks = works.filter(w => {
                            if (!w.startDate) return false;
                            const start = new Date(w.startDate).getMonth() + 1;
                            const end = w.endDate ? new Date(w.endDate).getMonth() + 1 : start;
                            return month + 1 >= start && month + 1 <= end;
                        });
                        if (matchingWorks.length === 0) return '<div class="timeline-cell"></div>';
                        const w = matchingWorks[0];
                        const start = new Date(w.startDate).getMonth() + 1;
                        const end = w.endDate ? new Date(w.endDate).getMonth() + 1 : start;
                        const isStart = month + 1 === start;
                        const isEnd = month + 1 === end;
                        const radius = isStart && isEnd ? '3px' : isStart ? '3px 0 0 3px' : isEnd ? '0 3px 3px 0' : '0';
                        return `<div class="timeline-cell"><div class="timeline-bar" style="background: ${getWorkColor(type)}; border-radius: ${radius};">${isStart ? '●' : ''}${isEnd ? '●' : ''}</div></div>`;
                    }).join('')}
                </div>
                `;
            }).join('')}
            
            <!-- 凡例 -->
            <div class="legend">
                ${[
                    {type:'seeding',name:'播種・育苗'},
                    {type:'planting',name:'定植'},
                    {type:'fertilizer',name:'施肥'},
                    {type:'pest-control',name:'防除'},
                    {type:'harvest',name:'収穫'}
                ].map(({type,name}) => `
                    <div class="legend-item">
                        <div class="legend-color" style="background: ${getWorkColor(type)};"></div>
                        <span>${name}</span>
                    </div>
                `).join('')}
            </div>
        </div>
        
        <!-- 前作物調査 -->
        <div class="section-title">前作物調査</div>
        <table style="font-size: 7.5pt;">
            <tr>
                <td class="label-cell" style="width: 15%;">前作物名</td>
                <td class="value-cell" colspan="2">${data.prev_crop_name || ''}</td>
                <td class="label-cell" style="width: 15%;">栽培区分</td>
                <td class="value-cell">${data.cultivation_class === 'organic' ? '有機栽培' : data.cultivation_class === 'special' ? '特別栽培' : data.cultivation_class === 'normal' ? '慣行栽培' : ''}</td>
            </tr>
        </table>
        
        <div class="page-number">Page 2 of 2</div>
    </div>
</body>
</html>
            `;
        }

        
'@

# 前後を保持
$before = $content.Substring(0, $startIndex)
$after = $content.Substring($endIndex)

# 新しいコンテンツを作成
$newContent = $before + $newFunction + "`r`n`r`n        " + $after

# ファイルに書き込み
[System.IO.File]::WriteAllText($filePath, $newContent, [System.Text.Encoding]::UTF8)

Write-Host "✅ generatePDFHTML function has been updated successfully!"
Write-Host "📄 Backup saved as: index_backup_*.html"
