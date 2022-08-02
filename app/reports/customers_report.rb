require "prawn/table"

# encoding: utf-8
class CustomersReport < Prawn::Document
  # ширина колонок
  Widths = [200, 200, 120]
  # заглавия колонок
  Headers = ['title', 'description', 'price']

  def row(title, description, price)
    row = [title, description, price]
    make_table([row]) do |t|
      t.column_widths = Widths
      t.cells.style :borders => [:left, :right], :padding => 2
    end
  end

  def to_pdf
    # # привязываем шрифты
    font_families.update(
      "OpenSans" => {
            :normal => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Regular.ttf"),
            :italic => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Italic.ttf"),
            :bold => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Bold.ttf"),
            :bold_italic => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-BoldItalic.ttf")
          })
    font "OpenSans", :size => 10
    text "Report #{Time.zone.now.strftime('%b %Y')}", :size => 15, :style => :bold, :align => :center
    move_down(18)

    # выборка записей
    @products = Product.order('created_at')
    data = []
    items = @products.each do |item|
      data << row(item.title, item.description, item.price)
    end

    head = make_table([Headers], :column_widths => Widths)
    table([[head], *(data.map { |d| [d] })], :header => true, :row_colors => %w[cccccc ffffff]) do
      row(0).style :background_color => '000000', :text_color => 'ffffff'
      cells.style :borders => []
    end

    # добавим время создания внизу страницы
    creation_date = Time.zone.now.strftime("Report done %e %b %Y in %H:%M")
    go_to_page(page_count)
    move_down(710)
    text creation_date, :align => :right, :style => :italic, :size => 9
    render



  end




end