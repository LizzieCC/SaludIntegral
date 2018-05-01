//
//  SugerenciasViewController.swift
//  SaludIntegral
//
//  Created by Alumno on 07/03/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData

class SugerenciasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    @IBOutlet weak var tablaSugerencias: UITableView!
    @IBOutlet weak var tabBarAreas: UITabBar!
    
    var sugerencias = [Sugerencia]()
    var sugerenciasActuales:  [Sugerencia] = []
    var areaActual: Area = Area.Fisico

    override func viewDidLoad() {
        super.viewDidLoad()
        tablaSugerencias.delegate = self
        tablaSugerencias.dataSource = self
        tabBarAreas.delegate = self
        tabBarAreas.selectedItem = (self.tabBarAreas.items as! [UITabBarItem])[0]
        
        agregarDatosPrueba()
        actualizarSugerencias()
    }
    
    func agregarDatosPrueba() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Sugerencia")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            let result = try context.execute(request)
        } catch let error as NSError {
            
        }
        let sugerencia1 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia1.area = Int32(Area.Fisico.rawValue)
        sugerencia1.titulo = "Tomar 2 litros de agua"
        sugerencia1.descripcion = "Si los ingieres en el transcurso de tu día a día, podrás mantener la función renal, una buena hidratación, evitar el estreñimiento y mantener la temperatura corporal entre otros."
        sugerencia1.imagen = "https://image.ibb.co/gUwMcH/agua.png"
        sugerencia1.prioridad = 1
        sugerencia1.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia1.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia2 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia2.area = Int32(Area.Fisico.rawValue)
        sugerencia2.titulo = "Realiza aeróbicos a diario"
        sugerencia2.descripcion = "De 10 a 20 minutos de realizar este ejercicio otorga un mejor funcionamiento del sistema cardiorrespiratorio y muscular, así como una mejor masa y composición corporal. Estudios realizados han demostrado que cuando personas de la tercera edad mejoran su aptitud física con ejercicios aeróbicos también se reflejan beneficios en cuanto a la memoria, coordinación de tareas, la planificación y la capacidad de cambiar de tarea."
        sugerencia2.imagen = "https://image.ibb.co/dPWXjx/aeronics.png"
        sugerencia2.prioridad = 1
        sugerencia2.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia2.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia3 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia3.area = Int32(Area.Fisico.rawValue)
        sugerencia3.titulo = "¡Hora de bailar! "
        sugerencia3.descripcion = "Fortalece los músculos, sobre todo de piernas, caderas y, dependiendo del baile, de los brazos. Puedes hacerlo donde sea y con la música que tú quieras (recomendamos baile de sala y country, o modalidades nuevas como Zumba Gold, la cual te mostramos más a detalle en el vídeo localizado en la parte inferior a esta descripción)."
        sugerencia3.imagen = "https://image.ibb.co/mdFgcH/bailar.png"
        sugerencia3.prioridad = 1
        sugerencia3.video = "https://youtu.be/QUq4W6UKUIY"
        sugerencia3.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia4 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia4.area = Int32(Area.Fisico.rawValue)
        sugerencia4.titulo = "Nada como pez en el agua"
        sugerencia4.descripcion = "Al entrar en el agua el peso del cuerpo es contrarrestado por la fuerza de flotación y los huesos, articulaciones y músculos se liberan de la compresión y la tensión que poseen. Te recomendamos realizar los siguientes ejercicios en el agua: Sencillos movimientos de piernas y brazos parados o en desplazamiento, similares a los que realizamos en tierra en la gimnasia de mantenimiento; Andar de todas las maneras posibles; correr con el tronco muy recto; saltar poco; Prueba con materiales auxiliares como manguitos, cinturones, rulos o pelotas, sirven de sujeción y para no cansarte. Consulta con los instructores la mejor manera y el mejor momento para usarlos."
        sugerencia4.imagen = "https://image.ibb.co/hJhGBc/nadar.png"
        sugerencia4.prioridad = 1
        sugerencia4.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia5 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia5.area = Int32(Area.Fisico.rawValue)
        sugerencia5.titulo = "Camina 25 minutos diariamente"
        sugerencia5.descripcion = "La práctica regular de caminatas te permite ir alineando los segmentos corporales y mejorar tu postura, convirtiéndose esta en una actividad física constante. Te recomendamos las siguientes acciones para tu caminata: Estira tu columna vertical como si te estuvieran tirando con una cuerda desde el centro de la cabeza. Ésta debe descansar relajada alineada con la columna, sin inclinarse hacia adelante ni hacia atrás; Balancea los brazos en forma pendular llevando el ritmo del movimiento; Apoya el talón y luego el resto del pie en cuanto hagas contacto con el suelo; Puedes contraer el abdomen durante la caminata para activar la musculatura profunda de la pelvis"
        sugerencia5.imagen = "https://image.ibb.co/jNrMcH/camina.png"
        sugerencia5.prioridad = 1
        sugerencia5.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia5.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia6 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia6.area = Int32(Area.Fisico.rawValue)
        sugerencia6.titulo = "¿Cuentas con una mascota? ¡Paseala al aire libre!"
        sugerencia6.descripcion = "Todo indica que las mascotas sienten un amor incondicional con su dueño. Ejercítate a tí y pasa un agradable tiempo con tu mascota. Preocupate por tu pequeño amigo, sacarlo a pasear, jugar con él o alimentarlo hace que permanezcas activo y con energía. Como dato curioso está comprobado que si tienes un perro corres menos riesgo de contraer un ataque al corazón y aumenta tu supervivencia a un año después de haberlo padecido."
        sugerencia6.imagen = "https://image.ibb.co/jNwyPx/pasearperro.png"
        sugerencia6.prioridad = 1
        sugerencia6.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia7 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia7.area = Int32(Area.Fisico.rawValue)
        sugerencia7.titulo = "Ejercicios de respiración todos los días por 10 minutos"
        sugerencia7.descripcion = "Realizar ejercicios de respiración colocando las manos, una en el tórax y otra en el abdomen, para observar una respiración diafragmática. Te dejamos esta liga que muestra la información necesaria para realizar los ejercicios https://www.fisiohogar.com/ejercicios-basicos-la-fisioterapia-respiratoria-mayores/"
        sugerencia7.imagen = "https://image.ibb.co/nm9k4x/ejerciciosrespiracion.png"
        sugerencia7.prioridad = 1
        sugerencia7.video = "https://www.youtube.com/watch?v=I6fd7TxIIzk"
        sugerencia7.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia7.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia8 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia8.area = Int32(Area.Fisico.rawValue)
        sugerencia8.titulo = "Tomar vitaminas diariamente"
        sugerencia8.descripcion = "Complementa y enriquece tu dieta con los nutrientes esenciales que necesita tu cuerpo para el día a día como complemento a tu comida o cena. Existe una alta gama de vitaminas, entre ellas, existe la vitamina D, que proporciona calcio que requieren los huesos para mantenerse sanos y fuertes. Te dejamos esta liga que muestra información adicional sobre qué vitaminas adicionales que requiere el cuerpo acorde a tu edad, para que cuentes con una mejor idea de las vitaminas que puedes consumir https://www.aarp.org/espanol/salud/farmacos-y-suplementos/info-2015/vitaminas-debo-tomar-50-60-70.html"
        sugerencia8.imagen = "https://image.ibb.co/e2i1cH/vitaminas.png"
        sugerencia8.prioridad = 1
        sugerencia8.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia8.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia9 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia9.area = Int32(Area.Fisico.rawValue)
        sugerencia9.titulo = "¡Cepilla tus dientes!"
        sugerencia9.descripcion = "Parte de tener una vida sana es tener una boca sana. Cuida tus dientes y lávalos frecuentemente. Cepíllate al menos dos veces al día con un cepillo dental de cerdas suaves o de ser posible, con un cepillo de dientes eléctrico. Al adoptar esta medida, contribuyes a que tus dientes duren toda la vida, ya sean dientes naturales, dentadura postiza o implantes. "
        sugerencia9.imagen = "https://image.ibb.co/jc69Wc/dientes.png"
        sugerencia9.prioridad = 1
        sugerencia9.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia9.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia10 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia10.area = Int32(Area.Fisico.rawValue)
        sugerencia10.titulo = "Concilia el sueño"
        sugerencia10.descripcion = "Para tener una mente sana y un cuerpo sano, es necesario tomar un sueño reparador. Y no se trata de dormir más tiempo, si no de hacer ese tiempo efectivo y tomar ciertas medidas para lograrlo mencionadas a continuación: Contar con un horario de sueño definido y respetarlo; Evitar siestas de más de 30 minutos o que se tomen en la tarde-noche; Una ducha antes de dormir puede ayudar a relajar el cuerpo; Evitar comida en gran cantidad previo a dormir. Una cena ligera es la mejor opción; No tomar mucho líquido previo a dormir"
        sugerencia10.imagen = "https://image.ibb.co/dFMbBc/dormir.png"
        sugerencia10.prioridad = 1
        sugerencia10.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia10.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        
        let sugerencia11 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia11.area = Int32(Area.Mental.rawValue)
        sugerencia11.titulo = "Realiza pulseras "
        sugerencia11.descripcion = "Fomenta la concentración y atención en esta gran actividad, además de poner a prueba tu creatividad y destreza manual. Te mostramos un vídeo con algunos tipos de pulseras que puedes realizar de manera sencilla y con materiales sencillos de conseguir. "
        sugerencia11.imagen = "https://image.ibb.co/mv5KWc/pulseras.png"
        sugerencia11.video="https://www.youtube.com/watch?v=YdSMK3bJ3RY"
        sugerencia11.prioridad = 1
        sugerencia11.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia12 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia12.area = Int32(Area.Mental.rawValue)
        sugerencia12.titulo = "Juega Memorama"
        sugerencia12.descripcion = "Puedes mejorar tu memoria poniendo en práctica una diversidad de juegos diseñados para aumentar la agudeza y la percepción, como el memorama, que cuenta con el beneficio añadido de ser divertidos y de estimular la unión y tu espíritu con el de tu oponente. Puedes jugar de la forma tradicional con cartas o mediante aplicaciones como Memory Matches 2 disponible en la AppStore. "
        sugerencia12.imagen = "https://image.ibb.co/gNsoPx/memorama.png"
        sugerencia12.prioridad = 1
        sugerencia12.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia13 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia13.area = Int32(Area.Mental.rawValue)
        sugerencia13.titulo = "¡Aprende y juega ajedrez!"
        sugerencia13.descripcion = "El ajedrez requiere de un enorme entrenamiento y disciplina, y deja muchas ventajas al trabajar activamente el músculo del cerebro, funciona como un buen gimnasio mental. Concluímos que el ajedrez es excelente para la menta y todo lo que interconecta con ella. El mayor reto es aprender a jugarlo, así que te dejamos un vídeo que puede ayudarte al iniciar."
        sugerencia13.video="https://www.youtube.com/watch?v=vPcyQl5YLJY"
        sugerencia13.imagen = "https://image.ibb.co/heg4xH/ajedrez.png"
        sugerencia13.prioridad = 1
        sugerencia13.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia14 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia14.area = Int32(Area.Mental.rawValue)
        sugerencia14.titulo = "Pintar mandalas"
        sugerencia14.descripcion = "Una mandala tiene como definición una representación geométrica que tiene distintas interpretaciones según la forma, color, material y la cultura que lo representa. Posee grandes beneficios como: Elemento de apoyo en la meditación; Fomenta la paciencia y despierta los sentidos; Fortalece tu capacidad de concentración; Puedes deshacer bloqueos y tensiones internas y reducir el estrés y produce una sensación de bienestar general; Entrenan la memoria y desarrollar la creatividad; Ayuda a desconectar de las preocupaciones diarias; Puedes colorearlas de la manera tradicional y existen herramientas en línea que te ayudan a colorear de manera digital como el siguiente sitio web http://mandalas.dibujos.net"
        sugerencia14.imagen = "https://image.ibb.co/h3q8Px/mandala.png"
        sugerencia14.prioridad = 1
        sugerencia14.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia15 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia15.area = Int32(Area.Mental.rawValue)
        sugerencia15.titulo = "Arma un rompecabezas"
        sugerencia15.descripcion = "Los rompecabezas son divertidos y además promueve el uso del cerebro y de la imaginación. Te recomendamos tanto jugarlo solo o acompañado de familia, para pasar también un rato agradable con ellos. Y recuerda.. tendrás una gran sensación de satisfacción al terminarlo. Te recomendamos una aplicación con rompecabezas para tu iPhone llamada Jigsaw Puzzle."
        sugerencia15.imagen = "https://image.ibb.co/kHHoPx/puzzle.png"
        sugerencia15.prioridad = 1
        sugerencia15.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia16 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia16.area = Int32(Area.Mental.rawValue)
        sugerencia16.titulo = "Juega una partida de Sudoku"
        sugerencia16.descripcion = "La ventaja de este juego es que existen niveles para principiantes, intermedios y avanzados, y no es necesario ser un genio matemático para resolverlo. Sudoku es desafiante, mejora la memoria y estimula la mente, además de sentirte relajado y feliz. Te invadirá una sensación de satisfacción, de objetivo cumplido, cuando logres resolver un rompecabezas, especialmente los más difíciles. Existen aplicaciones en la AppStore como Sudoku - Prime Sudoku, en donde puedes encontrar este juego."
        sugerencia16.imagen = "https://image.ibb.co/iXLWcH/sudoku.png"
        sugerencia16.prioridad = 1
        sugerencia16.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia17 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia17.area = Int32(Area.Mental.rawValue)
        sugerencia17.titulo = "Resuelve un crucigrama"
        sugerencia17.descripcion = "Juegos como el crucigrama mejoran la memoria y pueden ayudar a mantener el cerebro hasta quince años más joven en las personas que han superado los sesenta. Te recomendamos la aplicación de “Crucigramas Free” para probar con algunos, o puedes hacerlo de la forma tradicional con libros de crucigramas. Si dispones de una computadora, existen páginas en internet como https://www.epasatiempos.es/crucigramas.php?cg=956  dónde avanzar de nivel conforme realizas distintos crucigramas."
        sugerencia17.imagen = "https://image.ibb.co/fKf8Px/crucigrama.png"
        sugerencia17.prioridad = 1
        sugerencia17.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia18 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia18.area = Int32(Area.Mental.rawValue)
        sugerencia18.titulo = "¡Abre tu mente y lee!"
        sugerencia18.descripcion = "Existe una gran gama de libros los cuales puedes leer. Recomendamos fuertemente el título de Yo de Mayor quiero ser Jóven de Leopoldo Abadía,  quién nos hace sonreír en su papel de persona octogenaria que se enfrenta a un mundo de mayores con la mentalidad fresca y entusiasta de un chaval. Si te interesan novelas históricas recomendamos El Jardinero del Rey de Frédéric Richaud, Los jugadores de Carlos Fortea y Por Amor al Emperador de Almudena de Arteaga. Te dejamos una página en donde encontrarás una mayor descripción de estos libros y te redireccionará a una página para comprarlo si es que así lo deseas. http://mayorescontablet.com/mejores-libros-personas-mayores-la-tercera-edad/ "
        sugerencia18.imagen = "https://image.ibb.co/gZCYrc/leer.png"
        sugerencia18.prioridad = 1
        sugerencia18.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia18.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia19 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia19.area = Int32(Area.Mental.rawValue)
        sugerencia19.titulo = "Hora de una partida de damas chinas"
        sugerencia19.descripcion = "Busca a algún familiar y juega una partida de damas chinas. Si no sabes las reglas del juego te dejamos este vídeo en donde puedes aprender el reglamente del juego https://www.youtube.com/watch?v=1s8VCq2Z5NE. En caso de querer realizar una partida desde una computadora te dejamos el siguiente juego http://www.minijuegos.com/juego/damas-chinas"
        sugerencia19.imagen = "https://image.ibb.co/gYRF4x/damaschinas.png"
        sugerencia19.prioridad = 1
        sugerencia19.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia20 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia20.area = Int32(Area.Mental.rawValue)
        sugerencia20.titulo = "¡Tiempo de Bordar!"
        sugerencia20.descripcion = "¿Conoces algunas técnicas para bordar? Es una actividad muy entretenida, donde puedes emplear tu creatividad y explotarla al máximo, realizando toda clase de cosas. Te dejamos un canal donde podrás encontrar diferentes vídeos con diversas técnicas de bordaje, desde lo básico hasta lo más avanzado. https://www.youtube.com/channel/UCU-ctOIc24UChAFxNDWqwog . Así mismo, te dejamos este vídeo con un ejemplo de las muchas creaciones que puedes hacer, la cual es una bolsa bordada con tu nombre. ¡Deja volar tu imaginación!"
        sugerencia20.video = "https://www.youtube.com/watch?v=pA_3RRn0rXA"
        sugerencia20.imagen = "https://image.ibb.co/hORF4x/bordar.png"
        sugerencia20.prioridad = 1
        sugerencia20.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia20.frecuenciaSemana = [true, false, true, false, true, false, false]
        
        let sugerencia21 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia21.area = Int32(Area.Financiero.rawValue)
        sugerencia21.titulo = "Ir a una cita con contador"
        sugerencia21.descripcion = "Es importante realizar una cita por lo menos 1 vez al mes a tu contador con el fin de observar cómo están tus gastos, entrega de facturas del mes, realizar su pago de honorarios si así es el caso y monitoreo de papelería de trámites o rentas. ¡Agenda tu cita con tu contador y verifica tus gastos!"
        sugerencia21.imagen = "https://image.ibb.co/hrZMpH/contador.png"
        sugerencia21.prioridad = 1
        sugerencia21.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia22 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia22.area = Int32(Area.Financiero.rawValue)
        sugerencia22.titulo = "Pagar servicio de luz"
        sugerencia22.descripcion = "No olvides realizar el pago de la energía eléctrica de tu casa o negocio. Este pago se hace de manera bimestral (en México) y verifica en tu recibo de pago la fecha límite para realizar el mismo. Si resides en México, puedes realizar el pago desde una computadora a través de la página de internet de la Comisión Federal de Electricidad. https://app.cfe.mx/ "
        sugerencia22.imagen = "https://image.ibb.co/nhT33c/electricidad.png"
        sugerencia22.prioridad = 1
        sugerencia22.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia23 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia23.area = Int32(Area.Financiero.rawValue)
        sugerencia23.titulo = "Pagar servicio de agua y drenaje"
        sugerencia23.descripcion = "¡Verifica en tu recibo de pago del servicio de agua y drenaje la fecha límite para realizar el pago y realízalo! Un consejo que te damos es que en algunos países de América Latina, existe tarifa para adultos de la tercera edad en uso doméstico. Puedes checar esta información con la compañía que te provee de este servicio."
        sugerencia23.imagen = "https://image.ibb.co/iywqic/aguaydrenaje.png"
        sugerencia23.prioridad = 1
        sugerencia23.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia24 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia24.area = Int32(Area.Financiero.rawValue)
        sugerencia24.titulo = "Retirar pensión del cajero"
        sugerencia24.descripcion = "¿Cuentas con pensión? No olvides retirarla el día en que sea depositada en tu cuenta o en cuanto te sea posible del cajero automático o en ventanilla desde tu banco. Si cuentas con tarjeta Mastercard, te dejamos esta página de internet donde puedes buscar el cajero más cercando en base a la dirección que escribas https://www.mastercard.com.co/es-co/consumidores/localiza-un-cajero-automatico.html . En caso de contar con tarjeta Visa, te dejamos esta página de internet https://www.visa.com/atmlocator/  "
        sugerencia24.imagen = "https://image.ibb.co/c2DE9H/pensioncajero.png"
        sugerencia24.prioridad = 1
        sugerencia24.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia25 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia25.area = Int32(Area.Financiero.rawValue)
        sugerencia25.titulo = "Ahorra con la ayuda de una aplicación"
        sugerencia25.descripcion = "¿Tienes algún viaje que quieres completar? ¿O algo que quieras comprar? Existen aplicaciones como piggo que te ayudan a realizar un estimado del dinero que requieres para cumplir tu meta, y te dice cuánto debes ahorrar por semana o mes. Podrás ir viendo como avanzas para llegar a tu meta."
        sugerencia25.imagen = "https://image.ibb.co/epTQGx/ahorrar.png"
        sugerencia25.prioridad = 1
        sugerencia25.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia26 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia26.area = Int32(Area.Financiero.rawValue)
        sugerencia26.titulo = "Registrar tus gastos diarios"
        sugerencia26.descripcion = "Verifica cada noche cuáles fueron los gastos que realizaste en el transcurso del día. Puedes registrarlos en una libreta o alguna aplicación, con el fin de no desbalancear tus egresos e ingresos. "
        sugerencia26.prioridad = 1
        sugerencia26.imagen = "https://image.ibb.co/kiZnUH/registrargastosdiarios.png"
        sugerencia26.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia26.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia27 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia27.area = Int32(Area.Financiero.rawValue)
        sugerencia27.titulo = "Planea tus gastos semanales"
        sugerencia27.descripcion = "Un día a la semana (te recomendamos que un domingo o un lunes) anota los gastos que realizarás en la semana con el monto aproximado. Durante la semana, podrás monitorear en base a este plan, si estás gastando más de lo que habías considerado. Esta técnica es muy práctica para mantener un historial de pagos y poder conocer en qué cosas gastas más dinero."
        sugerencia27.prioridad = 1
        sugerencia27.imagen = "https://image.ibb.co/cs7kGx/planeargastossemanales.png"
        sugerencia27.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia27.frecuenciaSemana = [false, false, false, false, false, false, true]
        
        //////////////////////////
        let sugerencia31 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia31.area = Int32(Area.Espiritual.rawValue)
        sugerencia31.titulo = "Ir a misa"
        sugerencia31.descripcion = "Ya sea asistir a misa dominical o a misa diaria, selecciona tus horarios favoritos y asiste a ello a la iglesia o templo que quede más cercano a tu localidad."
        sugerencia31.imagen = "https://image.ibb.co/dvoLic/misa.png"
        sugerencia31.prioridad = 1
        sugerencia31.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia31.frecuenciaSemana = [false, false, false, false, false, false, true]
        
        let sugerencia32 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia32.area = Int32(Area.Espiritual.rawValue)
        sugerencia32.titulo = "Realiza yoga"
        sugerencia32.descripcion = "El yoga puede ser una compañía para toda la vida, ayudándote a mantener un amplio rango de movilidad, flexibilidad, estabilidad, equilibrio físico y mental. Ayuda a mantener una buena actitud y estado de ánimo positivo. Se recomienda que se realicen ejercicios de yoga todos los días, para tener un cuerpo sano, flexible y ágil, así como, una mente despejada. Te dejamos este vídeo con algunos ejercicios de yoga, se recomienda realizarlo en un sitio abierto o bien ventilado, previo a ingerir alimentos y hacerlo con mucha calma para evitar algún esfuerzo de más del cuerpo."
        sugerencia32.video="https://youtu.be/F8bNQ7UWJII"
        sugerencia32.imagen = "https://image.ibb.co/c9MUbx/yoga.png"
        sugerencia32.prioridad = 1
        sugerencia32.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia32.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia33 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia33.area = Int32(Area.Espiritual.rawValue)
        sugerencia33.titulo = "Realiza oración"
        sugerencia33.descripcion = "Una fuerte conexión espiritual puede mejorar la satisfacción con la vida o facilitar el adaptarse a determinados impedimentos. De igual manera, las creencias religiosas o espirituales contribuyen a la habilidad para enfrentar efectivamente  la enfermedad, discapacidad y eventos negativos. Realiza una oración previo a dormir o al despertar."
        sugerencia33.imagen = "https://image.ibb.co/mOJaGx/oracion.png"
        sugerencia33.prioridad = 1
        sugerencia33.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia33.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia34 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia34.area = Int32(Area.Espiritual.rawValue)
        sugerencia34.titulo = "Ejercicios de autoestima"
        sugerencia34.descripcion = "Trabajando tu autoestima hace que llegues a tener una muy buena actitud  si trabajas con constancia y dedicación, sintiéndote mejor. Existen distintos ejercicios que pueden ayudarte a lograr tu objetivo, como los que aparecen en la siguiente página de internet https://www.lifeder.com/ejercicios-de-autoestima/ . Si te interesa saber más sobre los conceptos de la autoestima, te dejamos el siguiente vídeo para que escuches a expertos hablar de este tema"
        sugerencia34.imagen = "https://image.ibb.co/i2uFGx/autoestima.png"
        sugerencia34.video = "https://www.youtube.com/watch?v=Go70CF3DwTY"
        sugerencia34.prioridad = 1
        sugerencia34.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia34.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia35 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia35.area = Int32(Area.Espiritual.rawValue)
        sugerencia35.titulo = "Toma aire y sal al parque"
        sugerencia35.descripcion = "¡Date un respiro! Ve al parque y siéntete como nuevo. Al respirar aire fresco, tu cuerpo absorbe oxígeno, eliminando las toxinas del organismo. Adiós al estrés y hola a la relajación del sistema nervioso contribuyendo a un estado de bienestar general. Busca sitios abiertos cerca de tu hogar para salir por un momento en la tarde, justo cuando el sol comience a bajar."
        sugerencia35.imagen = "https://image.ibb.co/bTcrpH/parque.png"
        sugerencia35.prioridad = 1
        sugerencia35.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia35.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        let sugerencia36 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia36.area = Int32(Area.Espiritual.rawValue)
        sugerencia36.titulo = "Sal por un café con un viejo amigo"
        sugerencia36.descripcion = "¿En quién piensas cuando menciono la palabra Amigo? ¡Llámalo! Agenda una cita con él o ella para conversar por un rato y pasar un tiempo muy agradable. Te sugerimos ir por un café cercano a tu localidad, o ir a un restaurante por su comida favorita."
        sugerencia36.imagen = "https://image.ibb.co/iOVY3c/cafe.png"
        sugerencia36.prioridad = 1
        sugerencia36.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia37 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia37.area = Int32(Area.Espiritual.rawValue)
        sugerencia37.titulo = "Prueba la risoterapia"
        sugerencia37.descripcion = "Conocida también como terapia de la risa, libera tensiones y te ríes de forma natural por un momento.Se usan bailes, juegos y masajes para lograr causar risa en las personas. En el siguiente vídeo puedes conocer un poco más de los beneficios de la risoterapia, así como la inclusión de 5 ejercicios que puedes realizar para hacerla."
        sugerencia37.video="https://www.youtube.com/watch?v=U5533X-m-i8"
        sugerencia37.imagen = "https://image.ibb.co/j8Gj9H/risoterapia.png"
        sugerencia37.prioridad = 1
        sugerencia37.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia38 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia38.area = Int32(Area.Espiritual.rawValue)
        sugerencia38.titulo = "Meditacion"
        sugerencia38.descripcion = "La meditación es realmente importante en cualquier edad y otorga muchos beneficios como aumentar la longevidad, disminuye la soledad y mejorar la memoria, la mente y el estado de ánimo. Te recomendamos buscar un lugar cómodo y escuchar la siguiente meditación. ¡Relájate y disfruta!"
        sugerencia38.video="https://www.youtube.com/watch?v=zkbssc2d2lA"
        sugerencia38.imagen = "https://image.ibb.co/bVr6Oc/meditacion.png"
        sugerencia38.prioridad = 1
        sugerencia38.tipoFrecuencia = Int32(TipoFrecuencia.Uno.rawValue)
        
        let sugerencia39 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia39.area = Int32(Area.Espiritual.rawValue)
        sugerencia39.titulo = "Ve las noticias"
        sugerencia39.descripcion = "Conoce qué está pasando a tu alrededor, enciende la televisión y ve las noticias o lee el periódico. Si prefieres verificar las noticias desde tu celular, te recomendamos buscar tu periódico o noticiero favorito en la AppStore y descargar la aplicación. así mismo, puedes checar las noticias más recientes de tu localidad desde Google Noticias."
        sugerencia39.imagen = "https://image.ibb.co/mDB6Oc/noticias.png"
        sugerencia39.prioridad = 1
        sugerencia39.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia39.frecuenciaSemana = [true, true, true, true, true, true, true]
        
        
        let sugerencia40 = NSEntityDescription.insertNewObject(forEntityName: "Sugerencia", into: context) as! Sugerencia
        sugerencia40.area = Int32(Area.Espiritual.rawValue)
        sugerencia40.titulo = "Llama a tu familia"
        sugerencia40.descripcion = "Una llamada a tu nieto, hijo, hermano o familiar mejora tu día en su totalidad. Cuentales que ha pasado en tus días y pregúntale por los suyos. Hablar con la familia incrementa tu estado de ánimo."
        sugerencia40.imagen = "https://image.ibb.co/bC6HUH/familia.png"
        sugerencia40.prioridad = 1
        sugerencia40.tipoFrecuencia = Int32(TipoFrecuencia.Semanal.rawValue)
        sugerencia40.frecuenciaSemana = [true, false, false, true, false, false, true]
        

        
        do {
            try context.save()
        } catch let error as NSError {
            print("El contacto no fue guardado")
            print("Error \(error) \(error.userInfo)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaSugerencias.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SugerenciasTableViewCell
        let sugerencia = sugerenciasActuales [indexPath.row]
        cell.lbTitulo.text = sugerencia.titulo
       // cell.lbDetalle.text = sugerencia.descripcion
        if let imagen = sugerencia.imagen {
            print(imagen)
            let url = URL(string: imagen)
            do {
                let data = try Data(contentsOf: url!)
                cell.imagen.image = UIImage(data: data)
            } catch {
                
            }
        }
        return cell;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sugerenciasActuales.count
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item:UITabBarItem) {
        var items = (self.tabBarAreas.items as! [UITabBarItem])
        if item == items[0] {
            areaActual = Area.Fisico
        }
        else if item == items[1] {
            areaActual = Area.Mental
        }
        else if item == items[2] {
            areaActual = Area.Financiero
        }
        else if item == items[3] {
            areaActual = Area.Espiritual
        }
        print(areaActual)
        actualizarSugerencias()
    }
    
    func actualizarSugerencias() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchSugerencias = NSFetchRequest<NSFetchRequestResult>(entityName: "Sugerencia")
        fetchSugerencias.predicate = NSPredicate(format: "area == \(areaActual.rawValue)")
        fetchSugerencias.sortDescriptors = [NSSortDescriptor(key: #keyPath(Sugerencia.prioridad), ascending: true)]
        do {
            sugerenciasActuales = try context.fetch(fetchSugerencias) as! [Sugerencia]
        } catch {
            fatalError("Error: \(error)")
        }
        tablaSugerencias.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vista = segue.destination as! VerSugerenciaViewController
        let index = tablaSugerencias.indexPathForSelectedRow
        vista.sugerencia = sugerenciasActuales[(index?.row)!]
    }

}
