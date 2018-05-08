//
//  SugerenciasFactory.swift
//  SaludIntegral
//
//  Created by Lizzie Cañamar on 02/05/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit
import CoreData

class SugerenciasFactory {
    static func agregarSugerencias() {
        let fetchSugerencias = NSFetchRequest<NSFetchRequestResult>(entityName: "Sugerencia")
        do {
            let sugerencias = try AppDelegate.context.fetch(fetchSugerencias) as! [Sugerencia]
            if sugerencias.count > 0 {
                return
            }
        } catch {
            
        }
        let request = NSBatchDeleteRequest(fetchRequest: fetchSugerencias)
        do {
            let result = try AppDelegate.context.execute(request)
        } catch let error as NSError {
            
        }
        let sugerencia1 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia1.area = Int32(Area.Fisico.rawValue)
        sugerencia1.titulo = "Tomar 2 litros de agua"
        sugerencia1.descripcion = "Si los ingieres en el transcurso de tu día a día, podrás mantener la función renal, una buena hidratación, evitar el estreñimiento y mantener la temperatura corporal entre otros."
        sugerencia1.imagen = "https://image.ibb.co/gUwMcH/agua.png"
        sugerencia1.prioridad = 1
        sugerencia1.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia1.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia2 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia2.area = Int32(Area.Fisico.rawValue)
        sugerencia2.titulo = "Realizar aeróbicos a diario"
        sugerencia2.descripcion = "Este ejercicio otorga un mejor funcionamiento del sistema cardiorrespiratorio y muscular, así como una mejor masa y composición corporal. Cuando personas de la tercera edad mejoran su aptitud física con ejercicios aeróbicos también se reflejan beneficios en cuanto a la memoria."
        sugerencia2.imagen = "https://image.ibb.co/dPWXjx/aeronics.png"
        sugerencia2.prioridad = 1
        sugerencia2.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia2.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia3 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia3.area = Int32(Area.Fisico.rawValue)
        sugerencia3.titulo = "¡Hora de bailar! "
        sugerencia3.descripcion = "Fortalece los músculos, sobre todo de piernas, caderas y, dependiendo del baile, de los brazos. Puedes hacerlo donde sea y con la música que tú quieras (recomendamos baile de sala y country, o modalidades nuevas como Zumba Gold (ve el vídeo en la parte superior)."
        sugerencia3.imagen = "https://image.ibb.co/mdFgcH/bailar.png"
        sugerencia3.prioridad = 1
        sugerencia3.video = "https://youtu.be/QUq4W6UKUIY"
        sugerencia3.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia4 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia4.area = Int32(Area.Fisico.rawValue)
        sugerencia4.titulo = "Natación"
        sugerencia4.descripcion = "Al entrar en el agua el peso del cuerpo es contrarrestado por la fuerza de flotación y los huesos, articulaciones y músculos se liberan de la compresión y la tensión que poseen. Te recomendamos realizar sencillos movimientos de piernas y brazos parados o en desplazamiento."
        sugerencia4.imagen = "https://image.ibb.co/hJhGBc/nadar.png"
        sugerencia4.prioridad = 1
        sugerencia4.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia5 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia5.area = Int32(Area.Fisico.rawValue)
        sugerencia5.titulo = "Caminar 25 minutos diariamente"
        sugerencia5.descripcion = "La práctica regular de caminatas te permite ir alineando los segmentos corporales y mejorar tu postura, convirtiéndose esta en una actividad física constante. Te recomendamos estirar tu columna vertical como si te estuvieran tirando con una cuerda desde el centro de la cabeza al caminar y de manera relajada."
        sugerencia5.imagen = "https://image.ibb.co/jNrMcH/camina.png"
        sugerencia5.prioridad = 1
        sugerencia5.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia5.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia6 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia6.area = Int32(Area.Fisico.rawValue)
        sugerencia6.titulo = "Pasear mascota"
        sugerencia6.descripcion = "Las mascotas sienten un amor incondicional con su dueño. Ejercítate y pasa un agradable tiempo con tu mascota. Preocupate por tu pequeño amigo, sacarlo a pasear, jugar con él o alimentarlo hace que permanezcas activo y con energía. Si tienes un perro corres menos riesgo de contraer un ataque al corazón."
        sugerencia6.imagen = "https://image.ibb.co/jNwyPx/pasearperro.png"
        sugerencia6.prioridad = 1
        sugerencia6.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia7 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia7.area = Int32(Area.Fisico.rawValue)
        sugerencia7.titulo = "Ejercicios de respiración diarios por 10 minutos"
        sugerencia7.descripcion = "Realizar ejercicios de respiración colocando las manos, una en el tórax y otra en el abdomen, para observar una respiración diafragmática."
        sugerencia7.imagen = "https://image.ibb.co/nm9k4x/ejerciciosrespiracion.png"
        sugerencia7.prioridad = 1
        sugerencia7.video = "https://www.youtube.com/watch?v=I6fd7TxIIzk"
        sugerencia7.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia7.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia8 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia8.area = Int32(Area.Fisico.rawValue)
        sugerencia8.titulo = "Tomar vitaminas diariamente"
        sugerencia8.descripcion = "Complementa y enriquece tu dieta con los nutrientes esenciales que necesita tu cuerpo para el día a día como complemento a tu comida o cena. Existe una alta gama de vitaminas, entre ellas, existe la vitamina D, que proporciona calcio que requieren los huesos para mantenerse sanos y fuertes."
        sugerencia8.imagen = "https://image.ibb.co/e2i1cH/vitaminas.png"
        sugerencia8.prioridad = 1
        sugerencia8.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia8.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia9 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia9.area = Int32(Area.Fisico.rawValue)
        sugerencia9.titulo = "¡Cepilla tus dientes!"
        sugerencia9.descripcion = "Parte de tener una vida sana es tener una boca sana. Cuida tus dientes y lávalos frecuentemente. Cepíllate al menos dos veces al día con un cepillo dental de cerdas suaves o de ser posible, con un cepillo de dientes eléctrico. Al adoptar esta medida, contribuyes a que tus dientes duren toda la vida."
        sugerencia9.imagen = "https://image.ibb.co/jc69Wc/dientes.png"
        sugerencia9.prioridad = 1
        sugerencia9.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia9.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia10 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia10.area = Int32(Area.Fisico.rawValue)
        sugerencia10.titulo = "Conciliar el sueño"
        sugerencia10.descripcion = "Para tener una mente sana y un cuerpo sano, es necesario tomar un sueño reparador. No se trata de dormir más tiempo, si no de hacer ese tiempo efectivo y tomar ciertas medidas para lograrlo como contar con un horario de sueño definido y evitar siestas de más de 30 minutos. Una ducha antes de dormir ayuda."
        sugerencia10.imagen = "https://image.ibb.co/dFMbBc/dormir.png"
        sugerencia10.prioridad = 1
        sugerencia10.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia10.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        
        let sugerencia11 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia11.area = Int32(Area.Mental.rawValue)
        sugerencia11.titulo = "Realizar pulseras "
        sugerencia11.descripcion = "Fomenta la concentración y atención en esta gran actividad, además de poner a prueba tu creatividad y destreza manual. Te mostramos un vídeo con algunos tipos de pulseras que puedes realizar de manera sencilla y con materiales sencillos de conseguir. "
        sugerencia11.imagen = "https://image.ibb.co/mv5KWc/pulseras.png"
        sugerencia11.video="https://www.youtube.com/watch?v=YdSMK3bJ3RY"
        sugerencia11.prioridad = 1
        sugerencia11.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia12 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia12.area = Int32(Area.Mental.rawValue)
        sugerencia12.titulo = "Jugar Memorama"
        sugerencia12.descripcion = "Puedes mejorar tu memoria poniendo en práctica una diversidad de juegos diseñados para aumentar la agudeza y la percepción, como el memorama, que cuenta con el beneficio añadido de ser divertidos y de estimular la unión y tu espíritu con el de tu oponente."
        sugerencia12.imagen = "https://image.ibb.co/gNsoPx/memorama.png"
        sugerencia12.prioridad = 1
        sugerencia12.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia13 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia13.area = Int32(Area.Mental.rawValue)
        sugerencia13.titulo = "¡Aprende y juega ajedrez!"
        sugerencia13.descripcion = "El ajedrez requiere de un enorme entrenamiento y disciplina, y deja muchas ventajas al trabajar activamente el músculo del cerebro, funciona como un buen gimnasio mental, siendo excelente para la mente y todo lo que la interconecta. El mayor reto es aprender a jugarlo, pero no imposible."
        sugerencia13.video="https://www.youtube.com/watch?v=vPcyQl5YLJY"
        sugerencia13.imagen = "https://image.ibb.co/heg4xH/ajedrez.png"
        sugerencia13.prioridad = 1
        sugerencia13.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia14 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia14.area = Int32(Area.Mental.rawValue)
        sugerencia14.titulo = "Pintar mandalas"
        sugerencia14.descripcion = "Una mandala tiene como definición una representación geométrica que tiene distintas interpretaciones según la forma, color, material y la cultura que lo representa. Posee grandes beneficios como ser elemento de apoyo en la meditación y fomentar la paciencia y despierta los sentidos."
        sugerencia14.imagen = "https://image.ibb.co/h3q8Px/mandala.png"
        sugerencia14.prioridad = 1
        sugerencia14.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia15 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia15.area = Int32(Area.Mental.rawValue)
        sugerencia15.titulo = "Armar un rompecabezas"
        sugerencia15.descripcion = "Los rompecabezas son divertidos y además promueve el uso del cerebro y de la imaginación. Te recomendamos tanto jugarlo solo o acompañado de familia, para pasar también un rato agradable con ellos. Y recuerda.. tendrás una gran sensación de satisfacción al terminarlo."
        sugerencia15.imagen = "https://image.ibb.co/kHHoPx/puzzle.png"
        sugerencia15.prioridad = 1
        sugerencia15.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia16 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia16.area = Int32(Area.Mental.rawValue)
        sugerencia16.titulo = "Jugar una partida de Sudoku"
        sugerencia16.descripcion = "La ventaja de este juego es que existen niveles para principiantes, intermedios y avanzados, y no es necesario ser un genio matemático para resolverlo. Sudoku es desafiante, mejora la memoria y estimula la mente, además de sentirte relajado y feliz. "
        sugerencia16.imagen = "https://image.ibb.co/iXLWcH/sudoku.png"
        sugerencia16.prioridad = 1
        sugerencia16.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia17 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia17.area = Int32(Area.Mental.rawValue)
        sugerencia17.titulo = "Resolver un crucigrama"
        sugerencia17.descripcion = "Juegos como el crucigrama mejoran la memoria y pueden ayudar a mantener el cerebro hasta quince años más joven en las personas que han superado los sesenta. Te recomendamos la aplicación de “Crucigramas Free” para probar con algunos, o puedes hacerlo de la forma tradicional con libros."
        sugerencia17.imagen = "https://image.ibb.co/fKf8Px/crucigrama.png"
        sugerencia17.prioridad = 1
        sugerencia17.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia18 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia18.area = Int32(Area.Mental.rawValue)
        sugerencia18.titulo = "¡Abre tu mente y lee!"
        sugerencia18.descripcion = "Existe una gran gama de libros los cuales puedes leer. Recomendamos fuertemente el título de Yo de Mayor quiero ser Jóven de Leopoldo Abadía,  quién nos hace sonreír en su papel de persona octogenaria que se enfrenta a un mundo de mayores con la mentalidad fresca y entusiasta de un chaval. "
        sugerencia18.imagen = "https://image.ibb.co/gZCYrc/leer.png"
        sugerencia18.prioridad = 1
        sugerencia18.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia18.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia19 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia19.area = Int32(Area.Mental.rawValue)
        sugerencia19.titulo = "Jugar damas chinas"
        sugerencia19.descripcion = "Busca a algún familiar y juega una partida de damas chinas. Si no sabes las reglas del juego te dejamos este vídeo en donde puedes aprender el reglamente del juego. "
        sugerencia19.video = "https://www.youtube.com/watch?v=1s8VCq2Z5NE"
        sugerencia19.imagen = "https://image.ibb.co/gYRF4x/damaschinas.png"
        sugerencia19.prioridad = 1
        sugerencia19.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia20 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia20.area = Int32(Area.Mental.rawValue)
        sugerencia20.titulo = "¡Tiempo de Bordar!"
        sugerencia20.descripcion = "¿Conoces algunas técnicas para bordar? Es una actividad muy entretenida, donde puedes emplear tu creatividad y explotarla al máximo, realizando toda clase de cosas. Te dejamos este vídeo con un ejemplo de lo que puedes hacer ¡Deja volar tu imaginación!."
        sugerencia20.video = "https://www.youtube.com/watch?v=pA_3RRn0rXA"
        sugerencia20.imagen = "https://image.ibb.co/hORF4x/bordar.png"
        sugerencia20.prioridad = 1
        sugerencia20.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia20.frecuenciaSemana = [true, false, true, false, true, false, false]
        
        let sugerencia21 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia21.area = Int32(Area.Financiero.rawValue)
        sugerencia21.titulo = "Ir a una cita con contador"
        sugerencia21.descripcion = "Es importante realizar una cita por lo menos 1 vez al mes a tu contador con el fin de observar cómo están tus gastos, entrega de facturas del mes, realizar su pago de honorarios si así es el caso y monitoreo de papelería de trámites o rentas. ¡Agenda tu cita con tu contador y verifica tus gastos!"
        sugerencia21.imagen = "https://image.ibb.co/hrZMpH/contador.png"
        sugerencia21.prioridad = 1
        sugerencia21.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia22 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia22.area = Int32(Area.Financiero.rawValue)
        sugerencia22.titulo = "Pagar servicio de luz"
        sugerencia22.descripcion = "No olvides realizar el pago de la energía eléctrica de tu casa o negocio. Este pago se hace de manera bimestral (en México) y verifica en tu recibo de pago la fecha límite para realizar el mismo. Verifica si puedes realizar el pago desde una computadora (México: https://app.cfe.mx/ )"
        sugerencia22.imagen = "https://image.ibb.co/nhT33c/electricidad.png"
        sugerencia22.prioridad = 1
        sugerencia22.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia23 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia23.area = Int32(Area.Financiero.rawValue)
        sugerencia23.titulo = "Pagar servicio de agua y drenaje"
        sugerencia23.descripcion = "¡Verifica en tu recibo de pago del servicio de agua y drenaje la fecha límite para realizar el pago y realízalo! Un consejo que te damos es que en algunos países de América Latina, existe tarifa para adultos de la tercera edad en uso doméstico (Verificalo con tu compañía proveedora)."
        sugerencia23.imagen = "https://image.ibb.co/iywqic/aguaydrenaje.png"
        sugerencia23.prioridad = 1
        sugerencia23.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia24 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia24.area = Int32(Area.Financiero.rawValue)
        sugerencia24.titulo = "Retirar pensión del cajero"
        sugerencia24.descripcion = "¿Cuentas con pensión? No olvides retirarla el día en que sea depositada en tu cuenta o en cuanto te sea posible del cajero automático o en ventanilla desde tu banco. Busca el cajero más cercano a tu domicilio"
        sugerencia24.imagen = "https://image.ibb.co/c2DE9H/pensioncajero.png"
        sugerencia24.prioridad = 1
        sugerencia24.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia25 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia25.area = Int32(Area.Financiero.rawValue)
        sugerencia25.titulo = "Ahorrar con la ayuda de una aplicación"
        sugerencia25.descripcion = "¿Tienes algún viaje que quieres completar? ¿O algo que quieras comprar? Existen aplicaciones como piggo que te ayudan a realizar un estimado del dinero que requieres para cumplir tu meta, y te dice cuánto debes ahorrar por semana o mes. Podrás ir viendo como avanzas para llegar a tu meta."
        sugerencia25.imagen = "https://image.ibb.co/epTQGx/ahorrar.png"
        sugerencia25.prioridad = 1
        sugerencia25.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia26 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia26.area = Int32(Area.Financiero.rawValue)
        sugerencia26.titulo = "Registrar gastos diarios"
        sugerencia26.descripcion = "Verifica cada noche cuáles fueron los gastos que realizaste en el transcurso del día. Puedes registrarlos en una libreta o alguna aplicación, con el fin de no desbalancear tus egresos e ingresos. "
        sugerencia26.prioridad = 1
        sugerencia26.imagen = "https://image.ibb.co/kiZnUH/registrargastosdiarios.png"
        sugerencia26.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia26.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia27 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia27.area = Int32(Area.Financiero.rawValue)
        sugerencia27.titulo = "Planear gastos semanales"
        sugerencia27.descripcion = "Un día a la semana (te recomendamos que un domingo o un lunes) anota los gastos que realizarás en la semana con el monto aproximado. Durante la semana, podrás monitorear en base a este plan, si estás gastando más de lo que habías considerado. "
        sugerencia27.prioridad = 1
        sugerencia27.imagen = "https://image.ibb.co/cs7kGx/planeargastossemanales.png"
        sugerencia27.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia27.frecuenciaSemana = [false, false, false, false, false, false, true]
        
        //////////////////////////
        let sugerencia31 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia31.area = Int32(Area.Espiritual.rawValue)
        sugerencia31.titulo = "Ir a misa"
        sugerencia31.descripcion = "Ya sea asistir a misa dominical o a misa diaria, selecciona tus horarios favoritos y asiste a ello a la iglesia o templo que quede más cercano a tu localidad."
        sugerencia31.imagen = "https://image.ibb.co/dvoLic/misa.png"
        sugerencia31.prioridad = 1
        sugerencia31.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia31.frecuenciaSemana = [false, false, false, false, false, false, true]
        
        let sugerencia32 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia32.area = Int32(Area.Espiritual.rawValue)
        sugerencia32.titulo = "Realizar yoga"
        sugerencia32.descripcion = "El yoga puede ser una compañía para toda la vida, ayudándote a mantener un amplio rango de movilidad, flexibilidad, estabilidad, equilibrio físico y mental. Ayuda a mantener una buena actitud y estado de ánimo positivo. Se recomienda que se realicen ejercicios de yoga todos los días, para tener un cuerpo sano."
        sugerencia32.video="https://youtu.be/F8bNQ7UWJII"
        sugerencia32.imagen = "https://image.ibb.co/c9MUbx/yoga.png"
        sugerencia32.prioridad = 1
        sugerencia32.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia32.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia33 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia33.area = Int32(Area.Espiritual.rawValue)
        sugerencia33.titulo = "Hacer oración"
        sugerencia33.descripcion = "Una fuerte conexión espiritual puede mejorar la satisfacción con la vida o facilitar el adaptarse a determinados impedimentos. De igual manera, las creencias religiosas o espirituales contribuyen a la habilidad para enfrentar efectivamente  la enfermedad, discapacidad y eventos negativos."
        sugerencia33.imagen = "https://image.ibb.co/mOJaGx/oracion.png"
        sugerencia33.prioridad = 1
        sugerencia33.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia33.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia34 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia34.area = Int32(Area.Espiritual.rawValue)
        sugerencia34.titulo = "Bienestar psicológico"
        sugerencia34.descripcion = "Trabajando tu autoestima hace que llegues a tener una muy buena actitud  si trabajas con constancia y dedicación, sintiéndote mejor. Si te interesa saber más sobre los conceptos de la autoestima, te dejamos el siguiente vídeo para que escuches a expertos hablar de este tema."
        sugerencia34.imagen = "https://image.ibb.co/i2uFGx/autoestima.png"
        sugerencia34.video = "https://www.youtube.com/watch?v=Go70CF3DwTY"
        sugerencia34.prioridad = 1
        sugerencia34.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia34.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia35 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia35.area = Int32(Area.Espiritual.rawValue)
        sugerencia35.titulo = "Tomar aire y salir al parque"
        sugerencia35.descripcion = "¡Date un respiro! Ve al parque y siéntete como nuevo. Al respirar aire fresco, tu cuerpo absorbe oxígeno, eliminando las toxinas del organismo. Adiós al estrés y hola a la relajación del sistema nervioso contribuyendo a un estado de bienestar general. Busca sitios abiertos cerca de tu hogar."
        sugerencia35.imagen = "https://image.ibb.co/bTcrpH/parque.png"
        sugerencia35.prioridad = 1
        sugerencia35.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia35.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia36 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia36.area = Int32(Area.Espiritual.rawValue)
        sugerencia36.titulo = "Salir por un café con un viejo amigo"
        sugerencia36.descripcion = "¿En quién piensas cuando menciono la palabra Amigo? ¡Llámalo! Agenda una cita con él o ella para conversar por un rato y pasar un tiempo muy agradable. Te sugerimos ir por un café cercano a tu localidad, o ir a un restaurante por su comida favorita."
        sugerencia36.imagen = "https://image.ibb.co/iOVY3c/cafe.png"
        sugerencia36.prioridad = 1
        sugerencia36.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia37 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia37.area = Int32(Area.Espiritual.rawValue)
        sugerencia37.titulo = "Probar la risoterapia"
        sugerencia37.descripcion = "Conocida también como terapia de la risa, libera tensiones y te ríes de forma natural por un momento.Se usan bailes, juegos y masajes para lograr causar risa en las personas. ¡Ve el vídeo y aprende más de ello!"
        sugerencia37.video="https://www.youtube.com/watch?v=U5533X-m-i8"
        sugerencia37.imagen = "https://image.ibb.co/j8Gj9H/risoterapia.png"
        sugerencia37.prioridad = 1
        sugerencia37.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia38 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia38.area = Int32(Area.Espiritual.rawValue)
        sugerencia38.titulo = "Hacer Meditación"
        sugerencia38.descripcion = "La meditación es realmente importante en cualquier edad y otorga muchos beneficios como aumentar la longevidad, disminuye la soledad y mejorar la memoria, la mente y el estado de ánimo. Te recomendamos buscar un lugar cómodo y escuchar la siguiente meditación. ¡Relájate y disfruta!"
        sugerencia38.video="https://www.youtube.com/watch?v=zkbssc2d2lA"
        sugerencia38.imagen = "https://image.ibb.co/bVr6Oc/meditacion.png"
        sugerencia38.prioridad = 1
        sugerencia38.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia39 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia39.area = Int32(Area.Espiritual.rawValue)
        sugerencia39.titulo = "Estar actualizado"
        sugerencia39.descripcion = "Conoce qué está pasando a tu alrededor, enciende la televisión y ve las noticias o lee el periódico. Si prefieres verificar las noticias desde tu celular, te recomendamos buscar tu periódico o noticiero favorito en la AppStore y descargar la aplicación."
        sugerencia39.imagen = "https://image.ibb.co/mDB6Oc/noticias.png"
        sugerencia39.prioridad = 1
        sugerencia39.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia39.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        
        let sugerencia40 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: AppDelegate.context) as! Sugerencia
        sugerencia40.area = Int32(Area.Espiritual.rawValue)
        sugerencia40.titulo = "Llamar a tu familia"
        sugerencia40.descripcion = "Una llamada a tu nieto, hijo, hermano o familiar mejora tu día en su totalidad. Cuentales que ha pasado en tus días y pregúntale por los suyos. Hablar con la familia incrementa tu estado de ánimo."
        sugerencia40.imagen = "https://image.ibb.co/bC6HUH/familia.png"
        sugerencia40.prioridad = 1
        sugerencia40.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia40.frecuenciaSemana = [true, false, false, true, false, false, true]
        
        
        
        do {
            try AppDelegate.context.save()
        } catch let error as NSError {
            print("El contacto no fue guardado")
            print("Error \(error) \(error.userInfo)")
        }
    }
}
