# ── Colours (RGB as long) ──────────────────────────────────────────────────
function RGB($r,$g,$b){ return [long]($b*65536 + $g*256 + $r) }

$NAVY   = RGB 14  31  61
$ORANGE = RGB 255 105  0
$WHITE  = RGB 255 255 255
$LGRAY  = RGB 244 246 249
$MGRAY  = RGB 107 122 153
$DBLUE  = RGB  18  40  85
$GREEN  = RGB   0 168 107
$TEXT   = RGB  45  58  85
$SUBT   = RGB 143 168 204

# ── Helpers ────────────────────────────────────────────────────────────────
function AddSlide($pres, $layout=12){
    return $pres.Slides.Add($pres.Slides.Count+1, $layout)
}

function BG($slide, $color){
    $slide.Background.Fill.Solid()
    $slide.Background.Fill.ForeColor.RGB = $color
}

function Rect($slide,$l,$t,$w,$h,$fill,$line=$false){
    $s = $slide.Shapes.AddShape(1, $l*72, $t*72, $w*72, $h*72)
    $s.Fill.Solid()
    $s.Fill.ForeColor.RGB = $fill
    if(-not $line){ $s.Line.Visible = $false }
    return $s
}

function TBox($slide,$text,$l,$t,$w,$h,$size,$bold,$color,$align=1,$italic=$false){
    $s = $slide.Shapes.AddTextbox(1, $l*72, $t*72, $w*72, $h*72)
    $tf = $s.TextFrame
    $tf.WordWrap = $true
    $tf.AutoSize = 0
    $p = $tf.TextRange
    $p.Text = $text
    $p.Font.Size = $size
    $p.Font.Bold = $bold
    $p.Font.Italic = $italic
    $p.Font.Color.RGB = $color
    $p.ParagraphFormat.Alignment = $align   # 1=left 2=center 3=right
    return $s
}

# ══════════════════════════════════════════════════════════════════════════
$app = New-Object -ComObject PowerPoint.Application
$app.Visible = $true
$pres = $app.Presentations.Add()
$pres.PageSetup.SlideWidth  = 13.33*72
$pres.PageSetup.SlideHeight = 7.5*72

# ══ SLIDE 1 – Cover ═══════════════════════════════════════════════════════
$s1 = AddSlide $pres
BG $s1 $NAVY

# Left orange accent bar
Rect $s1 0 0 0.12 7.5 $ORANGE | Out-Null

# Tag line
TBox $s1 "PROJECT OVERVIEW  ·  HUMAN-CENTRED DESIGN" 0.45 0.3 12 0.4 10 $true $ORANGE 1 | Out-Null

# Main title
TBox $s1 "Thinking Before Building" 0.45 1.0 10 2.0 52 $true $WHITE 1 | Out-Null

# Subtitle
TBox $s1 "How intentional design — not just code — creates products that truly serve real people." `
    0.45 3.15 8.5 1.1 16 $false $SUBT 1 | Out-Null

# 3 badge pills
$badges = @("📋  Project Description","👤  User Personas","🔀  User Flows")
for($i=0;$i -lt 3;$i++){
    $bx = 0.45 + $i*3.1
    $r = Rect $s1 $bx 4.55 2.9 0.52 (RGB 30 56 107)
    $r.Line.Visible = $true; $r.Line.ForeColor.RGB = $ORANGE; $r.Line.Weight = 1.2
    TBox $s1 $badges[$i] ($bx+0.15) 4.6 2.6 0.42 11 $true $WHITE 1 | Out-Null
}

# Quote strip
Rect $s1 0 7.05 13.33 0.45 (RGB 6 18 38) | Out-Null
TBox $s1 "Start early  ·  Be intentional  ·  Take ownership" 0 7.1 13.33 0.35 10 $false $MGRAY 2 | Out-Null

# ══ SLIDE 2 – What Is This About? ═════════════════════════════════════════
$s2 = AddSlide $pres
BG $s2 $LGRAY
Rect $s2 0 0 13.33 1.35 $NAVY | Out-Null
TBox $s2 "SLIDE 1  ·  THE TOPIC" 0.45 0.15 8 0.35 9 $true $ORANGE 1 | Out-Null
TBox $s2 "What Is This Project About?" 0.45 0.48 12 0.82 34 $true $WHITE 1 | Out-Null

TBox $s2 ("Every day, people struggle with tools that are confusing or not built for them. " +
    "This project is about changing that — by designing digital products that put PEOPLE first, before any line of code is written.") `
    0.45 1.52 12.4 1.1 13.5 $false $TEXT 1 | Out-Null

# 3 cards
$ctitles = @("📋  Clear Project Description","👤  User Personas","🔀  User Flows")
$cbodies = @(
    "Before building anything, explain exactly WHAT you are making, WHO it is for, and WHY it matters — in plain language anyone can understand.",
    "A persona is a portrait of a real type of person who will use your product. We give them a name, a story, and real frustrations so every decision focuses on helping them.",
    "A user flow is a simple map showing the steps someone takes to complete a task. It helps us spot confusion before anything is built."
)
for($i=0;$i -lt 3;$i++){
    $cx = 0.42 + $i*4.3
    $r = Rect $s2 $cx 2.8 4.0 3.9 $WHITE
    Rect $s2 $cx 2.8 4.0 0.1 $ORANGE | Out-Null
    TBox $s2 $ctitles[$i] ($cx+0.18) 2.98 3.65 0.5 13 $true $NAVY 1 | Out-Null
    TBox $s2 $cbodies[$i] ($cx+0.18) 3.52 3.65 2.9 12 $false $TEXT 1 | Out-Null
}

Rect $s2 0 6.9 13.33 0.6 $NAVY | Out-Null
TBox $s2 '"This project is not only about coding — it is about thinking, designing, and building responsibly."' `
    0.4 6.94 13 0.5 10.5 $false $SUBT 2 $true | Out-Null

# ══ SLIDE 3 – The Challenge ════════════════════════════════════════════════
$s3 = AddSlide $pres
BG $s3 $WHITE
Rect $s3 0 0 13.33 1.35 $NAVY | Out-Null
TBox $s3 "SLIDE 2  ·  THE CHALLENGE" 0.45 0.15 8 0.35 9 $true $ORANGE 1 | Out-Null
TBox $s3 "What Problem Are We Solving?" 0.45 0.48 12 0.82 34 $true $WHITE 1 | Out-Null

# Left – problem
Rect $s3 0.35 1.5 5.9 5.15 (RGB 255 244 237) | Out-Null
Rect $s3 0.35 1.5 5.9 0.1 $ORANGE | Out-Null
TBox $s3 "😟  The Reality" 0.55 1.65 5.5 0.5 15 $true $NAVY 1 | Out-Null
$probs = @(
    "Developers start coding without a clear plan",
    "Products get built for the developer, not the user",
    "Teams skip thinking about WHO will use the product",
    "Features are added without understanding real needs",
    "Users end up confused, frustrated, or stop using the product"
)
for($i=0;$i -lt $probs.Length;$i++){
    TBox $s3 ("✗  "+$probs[$i]) 0.55 (2.22+$i*0.81) 5.5 0.76 12 $false (RGB 122 63 26) 1 | Out-Null
}

# Right – consequence
Rect $s3 6.85 1.5 6.1 5.15 (RGB 234 240 255) | Out-Null
Rect $s3 6.85 1.5 6.1 0.1 (RGB 60 103 234) | Out-Null
TBox $s3 "⚠️  What Happens When We Skip Design" 7.05 1.65 5.7 0.5 15 $true $NAVY 1 | Out-Null
$impacts = @(
    "Time wasted rebuilding features that don't work for users",
    "Products that look finished but solve the wrong problem",
    "Poor experience = low adoption and bad impression",
    "Missed chance to create something truly meaningful"
)
for($i=0;$i -lt $impacts.Length;$i++){
    TBox $s3 ("→  "+$impacts[$i]) 7.05 (2.22+$i*1.0) 5.7 0.9 12.5 $false (RGB 30 58 122) 1 | Out-Null
}

# ══ SLIDE 4 – The Solution + Personas ═════════════════════════════════════
$s4 = AddSlide $pres
BG $s4 $LGRAY
Rect $s4 0 0 13.33 1.35 $NAVY | Out-Null
TBox $s4 "SLIDE 3  ·  THE SOLUTION" 0.45 0.15 8 0.35 9 $true $ORANGE 1 | Out-Null
TBox $s4 "Design With Real People in Mind" 0.45 0.48 12 0.82 34 $true $WHITE 1 | Out-Null

# 3 step cards
$snums  = @("01","02","03")
$stitles= @("Write a Clear`nProject Description","Create User`nPersonas","Map the`nUser Journey")
$sbodies= @(
    "In plain words: What does this do? Who is it for? What problem does it solve? Forces clarity before building begins.",
    "Give your users a face and a story. Understand their goals and frustrations — so every feature is built FOR them.",
    "Draw simple step-by-step paths showing how a person reaches their goal. Fix confusing parts on paper — not after building."
)
for($i=0;$i -lt 3;$i++){
    $cx = 0.35 + $i*4.38
    Rect $s4 $cx 1.55 4.1 2.55 $WHITE | Out-Null
    Rect $s4 $cx 1.55 4.1 0.1 $ORANGE | Out-Null
    TBox $s4 $snums[$i] ($cx+0.18) 1.68 1.0 0.65 28 $true $ORANGE 1 | Out-Null
    TBox $s4 $stitles[$i] ($cx+0.18) 2.35 3.75 0.65 13.5 $true $NAVY 1 | Out-Null
    TBox $s4 $sbodies[$i] ($cx+0.18) 3.02 3.75 1.0 11.5 $false $TEXT 1 | Out-Null
}

# Persona title
TBox $s4 "Meet the Users" 0.35 4.38 6 0.45 17 $true $NAVY 1 | Out-Null

# 3 persona cards
$picons = @("👩‍🎓","👨‍💼","👩‍💻")
$pnames = @("Amara, 21","Daniel, 34","Kalisa, 23")
$proles = @("University Student","Freelance Designer","Recent Graduate")
$ptraits = @(
    "Overwhelmed by deadlines`nNeeds simple task tracking`nUses her phone for everything",
    "Juggles multiple client projects`nLoses track of what is pending`nWants clarity, not complexity",
    "Starting a new job`nBuilding good habits from day one`nValues clean, intuitive tools"
)
for($i=0;$i -lt 3;$i++){
    $px = 0.35 + $i*4.38
    Rect $s4 $px 4.88 4.1 2.42 $WHITE | Out-Null
    Rect $s4 $px 4.88 4.1 0.09 $GREEN | Out-Null
    TBox $s4 $picons[$i] ($px+0.18) 4.98 0.72 0.55 22 $false $WHITE 1 | Out-Null
    TBox $s4 $pnames[$i] ($px+0.95) 4.97 3.0 0.36 13 $true $NAVY 1 | Out-Null
    TBox $s4 $proles[$i] ($px+0.95) 5.35 3.0 0.3 10.5 $false $MGRAY 1 | Out-Null
    TBox $s4 $ptraits[$i] ($px+0.18) 5.72 3.8 1.5 11 $false $TEXT 1 | Out-Null
}

# ══ SLIDE 5 – Impact ══════════════════════════════════════════════════════
$s5 = AddSlide $pres
BG $s5 $NAVY
Rect $s5 0 0 0.12 7.5 $ORANGE | Out-Null

TBox $s5 "SLIDE 4  ·  THE IMPACT" 0.4 0.28 9 0.35 9 $true $ORANGE 1 | Out-Null
TBox $s5 "What Changes When We Design Responsibly?" 0.4 0.7 11 1.8 36 $true $WHITE 1 | Out-Null

$iicons  = @("🎯","⏱️","❤️","🚀")
$ititles = @(
    "Products people actually want to use",
    "Less time wasted, more value delivered",
    "Technology that earns trust",
    "A stronger foundation for building"
)
$ibodies = @(
    "When you design around real needs, adoption is natural — not forced.",
    "Catching problems in the design stage costs nothing. Fixing them after launch costs everything.",
    "People trust tools that feel made FOR them — thoughtfully, not carelessly.",
    "A clear description + personas + user flows = a roadmap everyone understands."
)
for($i=0;$i -lt 4;$i++){
    $row = [math]::Floor($i/2)
    $col = $i % 2
    $ix  = 0.4 + $col*6.55
    $iy  = 2.75 + $row*2.2
    Rect $s5 $ix $iy 6.1 1.9 $DBLUE | Out-Null
    Rect $s5 $ix $iy 6.1 0.09 $ORANGE | Out-Null
    TBox $s5 $iicons[$i] ($ix+0.18) ($iy+0.14) 0.7 0.55 24 $false $WHITE 1 | Out-Null
    TBox $s5 $ititles[$i] ($ix+0.95) ($iy+0.14) 5.0 0.45 13 $true $WHITE 1 | Out-Null
    TBox $s5 $ibodies[$i] ($ix+0.95) ($iy+0.62) 5.0 1.0 12 $false $SUBT 1 | Out-Null
}

Rect $s5 0 7.05 13.33 0.45 (RGB 6 18 38) | Out-Null
TBox $s5 "Start early  ·  Be intentional  ·  Take ownership" 0 7.1 13.33 0.35 10 $false $MGRAY 2 | Out-Null

# ── Save ──────────────────────────────────────────────────────────────────
$out = "c:\Users\07892\OneDrive\Desktop\kalisa\my-project\HumanCentredDesign.pptx"
$pres.SaveAs($out, 24)   # 24 = ppSaveAsOpenXMLPresentation (.pptx)
$pres.Close()
$app.Quit()

Write-Host "Done! Saved to: $out"
