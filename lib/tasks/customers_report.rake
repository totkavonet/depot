namespace :customers_report do
  desc 'Generates report with customers'
  task :generate_pdf => :environment do
    output = CustomersReport.new.to_pdf
    filename = "report.pdf"
    File.open(Rails.root.join('public', filename), 'wb') do |f|
      f.write(output)
    end
    puts "Report was written to #{filename}"
  end
end