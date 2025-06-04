class Rutinas {
     
    method caloriasQueBaja(tiempo){
        return 100 * (tiempo - self.descanso(tiempo)) * self.intensidad()
    }

    method descanso(tiempo)
    method intensidad()
}

class Running inherits Rutinas {
    const intensidad 

    override method intensidad() {
        return intensidad
    }
    
    override method descanso(tiempo) {
        return if (tiempo > 20) 5 else 2
    }
}

class Marathon inherits Running {

    override method caloriasQueBaja(tiempo) {
        return super(tiempo) * 2
    }
}

class Remo inherits Rutinas {

    override method intensidad() {
        return 1.3
    }
    
    override method descanso(tiempo) {
        return tiempo / 5
    }
}

class RemoDeCompeticion inherits Remo {

    override method intensidad() {
        return 1.7
    }

    override method descanso(tiempo) {
        return (super(tiempo) - 3).max(2) 
    }
}

class Persona {
    var property peso
      
    method pesoQuePierdeConRutina(rutina){
        return (rutina.caloriasQueBaja(self.tiempo()) / self.kilosPorCaloríaQuePierde())
    }

    method kilosPorCaloríaQuePierde()

    method pesoLuegoDeRutina(rutina) {
        peso = peso - self.pesoQuePierdeConRutina(rutina)
    }

    method peso() {
        return peso
    }

    method aplicarRutina(rutina) {
        self.validarRutina(rutina)
        self.pesoLuegoDeRutina(rutina)
    }

    method validarRutina(rutina)

    method puedeHacerRutina(rutina) 

    method tiempo() 
}

class PersonaSedentaria inherits Persona{
    const property tiempo

    override method kilosPorCaloríaQuePierde(){
        return 7000
    }

    override method tiempo() {
        return tiempo
    }

    override method validarRutina(rutina) {
        if (not self.puedeHacerRutina(rutina))
            self.error("Una persona sedentaria no puede realizar esta rutina") 
    }

    override method puedeHacerRutina(rutina) {
        return self.peso() > 50
    }

}

class PersonaAtleta inherits Persona {
    
    override method kilosPorCaloríaQuePierde() {
        return 8000
    }

    override method tiempo() {
        return 90
    }

    override method pesoQuePierdeConRutina(rutina) {
        return super(rutina) - 1
        
    }

    override method validarRutina(rutina) {
        if (not self.puedeHacerRutina(rutina))
            self.error("Una persona atleta no puede realizar esta rutina") 
    }

    override method puedeHacerRutina(rutina) {
        return rutina.caloriasQueBaja(self.tiempo()) > 10000
    }
}

class Club {
    const property predios = #{}

    method mejorPredio(persona) {
        return predios.max({predio => predio.caloriasAQuemar(persona) })
    }

    method prediosTranquis(persona) {
        return predios.filter({predio => predio.esTraquiPara(persona)})     
    }

    method rutinasMasExigentes(persona) {
        return predios.map({predio => predio.rutinaMasExigente(persona)}).asSet()
    }
}

class Predio {
    const property rutinas = #{}

    method caloriasAQuemar(persona) {
        return rutinas.sum({rutina => rutina.caloriasQueBaja(persona.tiempo())})
    }

    method esTraquiPara(persona) {
        return rutinas.any({rutina => rutina.caloriasQueBaja(persona.tiempo()) < 500})
    }

    method rutinaMasExigente(persona) {
        return rutinas.max({rutina => rutina.caloriasQueBaja(persona.tiempo())})
    }

}


