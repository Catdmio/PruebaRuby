# Abre documento txt
def lista_notas
  lines = File.open('Alumnosnotas.txt', 'r').readlines
  new_lines = []
  lines.each { |line| new_lines.push(line.split(', ').map(&:chomp)) }
  return new_lines
end

# Metodo de inasistencias
def inasistencias_totales
  unatend = lista_notas
  unatend.each do |lista_nomnot|
    nombre = lista_nomnot[0]
    total_inasist = lista_nomnot.select { |dataalum| dataalum == 'A' }.length
    puts "#{nombre} tiene #{total_inasist} inasistencias >:(!!"
  end
end

# Metodo promedio aprobados
def prom_aprobados
  unatend = lista_notas
  unatend.each do |lista_nomnot|
    nombre = lista_nomnot[0]
    total_inasist = lista_nomnot.map { |num| num.to_i > 5 }
    if true
      puts "#{nombre} Aprobado"
    else puts "#{nombre} cuek, vas a tener que hacer el ramo de nuevo"
    end
  end
end

# Metodo de hacer promedios
def promedios
  listapromedios = {}
  lista_nomnot = lista_notas
  lista_nomnot.each do |elem|
    nombre = elem[0]
    notas = elem.select { |num| elem.find_index(num) != 0 && num != 'A' }
    notas = notas.map(&:to_i)
    promedio = notas.sum / notas.count
    listapromedios[nombre] = promedio
  end
  escribir_archivo(listapromedios)
end

def escribir_archivo(listapromedios)
  File.open('listaactualizada.txt', 'w') do |file|
    listapromedios.each do |nombre, promedio|
      file.puts "#{nombre} con promedio #{promedio}"
    end
  end
end

# Metodo de verificacion de aprobacion
def verificar_aprobado(promedio, nombre)
  if promedio > 5
    puts "¡Felicidades! #{nombre} estás pasando el ramo"
  else
    puts "#{nombre} deberás esforzarte un poco más para no repetir ;)!"
  end
end

# Opciones que el usuario podra escoger
puts '¡Bienvenido a la API de Gestión de Alumnos! Presione enter'

options = gets.chomp
while options != '4'
  puts 'Escoje una opción ingresando el número correspondiente'
  puts '1. Alumnos y promedios'
  puts '2. Inasistencias por alumno'
  puts '3. Alumnos aprobados'
  puts '4. Salir'

  options = gets.chomp
  case options
  when '1'
    promedios
    puts 'Revisa el documento actualizado'
  when '2'
    inasistencias_totales
  when '3'
    prom_aprobados
  when '4'
    puts '¡Hasta luego!'
  else
    puts '¡Mlem! escoja una opción correcta ingresando un número del 1 al 4'
  end
end
