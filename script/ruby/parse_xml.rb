#!/usr/bin/ruby -w

require 'rexml/document'
include REXML

  xmlfile = File.new('Food_Display_Table.xml')
  xmldoc = Document.new(xmlfile)


  xmldoc.elements.each("Food_Display_Table/Food_Display_Row") do |e|

    #debugger
    #food = Food.new
    e.elements.each("Food_Code") { |i| puts i.text.to_f }
    e.elements.each("Display_Name") { |i| puts i.text.to_s }

    
    #food.portion_default = e["Portion_Default"].text.to_f
    #food.portion_amount = e["Portion_Amount"].text.to_f
    #food.portion_display_name = e["Portion_Display_Name"].text.to_s
    #food.factor = e["Factor"].text.to_f
    #food.increment = e["Increment"].text.to_f
    #food.multiplier = e["Multiplier"].text.to_f
    

    #food.save

  end