class AddColumnToVistor < ActiveRecord::Migration[5.1]
  def change
    add_column :vistors, :visitor_type, :string
    add_column :vistors, :here_for, :string
    add_column :vistors, :host, :string
    add_column :vistors, :note, :string
    add_column :vistors, :arrival_time, :time
    add_column :vistors, :arrival_date, :date
  end
end
