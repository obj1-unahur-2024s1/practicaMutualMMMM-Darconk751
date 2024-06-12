import socios.*

class Actividad {
	const idiomasQueSeHablan = #{}
	
	method idiomasQueSeHablan() = idiomasQueSeHablan
	method agregarIdioma(unIdioma){
		idiomasQueSeHablan.add(unIdioma)
	}
	method implicaEsfuerzo()
	method sirveParaBroncearse()
	method cantidadDeDias()
	method esInteresante() = idiomasQueSeHablan.size() > 1
	method esRecomendada(unSocio) = self.esInteresante() and unSocio.leAtrae(self) and not unSocio.realizoActividad(self)
}

class ViajeDePlaya inherits Actividad {
	var largoDeLaPlaya 
	method largoDeLaPlaya() = largoDeLaPlaya
	override method cantidadDeDias() = largoDeLaPlaya / 500
	override method implicaEsfuerzo() = largoDeLaPlaya > 1200
	override method sirveParaBroncearse() = true 
}

class ExcursionDeCiudad inherits Actividad {
	var cantidadDeAtraccionesAVisitar
	method cantidadDeAtraccionesAVisitar() = cantidadDeAtraccionesAVisitar
	override method cantidadDeDias() = cantidadDeAtraccionesAVisitar / 2
	override method implicaEsfuerzo() = self.cantidadDeAtraccionesAVisitar().between(5, 8)
	override method sirveParaBroncearse() = false
	override method esInteresante() = super() or cantidadDeAtraccionesAVisitar == 5
}

class ExcursionACiudadTropical inherits ExcursionDeCiudad {
	override method cantidadDeDias() = super() + 1
	override method sirveParaBroncearse() = true 
}

class SalidaDeTrekking inherits Actividad {
	var kilometrosDeSenderoARecorrer 
	var diasDeSolPorAnio
	
	method kilometrosDeSenderoARecorrer() = kilometrosDeSenderoARecorrer 
	method diasDeSolPorAnio() = diasDeSolPorAnio
	override method cantidadDeDias() = kilometrosDeSenderoARecorrer / 50
	override method implicaEsfuerzo() = kilometrosDeSenderoARecorrer > 80
	override method sirveParaBroncearse() = diasDeSolPorAnio > 200 or (self.diasDeSolPorAnio().between(100, 200) and kilometrosDeSenderoARecorrer > 120)
	override method esInteresante() = super() or self.diasDeSolPorAnio() > 140 
}

class ClaseDeGimnasia inherits Actividad {
	override method idiomasQueSeHablan() = idiomasQueSeHablan.contains("español")
	override method cantidadDeDias() = 1
	override method implicaEsfuerzo() = true
	override method sirveParaBroncearse() = false
	override method esRecomendada(unSocio) = unSocio.edad().between(20, 30)
}

class TallerLiterario inherits Actividad {
	const librosEnLosQueSeTrabaja = #{}
	method idiomasUsados() = librosEnLosQueSeTrabaja.map({libro => libro.idioma()}).asSet()
	override method cantidadDeDias() = librosEnLosQueSeTrabaja.size() + 1
	method tieneLibroDeMasDe500Paginas() = librosEnLosQueSeTrabaja.any({libro => libro.cantidadDePaginas() > 500})
	method todosLosLibrosSonDelMismoAutor(autor) = librosEnLosQueSeTrabaja.all({libro => libro.nombreDelAutor() == autor})
	method autoresDeLibros() = librosEnLosQueSeTrabaja.map({libro => libro.nombreDelAutor()}).asSet()
    method todosLosLibrosSonDelMismoAutor() = self.autoresDeLibros().size() == 1
	method tieneMasDeUnLibro() = librosEnLosQueSeTrabaja.size() > 1
	override method implicaEsfuerzo() = self.tieneLibroDeMasDe500Paginas() or (self.todosLosLibrosSonDelMismoAutor() and self.tieneMasDeUnLibro())
	override method sirveParaBroncearse() = false
	override method esRecomendada(unSocio) = unSocio.idiomasQueHabla().size() > 1
}

class Libro {
	const property idioma
	const property cantidadDePaginas
	const property nombreDelAutor
}
