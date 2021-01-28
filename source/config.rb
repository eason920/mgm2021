require 'compass/import-once/activate'
# Require any additional compass plugins here.

# Set this to the root of your project when deployed:
http_path = "/"
css_dir = "css"
sass_dir = "sass"
images_dir = "images"
javascripts_dir = "js"

# You can select your preferred output style here (can be overridden via the command line):
# CSS 編譯方式如下註解：
#  :expanded   一般，每行 CSS 皆會斷行
#  :nested     有巢狀縮進，較好閱讀
#  :compact    每一 selector 作單位分行， property:value 寫作一行
#  :compressed 壓縮成一行
output_style = :expanded

# To enable relative paths to assets via compass helper functions. Uncomment:
# 是否允許使用相對路徑 URI
relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# CSS碼註解關閉 = false / 預設開啟
line_comments = false


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass

# debug 檔案中有中文的狀況
Encoding.default_external = "utf-8"

# 是否生成 .map 檔案 true 生成 / 預設 不生成
sourcemap = true