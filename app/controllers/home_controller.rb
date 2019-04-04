require "base64"

class HomeController < ApplicationController
  def index; end

  def treat_file # método para decodificar o pdf da licitação que é codificado na view index
  	decode_base64 = Base64.decode64(params[:base64].gsub('data:application/pdf;base64,', ''))
	File.open('public/licitacoes/' + params[:file], 'wb') do |f|
	  f.write(decode_base64)
	end
	redirect_to home_licitacao_path(file: params[:file])
  end

  def licitacao
  	@licitacao = highlight_pdf(PDF::Reader.new('public/licitacoes/' + params[:file]).pages, 'diretores')
  end

  # OBS.: existe um helper em rails (highlight) que destaca palavras por meio de cores
  def highlight_pdf(pdf, word = nil) # método para encontrar palavras chave
  	text = []
  	pdf.each do |page|
	  	if !word.nil? && page.text.downcase.include?(word.downcase)
	  		text << page.text.gsub(/\bword\b/, " ___#{word}___ ").gsub(/#{word}/i," ___#{word}___ ")
	  	else
	  		text << page
	  	end
	end
	text
  end
end

  # abaixo encontram-se os métodos de tratamento e busca de tabelas no pdf

#   def find_pdf_table(pdf, table, e = '', size_table = table.join(' ').split(' ').size)
#   	n = []
#   	work_table = table.join(' ').split(' ')
#   	work_table.each do |element|
#   		if pdf.gsub(/>\s+</, "><").gsub(/\n/,'').strip.delete(' ').include? (e + element).gsub(/>\s+</, "><").gsub(/\n/,'').strip.delete(' ')
#   			e = e + ' ' + element
#   		else
#   			n << element
#   		end
# 	end
# 	if e.split(' ').size != size_table
# 		return find_pdf_table(pdf, n, e, size_table)
# 	else
# 		return e + ' ' + n.join(' ')
# 	end
#   end

#   def page_with_table(page)
#   	table = page.extract_tables!.first.to_a(newlines: true, phrases: false)
#   	page = page.text.squeeze(' ')
# 	if page.include? find_n(page, table)
# 		page.gsub(find_n(page, table), table_layout(table))
# 	elsif page.include? find_n(page, table, 1)
# 		page.gsub(find_n(page, table, 1), table_layout(table))
# 	elsif page.squeeze("\n").inspect.include? find_n(page, table, 2)
# 		page.gsub(find_n(page, table, 2), table_layout(table))
# 	end
#   end

#   def find_n(pdf, table, next_n = 0)
#   	response = find_pdf_table(pdf, table)
#   	response = response.split(' ')
#   	response.each.with_index do |res, index|
#   		unless index > 0
# 	  		if pdf.delete(' ').inspect.include? (res + '\n' + response[index + 1])
# 	  			response[index] = res + '\n'
# 	  		end
#   		else
# 	  		if pdf.delete(' ').inspect.include? (response[index - 1] + res + '\n')
# 	  			response[index] = res + '\n'
# 	  		end
# 	  	end
#   	end
#   	result = response.join(' ')
#   	return result.gsub('\n ', '\n').gsub('\n', "\n") if next_n == 1
#   	if next_n == 2
#   		response.each.with_index do |res, index|
#   			if index < response.size
# 	  			if !pdf.include? res + ' '
# 	  				response[index + 1] = res + response[index + 1]
# 	  				response.delete(res)
# 	  			end
# 	  		end
#   		end
#   		return response.join(' ').gsub('\n', '\n ').gsub('\n', "\n")
#   	end
#   	result.gsub('\n', "\n")
#   end

#   def table_layout(table, el = [], tb = [])
# 	table.each.with_index do |table, index|
# 		unless index > 0
# 			table.each do |element|
# 			  el << "<th>#{element}</th>"
# 	  		end
# 	  		tb << "<tr>#{el.join(' ')}</tr>"
#   		else
#   			el = []
#   			table.each do |element|
# 			  el << "<td>#{element}</td>"
# 	  		end
# 	  		tb << "<tr>#{el.join(' ')}</tr>"
#   		end
# 	end
# 	"<table style='width:100%''>
# 		#{tb.join(' ')}
# 	</table>"
#   end
# end


			## Códigos para expor PDFs ##
#__________________________________________________#
#__________________________________________________#

 # 	edital = Iguvium.read('edital_tabela.pdf')
 # 	@pages = []


	# edital.each do |page|
	# 	page = page.text
	# 	@pages << page
	# end

	# page = edital[0]
	# table = edital[1].extract_tables!.first.to_a(newlines: true, phrases: false)
	# abort find_n(page, table).inspect
	# abort page.inspect
	# @page = page.text
	# @page = page_with_table(page)
	# @page = page.gsub(find_n(page, table), table_layout(table))
	# @page = table_layout(table)
	# pdf = page.gsub(find_n(page, table), table_layout(table))
	# edital.each do |page|
	# 	tables = page.extract_tables!
	# 	page = page.text.squeeze(' ')
	# 	if tables.any?
	# 		tables.each do |table|
	# 			table = table.to_a(newlines: true, phrases: false)
	# 			@pages << page.gsub(find_n(page, table), table_layout(table))
	# 		end
	# 	else
	# 		@pages << page
	# 	end
	# end

#__________________________________________________#
#__________________________________________________#