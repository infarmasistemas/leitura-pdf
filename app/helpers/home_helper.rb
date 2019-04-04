module HomeHelper
  def table_layout(table, el = [], tb = [])
	table.each.with_index do |table, index|
		unless index > 0
			table.each do |element|
			  el << "<th>#{element}</th>"
	  		end
	  		tb << "<tr>#{el.join(' ')}</tr>"
  		else
  			el = []
  			table.each do |element|
			  el << "<td>#{element}</td>"
	  		end
	  		tb << "<tr>#{el.join(' ')}</tr>"
  		end
	end
	"<table style='width:100%''>
		#{tb.join(' ')}
	</table>"
  end
end