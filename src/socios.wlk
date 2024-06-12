import viajesYClaseDeGimnasia.*

class Socio {
	const actividadesRealizadas = []
	var edad 
	const idiomasQueHabla = #{}
	var maximoDeActividadesQuePuedeRealizar 
	
	
	method idiomasQueHabla() = idiomasQueHabla
	method maximoDeActividadesQuePuedeRealizar() = maximoDeActividadesQuePuedeRealizar
	method actividadesRealizadas() = actividadesRealizadas
	method edad() = edad
	method agregarIdiomaQueHabla(unIdioma){
		idiomasQueHabla.add(unIdioma)
	}
	method esAdoradorDelSol() = actividadesRealizadas.all({actividad => actividad.sirveParaBroncearse()})
	method actividadesReforzadas() = actividadesRealizadas.filter({actividad => actividad.implicaEsfuerzo()})
	method registrarActividadRealizada(unaActividad){
		if (self.actividadesRealizadas().size() < self.maximoDeActividadesQuePuedeRealizar()){
			actividadesRealizadas.add(unaActividad)
		}
		else {
			self.error("Alcanzó el máximo de actividades que puede realizar")
		}
	}
	method leAtrae(unaActividad)
	method realizoActividad(unaActividad) = actividadesRealizadas.contains(unaActividad)
}

class SocioTranquilo inherits Socio {
	override method leAtrae(unaActividad) = unaActividad.cantidadDeDias() >= 4
}

class SocioCoherente inherits Socio {
	override method leAtrae(unaActividad) = if(self.esAdoradorDelSol()) unaActividad.sirveParaBroncearse() else unaActividad.implicaEsfuerzo()
}

class SocioRelajado inherits Socio {
	override method leAtrae(unaActividad) = not idiomasQueHabla.intersection(unaActividad.idiomasQueSeHablan()).isEmpty()
}